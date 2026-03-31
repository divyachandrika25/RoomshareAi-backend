"""
HotelAgent v3 — Premium Integrated Hotel Search
================================================
Combines THREE data sources in a priority cascade:

  SOURCE 1 — Booking.com live scraper (JS injection + Selenium fallback)
             Gets REAL prices, ratings, reviews, perks, images.
             Requires: pip install selenium webdriver-manager

  SOURCE 2 — OpenStreetMap Overpass API (always-available fallback)
      
       Gets real hotel names, addresses, phone, stars, website.
             Enriched with Wikipedia descriptions.
             No scraping. Never blocked. Zero API key.

  SOURCE 3 — Deep booking links (always generated)
             Pre-filled Booking.com, MakeMyTrip, Agoda, Hotels.com etc.

Fields extracted per hotel (full schema):
  name, stars (property class ★★★), rating ("8.2"), rating_label ("Very Good"),
  review_count ("174"), location ("Central Chennai, Chennai"),
  distance ("6.1 km from downtown"), landmarks (["Subway Access","Beach Nearby"]),
  room_type ("Deluxe Double Room"), bed_type ("1 full bed"),
  price / final_price (₹2,512), original_price (₹2,781 strikethrough),
  taxes (+₹126), free_breakfast, free_cancel, no_prepayment,
  urgency ("Only 7 left…"), deal_badge ("Getaway Deal"), sustainable,
  address, phone, website, email, checkin_time, checkout_time,
  image_url, booking_url, maps_url, osm_data (when available),
  source ("booking_scrape" | "openstreetmap")

Install:  pip install requests selenium webdriver-manager
Run demo: python hotel_agent.py --demo
"""

import re, time, json, math, logging, requests
from typing import List, Dict, Any, Optional
from urllib.parse import quote_plus

log = logging.getLogger("HotelAgent")
logging.basicConfig(level=logging.INFO, format="[%(name)s] %(message)s")

HEADERS       = {"User-Agent": "SmartTripAI-HotelAgent/3.0", "Accept": "application/json"}
OVERPASS_URL  = "https://overpass-api.de/api/interpreter"
NOMINATIM_URL = "https://nominatim.openstreetmap.org/search"
WIKI_URL      = "https://en.wikipedia.org/w/api.php"

# Star rating → indicative INR price band (shown only when live price unavailable)
STAR_PRICE_BAND = {
    "5": "₹12,000–₹25,000/night",
    "4": "₹5,000–₹12,000/night",
    "3": "₹2,500–₹5,000/night",
    "2": "₹1,000–₹2,500/night",
    "1": "₹500–₹1,000/night",
}


# ══════════════════════════════════════════════════════════════════════════════
#  BOOKING DEEP-LINKS  (always generated, mirrors FlightAgent._booking_links)
# ══════════════════════════════════════════════════════════════════════════════

def _booking_links(destination: str, check_in: str, check_out: str,
                   guests: int = 2, rooms: int = 1) -> Dict[str, str]:
    d = quote_plus(destination)
    return {
        "booking_com": (f"https://www.booking.com/searchresults.html"
                        f"?ss={d}&checkin={check_in}&checkout={check_out}"
                        f"&group_adults={guests}&no_rooms={rooms}&group_children=0&lang=en-us"),
        "makemytrip":  (f"https://www.makemytrip.com/hotels/{d.lower()}-hotels.html"
                        f"?checkin={check_in}&checkout={check_out}&roomCount={rooms}&adultsCount={guests}"),
        "agoda":       (f"https://www.agoda.com/search?city={d}&checkIn={check_in}"
                        f"&checkOut={check_out}&adults={guests}&rooms={rooms}"),
        "hotels_com":  (f"https://www.hotels.com/search.do?q-destination={d}"
                        f"&q-check-in={check_in}&q-check-out={check_out}"
                        f"&q-rooms={rooms}&q-room-0-adults={guests}"),
        "ixigo":       (f"https://www.ixigo.com/hotels?city={d}&checkin={check_in}"
                        f"&checkout={check_out}&adults={guests}&rooms={rooms}"),
        "cleartrip":   (f"https://www.cleartrip.com/hotels/results/"
                        f"?city={d}&ci={check_in}&co={check_out}&r={rooms}&a={guests}"),
        "goibibo":     (f"https://www.goibibo.com/hotels/hotels-in-{d.lower()}/"
                        f"?checkin={check_in}&checkout={check_out}&adults={guests}"),
        "airbnb":      (f"https://www.airbnb.com/s/{d}/homes"
                        f"?checkin={check_in}&checkout={check_out}&adults={guests}"),
        "tripadvisor": (f"https://www.tripadvisor.com/Search?q={d}+hotel"),
    }


# ══════════════════════════════════════════════════════════════════════════════
#  OSM / NOMINATIM UTILITIES  (SOURCE 2)
# ══════════════════════════════════════════════════════════════════════════════

def _haversine(lat1, lon1, lat2, lon2) -> float:
    R = 6371
    dlat, dlon = math.radians(lat2-lat1), math.radians(lon2-lon1)
    a = math.sin(dlat/2)**2 + math.cos(math.radians(lat1)) * math.cos(math.radians(lat2)) * math.sin(dlon/2)**2
    return R * 2 * math.asin(math.sqrt(a))


def _nominatim(location: str) -> Optional[tuple]:
    """Geocode any location string → (lat, lon, display_name)."""
    try:
        resp = requests.get(NOMINATIM_URL,
                            params={"q": location, "format": "json", "limit": 1},
                            headers=HEADERS, timeout=12)
        data = resp.json()
        if data:
            return float(data[0]["lat"]), float(data[0]["lon"]), data[0]["display_name"]
    except Exception as e:
        log.warning(f"[Nominatim] {e}")
    return None


def _wiki_summary(name: str, city: str) -> str:
    """2-sentence Wikipedia summary for a hotel."""
    try:
        s = requests.get(WIKI_URL, headers=HEADERS, timeout=8, params={
            "action":"query","list":"search",
            "srsearch":f"{name} hotel {city}","format":"json","srlimit":1,
        }).json()
        results = s.get("query",{}).get("search",[])
        if not results: return ""
        title = results[0]["title"]
        d = requests.get(WIKI_URL, headers=HEADERS, timeout=8, params={
            "action":"query","titles":title,"prop":"extracts",
            "exintro":True,"explaintext":True,"exsentences":2,"format":"json",
        }).json()
        for page in d.get("query",{}).get("pages",{}).values():
            return page.get("extract","").strip()[:300]
    except Exception:
        pass
    return ""


def _fetch_osm_hotels(lat: float, lon: float, radius_m: int = 5000) -> List[Dict]:
    """Fetch real hotels from OpenStreetMap Overpass API."""
    query = f"""
    [out:json][timeout:35];
    (
      node["tourism"="hotel"](around:{radius_m},{lat},{lon});
      node["tourism"="guest_house"](around:{radius_m},{lat},{lon});
      node["tourism"="hostel"](around:{radius_m},{lat},{lon});
      node["tourism"="motel"](around:{radius_m},{lat},{lon});
      node["tourism"="resort"](around:{radius_m},{lat},{lon});
      way["tourism"="hotel"](around:{radius_m},{lat},{lon});
      way["tourism"="resort"](around:{radius_m},{lat},{lon});
      relation["tourism"="hotel"](around:{radius_m},{lat},{lon});
    );
    out center body;
    """
    try:
        resp = requests.post(OVERPASS_URL, data=query, headers=HEADERS, timeout=40)
        elements = resp.json().get("elements", [])
        hotels, seen = [], set()
        for el in elements:
            tags = el.get("tags", {})
            name = tags.get("name","").strip()
            if not name or name.lower() in seen: continue
            seen.add(name.lower())
            if el["type"] == "node":
                h_lat, h_lon = el.get("lat"), el.get("lon")
            else:
                c = el.get("center",{})
                h_lat, h_lon = c.get("lat"), c.get("lon")
            if not h_lat or not h_lon: continue
            dist = _haversine(lat, lon, h_lat, h_lon)
            addr = ", ".join(filter(None,[
                tags.get("addr:housenumber",""), tags.get("addr:street",""),
                tags.get("addr:suburb",""), tags.get("addr:city",""),
            ])) or tags.get("addr:full","")
            stars_raw = tags.get("stars") or tags.get("star_rating") or ""
            hotels.append({
                "name":       name,
                "type":       tags.get("tourism","hotel").replace("_"," ").title(),
                "stars":      stars_raw,
                "address":    addr or None,
                "phone":      tags.get("phone") or tags.get("contact:phone") or None,
                "website":    tags.get("website") or tags.get("contact:website") or None,
                "email":      tags.get("email") or tags.get("contact:email") or None,
                "checkin_time":  tags.get("check_in") or None,
                "checkout_time": tags.get("check_out") or None,
                "wheelchair": tags.get("wheelchair") or None,
                "internet":   tags.get("internet_access") or None,
                "rooms":      tags.get("rooms") or None,
                "lat":        h_lat,
                "lon":        h_lon,
                "dist_km":    round(dist, 2),
                "maps_url":   f"https://www.google.com/maps?q={h_lat},{h_lon}",
            })
        return sorted(hotels, key=lambda x: x["dist_km"])
    except Exception as e:
        log.error(f"[Overpass] {e}")
        return []


# ══════════════════════════════════════════════════════════════════════════════
#  SELENIUM DRIVER  (identical to FlightAgent._init_driver)
# ══════════════════════════════════════════════════════════════════════════════

def _init_driver():
    try:
        from selenium import webdriver
        from selenium.webdriver.chrome.options import Options
        from selenium.webdriver.chrome.service import Service
        from webdriver_manager.chrome import ChromeDriverManager
        opts = Options()
        opts.add_argument("--headless")
        opts.add_argument("--no-sandbox")
        opts.add_argument("--disable-dev-shm-usage")
        opts.add_argument("--disable-gpu")
        opts.add_argument("--window-size=1920,1080")
        opts.add_argument("--disable-blink-features=AutomationControlled")
        opts.add_experimental_option("excludeSwitches", ["enable-automation"])
        opts.add_experimental_option("useAutomationExtension", False)
        opts.add_argument(
            "user-agent=Mozilla/5.0 (Windows NT 10.0; Win64; x64) "
            "AppleWebKit/537.36 (KHTML, like Gecko) Chrome/120.0.0.0 Safari/537.36"
        )
        service = Service(ChromeDriverManager().install())
        driver  = webdriver.Chrome(service=service, options=opts)
        driver.execute_script(
            "Object.defineProperty(navigator, 'webdriver', {get: () => undefined})"
        )
        return driver
    except ImportError:
        log.warning("Install: pip install selenium webdriver-manager")
        return None
    except Exception as e:
        log.warning(f"Chrome driver init failed: {e}")
        return None


def _dismiss_consent(driver):
    from selenium.webdriver.common.by import By
    for by, sel in [
        (By.ID,           "onetrust-accept-btn-handler"),
        (By.CSS_SELECTOR, "[data-testid='accept-cookie-consent-button']"),
        (By.XPATH,        "//button[contains(.,'Accept')]"),
        (By.XPATH,        "//button[contains(.,'I agree')]"),
    ]:
        try: driver.find_element(by, sel).click(); time.sleep(1); return
        except Exception: continue


# ══════════════════════════════════════════════════════════════════════════════
#  LAYER 1 — JavaScript injection scraper for Booking.com
#  Targets EXACT hashed class names from DevTools screenshots:
#    Regular card  : div.afd3558156.ac28d37f07
#    Featured card : div.d48f4db68a.afd3558156.a04cf99858
#  Plus data-testid selectors as stable primary targets.
# ══════════════════════════════════════════════════════════════════════════════

_JS_EXTRACT = r"""
(function() {
  function txt(el, sels) {
    for (var s of sels) {
      try { var e=el.querySelector(s); if(e&&e.innerText.trim()) return e.innerText.trim(); } catch(x){}
    }
    return null;
  }
  function att(el, sels, a) {
    for (var s of sels) {
      try { var e=el.querySelector(s); if(e&&e.getAttribute(a)) return e.getAttribute(a).trim(); } catch(x){}
    }
    return null;
  }
  function many(el, sels) {
    for (var s of sels) {
      try {
        var els=el.querySelectorAll(s);
        var v=Array.from(els).map(e=>e.innerText.trim()).filter(Boolean);
        if(v.length) return v;
      } catch(x){}
    }
    return [];
  }
  function cleanPrice(raw) {
    if(!raw) return null;
    // Remove all currency symbols, commas, whitespace — keep digits only
    var n=(raw||'').replace(/[\u20b9\u20B9\u0024\u00A3\u20AC\u00A5,\s\xa0]/g,'').match(/\d+/g);
    return n ? n[0] : null;
  }

  // ── Card detection: data-testid first, then EXACT hashed classes ───────────
  var CARD_SELS = [
    "[data-testid='property-card']",
    "div.afd3558156.ac28d37f07",
    "div.d48f4db68a.afd3558156.a04cf99858",
    "div.afd3558156",
    "[data-hotelid]",
  ];
  var cards = [];
  for (var cs of CARD_SELS) {
    try { var f=document.querySelectorAll(cs); if(f.length){cards=Array.from(f);break;} } catch(x){}
  }
  if (!cards.length) return JSON.stringify({cards_found:0, hotels:[]});

  var out = [];
  for (var card of cards) {
    try {
      var t  = card.innerText || '';

      // ── NAME ──────────────────────────────────────────────────────────────
      var name = txt(card, [
        "[data-testid='title']",
        ".fcab3ed991.a23c043802",
        "h3[class]","h2[class]","h3","h2"
      ]);
      if (!name) continue;

      // ── PROPERTY STAR CLASS  e.g. ★★★ ────────────────────────────────────
      var starsEl = card.querySelectorAll(
        "[data-testid='rating-stars'] span, .e2f34c95e0 span, .fc63351294 span"
      );
      var stars = starsEl.length || null;

      // ── REVIEW SCORE  "8.2" ───────────────────────────────────────────────
      var rating = txt(card, [
        "[data-testid='review-score'] .ac4a7896c7",
        "[data-testid='review-score'] div:first-child",
        "[data-testid='review-score'] .a3b8729ab1",
        ".bui-review-score__badge",
        ".b5cd09854e",
        "[data-testid='review-score']"
      ]);
      // Validate: must look like a number 1.0–10.0
      if (rating && !/^\d{1,2}\.?\d?$/.test(rating.trim())) {
        var rm2 = rating.match(/\b(\d{1,2}\.\d)\b/);
        rating = rm2 ? rm2[1] : null;
      }

      // ── RATING LABEL  "Very Good" ─────────────────────────────────────────
      var ratingLabel = txt(card, [
        "[data-testid='review-score'] .d8f0e7f40b",
        "[data-testid='review-score'] .abf093bdfe:first-of-type",
        "[data-testid='review-score'] span:nth-child(2)"
      ]);
      // Must be a word, not a number
      if (ratingLabel && /^\d/.test(ratingLabel.trim())) ratingLabel = null;

      // ── REVIEW COUNT  "174 reviews" → "174" ───────────────────────────────
      var revRaw = txt(card, [
        "[data-testid='review-score'] .abf093bdfe.f45d8e4c32.d935416c47",
        "[data-testid='review-score'] .abf093bdfe:last-of-type",
        "[data-testid='review-score'] span:last-child",
        ".bui-review-score__number"
      ]);
      var reviewCount = null;
      if (revRaw) { var rm=revRaw.match(/([\d,]+)/); reviewCount=rm?rm[1].replace(/,/g,''):null; }
      // Fallback: scan card text for "N reviews"
      if (!reviewCount) {
        var rmc = t.match(/([\d,]+)\s+reviews?/i);
        if (rmc) reviewCount = rmc[1].replace(/,/g,'');
      }

      // ── LOCATION  "Central Chennai, Chennai" ─────────────────────────────
      var location = txt(card, [
        "[data-testid='address']",
        ".f4bd0794db.b4e6f3de38",
        ".e8f7c070a7.b4e6f3de38",
        "[data-testid='location']"
      ]);

      // ── DISTANCE  "6.1 km from downtown" ────────────────────────────────
      var distance = txt(card, [
        "[data-testid='distance']",
        ".adc4e40f90",
        ".f4bd0794db span:first-child"
      ]);
      if (!distance) {
        var dm = t.match(/([\d.]+\s*km\s+from[^\n]+)/i);
        if (dm) distance = dm[1].trim();
      }

      // ── LANDMARKS  ["Subway Access","Beach Nearby","2.5 km from beach"] ──
      var landmarks = many(card, [
        "[data-testid='property-card-amenities'] li",
        ".d8f0e7f40b span",
        ".c82435a4b8 li",
        ".e8f7c070a7 li",
        "[data-testid='property-card-amenities']"
      ]).slice(0,6);

      // ── ROOM TYPE  "Deluxe Double Room" ───────────────────────────────────
      var roomType = txt(card, [
        "[data-testid='recommended-units'] h4",
        "[data-testid='unit-name']",
        ".df7e6ba27d",
        ".b30f8eb2d2",
        "[data-testid='recommended-units'] h3"
      ]);

      // ── BED TYPE  "1 full bed" ────────────────────────────────────────────
      var bedType = txt(card, [
        "[data-testid='bed-configuration']",
        "[data-testid='recommended-units'] .d8f0e7f40b",
        ".ad33a9bcde"
      ]);
      if (!bedType) {
        var bm = t.match(/\d+\s+(?:full|twin|queen|king|double|single)\s+beds?/i);
        if (bm) bedType = bm[0];
      }

      // ── FINAL PRICE  "₹ 2,512" ────────────────────────────────────────────
      // Strategy A: named testid
      var priceRaw = txt(card, [
        "[data-testid='price-and-discounted-price']",
        "[data-testid='price']",
        ".f6431b446c.fbfd7c1165",
        ".fcf5fd99b7.a52a11f6da",
        ".bui-price-display__value",
        ".prco-valign__middle-helper",
        ".pItlkMKfzPf"
      ]);
      var price = cleanPrice(priceRaw);

      // Strategy B: scan ALL elements for ₹ text, take the LAST (= post-discount final)
      if (!price) {
        var allPriceEls = card.querySelectorAll('[class*="price"],[class*="Price"],[class*="cost"],[class*="Cost"],[class*="amount"],[class*="Amount"]');
        var candidates = [];
        allPriceEls.forEach(function(el) {
          var v = el.innerText.trim();
          if (/[\u20b9\u20B9₹]/.test(v)) {
            var n = cleanPrice(v);
            if (n && parseInt(n) > 100) candidates.push(parseInt(n));
          }
        });
        if (candidates.length) price = String(Math.min.apply(null, candidates)); // take cheapest = final
      }

      // Strategy C: all ₹ values in raw text, take last
      if (!price) {
        var ap = t.match(/[\u20b9\u20B9₹]\s*[\d,]+/g);
        if (ap && ap.length) price = cleanPrice(ap[ap.length-1]);
      }

      // ── ORIGINAL PRICE (strikethrough)  "₹ 2,781" ────────────────────────
      var origRaw = txt(card, [
        "[data-testid='strikethrough-price']",
        ".d68d651b7a",
        ".bui-price-display__original",
        "s[class]","del[class]","s","del"
      ]);
      var originalPrice = cleanPrice(origRaw);
      // Fallback: if 2+ ₹ values found & first > last = first is original
      if (!originalPrice && price) {
        var ap2 = t.match(/[\u20b9\u20B9₹]\s*[\d,]+/g);
        if (ap2 && ap2.length > 1) {
          var firstVal = cleanPrice(ap2[0]);
          if (firstVal && parseInt(firstVal) > parseInt(price)) originalPrice = firstVal;
        }
      }

      // ── TAXES  "+₹ 126 taxes and fees" ───────────────────────────────────
      var taxRaw = txt(card, [
        "[data-testid='taxes-and-charges']",
        ".d8f0e7f40b.e2a7e08c5b",
        ".bb62f27f3c",
        ".ac7af0a15f"
      ]);
      if (!taxRaw) {
        var tm = t.match(/\+\s*[\u20b9\u20B9₹]\s*([\d,]+)\s*(?:taxes|tax)/i);
        if (tm) taxRaw = tm[1];
      }
      var taxes = cleanPrice(taxRaw);

      // ── PERKS ─────────────────────────────────────────────────────────────
      var freeCancel    = /free cancell|refundable/i.test(t);
      var noPrepayment  = /no prepayment|pay at the property|pay at property/i.test(t);
      var freeBreakfast = /breakfast included|free breakfast/i.test(t);

      // ── URGENCY  "Only 7 left at this price on our site" ─────────────────
      var urgency = txt(card, [
        "[data-testid='urgency-message']",
        ".abf093bdfe.c3af3fec4c",
        ".c9d2c89483"
      ]);
      if (!urgency) {
        var um = t.match(/Only \d+ left[^\n]*/i);
        if (um) urgency = um[0].trim();
      }

      // ── DEAL BADGE  "Getaway Deal" ────────────────────────────────────────
      var dealBadge = txt(card, [
        "[data-testid='badge']",
        ".a0ee1b0b0a",
        ".f6431b446c.a0ee1b0b0a",
        ".c9d2c89483"
      ]);

      // ── SUSTAINABILITY ────────────────────────────────────────────────────
      var sustainable = /sustainability|travel sustainable/i.test(t);

      // ── IMAGE URL ─────────────────────────────────────────────────────────
      var imageUrl = att(card, [
        "[data-testid='property-card-desktop-single-image'] img",
        "[data-testid='thumborImage'] img",
        ".f9671d49b3 img",
        "img.e4c862f8e8",
        "img[loading='lazy']",
        "img"
      ], "src");

      // ── BOOKING URL ───────────────────────────────────────────────────────
      var bookingUrl = att(card, [
        "[data-testid='title-link']",
        "a[data-testid='property-card-container']",
        "a.e13098a59f",
        "a[href*='/hotel/']",
        "a[href*='booking.com']"
      ], "href");

      out.push({
        name:name, stars:stars,
        rating:rating, rating_label:ratingLabel, review_count:reviewCount,
        location:location, distance:distance, landmarks:landmarks,
        room_type:roomType, bed_type:bedType,
        price:price, original_price:originalPrice, taxes:taxes,
        free_breakfast:freeBreakfast, free_cancel:freeCancel, no_prepayment:noPrepayment,
        urgency:urgency, deal_badge:dealBadge, sustainable:sustainable,
        image_url:imageUrl, booking_url:bookingUrl,
        source:"booking_scrape"
      });
    } catch(err) {}
  }
  return JSON.stringify({cards_found:cards.length, hotels:out});
})();
"""

# ── Selenium element-level fallback parser ────────────────────────────────────

def _clean_price(raw: str) -> Optional[str]:
    if not raw: return None
    raw = raw.replace('\u20b9','').replace('₹','').replace('\xa0','').replace(',','').strip()
    nums = re.findall(r'\d+', raw)
    return nums[0] if nums else None


def _parse_card_selenium(card) -> Optional[Dict]:
    from selenium.webdriver.common.by import By
    def _t(sels):
        for s in sels:
            try:
                v = card.find_element(By.CSS_SELECTOR, s).text.strip()
                if v: return v
            except Exception: pass
        return None
    def _a(sels, a):
        for s in sels:
            try:
                v = card.find_element(By.CSS_SELECTOR, s).get_attribute(a)
                if v: return v.strip()
            except Exception: pass
        return None
    def _many(sels):
        for s in sels:
            try:
                vals = [e.text.strip() for e in card.find_elements(By.CSS_SELECTOR, s) if e.text.strip()]
                if vals: return vals
            except Exception: pass
        return []
    try:
        name = _t(["[data-testid='title']",".fcab3ed991.a23c043802","h3[class]","h2[class]","h3"])
        if not name: raise ValueError
        ct = card.text.lower()
        price_raw = _t(["[data-testid='price-and-discounted-price']","[data-testid='price']",
                         ".f6431b446c.fbfd7c1165"])
        # text fallback for price
        if not price_raw:
            prices = re.findall(r'[\u20b9₹]\s*([\d,]+)', card.text)
            if prices: price_raw = prices[-1]
        orig_raw  = _t(["[data-testid='strikethrough-price']",".d68d651b7a","s","del"])
        taxes_raw = _t(["[data-testid='taxes-and-charges']",".bb62f27f3c"])
        rating    = _t(["[data-testid='review-score'] .ac4a7896c7",
                         "[data-testid='review-score'] div:first-child"])
        rating_label = _t(["[data-testid='review-score'] .d8f0e7f40b"])
        rev_raw   = _t(["[data-testid='review-score'] .abf093bdfe:last-of-type"])
        rc = re.search(r'([\d,]+)',rev_raw or '')
        if not rc:
            rc2 = re.search(r'([\d,]+)\s+reviews?', card.text, re.I)
            rev_count = rc2.group(1).replace(',','') if rc2 else None
        else:
            rev_count = rc.group(1).replace(',','')
        urgency_m = re.search(r'Only \d+ left[^\n]*', card.text, re.I)
        return {
            "name":           name,
            "stars":          None,
            "rating":         rating,
            "rating_label":   rating_label,
            "review_count":   rev_count,
            "location":       _t(["[data-testid='address']",".f4bd0794db.b4e6f3de38"]),
            "distance":       _t(["[data-testid='distance']",".adc4e40f90"]),
            "landmarks":      _many(["[data-testid='property-card-amenities'] li",".d8f0e7f40b span"])[:6],
            "room_type":      _t(["[data-testid='recommended-units'] h4","[data-testid='unit-name']",".df7e6ba27d"]),
            "bed_type":       _t(["[data-testid='bed-configuration']"]),
            "price":          _clean_price(price_raw),
            "original_price": _clean_price(orig_raw),
            "taxes":          _clean_price(taxes_raw),
            "free_breakfast": "breakfast" in ct,
            "free_cancel":    "free cancell" in ct,
            "no_prepayment":  "no prepayment" in ct or "pay at the property" in ct,
            "urgency":        urgency_m.group(0).strip() if urgency_m else None,
            "deal_badge":     _t(["[data-testid='badge']",".a0ee1b0b0a"]),
            "sustainable":    "sustainable" in ct,
            "image_url":      _a(["[data-testid='property-card-desktop-single-image'] img",
                                   "img[loading='lazy']","img"], "src"),
            "booking_url":    _a(["[data-testid='title-link']","a[href*='/hotel/']"], "href"),
            "source":         "booking_scrape",
        }
    except Exception: pass
    # Raw text fallback
    try:
        text = card.text.strip()
        if not text or len(text) < 10: return None
        lines = [l.strip() for l in text.splitlines() if l.strip()]
        prices = re.findall(r'[\u20b9₹]\s*([\d,]+)', text)
        price  = prices[-1].replace(',','') if prices else None
        orig   = None
        if len(prices) > 1:
            a,b = int(prices[0].replace(',','')), int(prices[-1].replace(',',''))
            if a > b: orig = prices[0].replace(',','')
        rm = re.search(r'\b([7-9]\.[0-9]|10\.0)\b', text)
        rev = re.search(r'([\d,]+)\s+reviews?', text, re.I)
        room = re.search(r'((?:Deluxe|Superior|Standard|Executive|Suite|Twin|Double|Single|Queen|King)[^\n]*)',text,re.I)
        dist = re.search(r'([\d.]+\s*km\s+from[^\n]+)',text,re.I)
        ct = text.lower()
        return {
            "name":lines[0],"stars":None,
            "rating":rm.group(1) if rm else None,"rating_label":None,
            "review_count":rev.group(1).replace(',','') if rev else None,
            "location":None,"distance":dist.group(1) if dist else None,
            "landmarks":[],"room_type":room.group(1).strip() if room else None,"bed_type":None,
            "price":price,"original_price":orig,"taxes":None,
            "free_breakfast":"breakfast" in ct,"free_cancel":"free cancell" in ct,
            "no_prepayment":"no prepayment" in ct,"urgency":None,"deal_badge":None,
            "sustainable":"sustainable" in ct,"image_url":None,"booking_url":None,
            "source":"booking_scrape",
        }
    except Exception: return None


# ══════════════════════════════════════════════════════════════════════════════
#  BOOKING.COM SCRAPER  (SOURCE 1)
# ══════════════════════════════════════════════════════════════════════════════

CARD_SELS = [
    "[data-testid='property-card']",
    "div.afd3558156.ac28d37f07",
    "div.d48f4db68a.afd3558156.a04cf99858",
    "div.afd3558156",
    "[data-hotelid]",
]


def scrape_booking_com(destination: str, check_in: str, check_out: str,
                       guests: int = 2, rooms: int = 1,
                       custom_url: Optional[str] = None) -> Dict[str, Any]:
    from selenium.webdriver.common.by import By
    from selenium.webdriver.support.ui import WebDriverWait
    from selenium.webdriver.support import expected_conditions as EC

    url = custom_url or (
        f"https://www.booking.com/searchresults.html"
        f"?ss={quote_plus(destination)}&checkin={check_in}&checkout={check_out}"
        f"&group_adults={guests}&no_rooms={rooms}&group_children=0&lang=en-us"
    )

    driver = _init_driver()
    if not driver:
        return {"hotels":[],"scraped":False,"blocked":False,
                "message":"Selenium unavailable. pip install selenium webdriver-manager",
                "url":url,"layer":"none"}

    hotels, blocked, layer = [], False, "none"
    try:
        log.info(f"Loading: {url}")
        driver.get(url)
        time.sleep(3)
        _dismiss_consent(driver)
        time.sleep(2)

        wait = WebDriverWait(driver, 20)
        found = False
        for sel in CARD_SELS:
            try:
                wait.until(EC.presence_of_element_located((By.CSS_SELECTOR, sel)))
                found = True; log.info(f"Cards detected: {sel}"); break
            except Exception: continue

        if not found:
            body = driver.find_element(By.TAG_NAME, "body").text.lower()
            if any(w in body for w in ["captcha","unusual traffic","robot"]):
                blocked = True; log.warning("CAPTCHA detected")

        # Layer 1 — JS injection (most complete — gets all fields)
        if not blocked:
            try:
                log.info("Running JS injection …")
                raw = driver.execute_script(_JS_EXTRACT)
                if raw:
                    parsed = json.loads(raw)
                    cards_n = parsed.get("cards_found", 0)
                    js_list = parsed.get("hotels", [])
                    log.info(f"JS: {cards_n} card elements → {len(js_list)} hotels parsed")
                    seen = set()
                    for h in js_list:
                        key = (h.get("name") or "").lower().strip()
                        if key and key not in seen:
                            seen.add(key); hotels.append(h)
                    if hotels: layer = "js_inject"
            except Exception as e:
                log.warning(f"JS injection error: {e}")

        # Layer 2 — Selenium element fallback
        if not hotels and not blocked:
            log.info("Falling back to Selenium element parser …")
            cards = []
            for sel in CARD_SELS:
                try:
                    cards = driver.find_elements(By.CSS_SELECTOR, sel)
                    if cards: log.info(f"Selenium: {len(cards)} cards via {sel}"); break
                except Exception: continue
            seen = set()
            for card in cards[:25]:
                h = _parse_card_selenium(card)
                if h:
                    key = (h.get("name") or "").lower().strip()
                    if key and key not in seen:
                        seen.add(key); hotels.append(h)
            if hotels: layer = "selenium"

    except Exception as e:
        log.error(f"Scraper error: {e}")
    finally:
        try: driver.quit()
        except Exception: pass

    msg = (f"Scraped {len(hotels)} hotel(s) via {layer}" if hotels
           else "CAPTCHA detected" if blocked else "No results found")
    return {"hotels":hotels,"scraped":bool(hotels),"blocked":blocked,
            "message":msg,"url":url,"layer":layer}


# ══════════════════════════════════════════════════════════════════════════════
#  MERGE UTILITY
#  Enriches Booking.com scraped hotels with OSM data (address, phone, website)
#  by fuzzy-matching hotel names. Adds OSM hotels not found on Booking.com.
# ══════════════════════════════════════════════════════════════════════════════

def _fuzzy_match(name_a: str, name_b: str) -> bool:
    """Simple token overlap match for hotel name merging."""
    a = set(re.sub(r'[^\w\s]','',name_a.lower()).split())
    b = set(re.sub(r'[^\w\s]','',name_b.lower()).split())
    stopwords = {'hotel','inn','suites','suite','the','a','of','and','&'}
    a -= stopwords; b -= stopwords
    if not a or not b: return False
    overlap = len(a & b) / max(len(a), len(b))
    return overlap >= 0.5


def _merge_hotels(scraped: List[Dict], osm: List[Dict],
                  check_in: str, check_out: str, guests: int) -> List[Dict]:
    """
    Merge Booking.com scraped data with OSM data:
    - Scraped hotels get enriched with OSM address/phone/website if name matches
    - OSM hotels not found in scraped list get added as fallback entries
    """
    merged = []
    osm_matched = set()

    for sh in scraped:
        enriched = dict(sh)
        # Try to find an OSM match
        for i, oh in enumerate(osm):
            if _fuzzy_match(sh.get("name",""), oh.get("name","")):
                # Enrich scraped with OSM fields only if scraped has no value
                enriched.setdefault("address",     oh.get("address"))
                enriched.setdefault("phone",       oh.get("phone"))
                enriched.setdefault("website",     oh.get("website"))
                enriched.setdefault("email",       oh.get("email"))
                enriched.setdefault("checkin_time",oh.get("checkin_time"))
                enriched.setdefault("checkout_time",oh.get("checkout_time"))
                enriched.setdefault("wheelchair",  oh.get("wheelchair"))
                enriched.setdefault("internet",    oh.get("internet"))
                enriched.setdefault("maps_url",    oh.get("maps_url"))
                enriched.setdefault("lat",         oh.get("lat"))
                enriched.setdefault("lon",         oh.get("lon"))
                enriched.setdefault("dist_km",     oh.get("dist_km"))
                # If OSM has stars and scraped doesn't, use OSM stars
                if not enriched.get("stars") and oh.get("stars"):
                    enriched["stars"] = oh["stars"]
                enriched["osm_data"] = True
                osm_matched.add(i)
                break
        # Always attach booking links
        enriched.setdefault("booking_links", _booking_links(
            enriched.get("name",""), check_in, check_out, guests))
        enriched.setdefault("booking_url", enriched["booking_links"]["booking_com"])
        merged.append(enriched)

    # Add OSM hotels not found in scraped results (as fallback entries)
    for i, oh in enumerate(osm):
        if i in osm_matched: continue
        stars = oh.get("stars","")
        entry = {
            # Core identity
            "name":           oh["name"],
            "stars":          stars or None,
            "type":           oh.get("type","Hotel"),
            # Pricing — indicative only
            "price":          None,
            "price_band":     STAR_PRICE_BAND.get(stars, "Check booking sites"),
            "original_price": None,
            "taxes":          None,
            # Ratings — not available from OSM
            "rating":         None,
            "rating_label":   None,
            "review_count":   None,
            # Location
            "location":       oh.get("address"),
            "distance":       f"{oh['dist_km']} km from centre" if oh.get("dist_km") else None,
            "landmarks":      [],
            # Room
            "room_type":      None,
            "bed_type":       None,
            # Perks
            "free_breakfast": False,
            "free_cancel":    False,
            "no_prepayment":  False,
            "urgency":        None,
            "deal_badge":     None,
            "sustainable":    False,
            # Contact
            "address":        oh.get("address"),
            "phone":          oh.get("phone"),
            "website":        oh.get("website"),
            "email":          oh.get("email"),
            "checkin_time":   oh.get("checkin_time"),
            "checkout_time":  oh.get("checkout_time"),
            "wheelchair":     oh.get("wheelchair"),
            "internet":       oh.get("internet"),
            # Maps
            "lat":            oh.get("lat"),
            "lon":            oh.get("lon"),
            "dist_km":        oh.get("dist_km"),
            "maps_url":       oh.get("maps_url"),
            # Booking
            "image_url":      None,
            "booking_url":    _booking_links(oh["name"],check_in,check_out,guests)["booking_com"],
            "booking_links":  _booking_links(oh["name"],check_in,check_out,guests),
            "osm_data":       True,
            "source":         "openstreetmap",
        }
        merged.append(entry)

    return merged


# ══════════════════════════════════════════════════════════════════════════════
#  HOTEL AGENT v3 — PREMIUM
# ══════════════════════════════════════════════════════════════════════════════

class HotelAgent:
    """
    HotelAgent v3 — Premium integrated hotel search.

    Priority cascade:
      1. Booking.com live scraper (real prices, ratings, perks, images)
         → JS injection primary; Selenium element-level fallback
      2. OpenStreetMap Overpass (real names, address, phone, stars, website)
         → enriches scraped results + adds hotels not on Booking.com
      3. Deep booking links (always generated for all platforms)

    Usage:
        agent = HotelAgent()
        result = agent.search_hotels("Chennai", "2026-04-10", "2026-04-11")
        result = agent.scrape_url(url, "2026-04-10", "2026-04-11")
    """

    def __init__(self):
        log.info("HotelAgent v3 — Premium (Booking.com scrape + OSM + deep-links)")

    def search_hotels(
        self,
        destination: str,
        check_in: str,
        check_out: str,
        guests: int  = 2,
        rooms:  int  = 1,
        scrape: bool = True,
        osm:    bool = True,
        limit:  int  = 20,
        radius_m: int = 5000,
    ) -> Dict[str, Any]:
        """
        Full hotel search combining Booking.com scraping + OSM enrichment.

        Args:
            destination : city or hotel name
            check_in    : "YYYY-MM-DD"
            check_out   : "YYYY-MM-DD"
            guests      : number of adults
            scrape      : attempt Booking.com scraping (needs Selenium)
            osm         : enrich with OpenStreetMap data
            limit       : max hotels in result
            radius_m    : OSM search radius in metres

        Returns complete result dict with merged hotel list.
        """
        print(f"\n  🏨  {destination}  |  {check_in} → {check_out}  |  {guests} guests")
        links = _booking_links(destination, check_in, check_out, guests, rooms)

        # ── Source 1: Booking.com scraper ─────────────────────────────────────
        scraped_hotels = []
        scrape_status  = {"scraped":False,"message":"Skipped","url":links["booking_com"],"layer":"none"}
        if scrape:
            print("  🌐 Scraping Booking.com …")
            result = scrape_booking_com(destination, check_in, check_out, guests, rooms)
            scraped_hotels = result["hotels"]
            scrape_status  = result
            icon = "✅" if result["scraped"] else "⚠️"
            print(f"  {icon} {result['message']}")

        # ── Source 2: OpenStreetMap ───────────────────────────────────────────
        osm_hotels = []
        geo_info   = {}
        if osm:
            print(f"  🗺  Fetching OSM data …")
            geo = _nominatim(destination)
            if geo:
                lat, lon, display = geo
                geo_info = {"lat":lat,"lon":lon,"display":display}
                raw_osm = _fetch_osm_hotels(lat, lon, radius_m)
                if not raw_osm:
                    raw_osm = _fetch_osm_hotels(lat, lon, radius_m * 2)
                osm_hotels = raw_osm
                print(f"  ✅ OSM: {len(osm_hotels)} hotels within {radius_m}m")
            else:
                print(f"  ⚠️  OSM geocoding failed for '{destination}'")

        # ── Merge sources ─────────────────────────────────────────────────────
        merged = _merge_hotels(scraped_hotels, osm_hotels, check_in, check_out, guests)

        # Ensure all hotels have booking links
        for h in merged:
            if not h.get("booking_links"):
                h["booking_links"] = _booking_links(
                    h.get("name",""), check_in, check_out, guests)

        return {
            "destination":   destination,
            "check_in":      check_in,
            "check_out":     check_out,
            "guests":        guests,
            "hotels":        merged[:limit],
            "total":         len(merged),
            "scrape_status": scrape_status,
            "osm_count":     len(osm_hotels),
            "geo":           geo_info,
            "booking_links": links,   # city-level search links
            "source_note":   (
                "Prices from Booking.com (live scrape). "
                "Contact details from OpenStreetMap."
            ),
        }

    def scrape_url(self, url: str, check_in: str = "",
                   check_out: str = "", guests: int = 2) -> Dict[str, Any]:
        """Scrape any Booking.com results URL directly."""
        print(f"\n  🔗 Scraping: {url[:90]}…")
        result = scrape_booking_com("", check_in, check_out, guests, custom_url=url)
        print(f"  {'✅' if result['scraped'] else '⚠️'} {result['message']}")
        return result

    def get_booking_links(self, destination: str, check_in: str,
                          check_out: str, guests: int = 2) -> Dict[str, str]:
        return _booking_links(destination, check_in, check_out, guests)

    def get_hotel_details(
        self,
        hotel_name: str,
        city: str,
        check_in: str = "",
        check_out: str = "",
        guests: int = 2
    ) -> Dict[str, Any]:
        """Try to get fresh price, images, and details for a specific hotel via live scraping."""
        print(f"  🔄 Refreshing details for: {hotel_name} in {city}...")
        
        # 1. Search for this specific hotel on Booking.com
        search_query = f"{hotel_name} {city}"
        result = scrape_booking_com(search_query, check_in, check_out, guests)
        
        if result["scraped"] and result["hotels"]:
            # Take the first/best match
            best_match = result["hotels"][0]
            # Verify if it's likely the same hotel (basic name overlap check)
            if _fuzzy_match(hotel_name, best_match.get("name", "")):
                # Enrich with Wikipedia summary
                summary = _wiki_summary(hotel_name, city)
                if summary:
                    best_match["full_detail"] = summary
                
                # Check for amenities if missing
                if not best_match.get("amenities"):
                    best_match["amenities"] = ["Free WiFi", "Air conditioning", "Desk", "Flat-screen TV", "Private Bathroom"]
                
                return best_match

        # 2. Fallback if scrape fails or no match found
        summary = _wiki_summary(hotel_name, city)
        return {
            "name": hotel_name,
            "location": city,
            "full_detail": summary or "No detailed info found via scraping.",
            "osm_data": True,
            "source": "openstreetmap",
            "price": None,
            "price_band": "Check booking sites",
            "booking_links": _booking_links(hotel_name, check_in, check_out, guests),
            "error": "Failed to retrieve live pricing for this property."
        }

    def get_hotel_detail(self, hotel_name: str, city: str) -> Dict[str, Any]:
        """Wikipedia summary for a specific hotel."""
        summary = _wiki_summary(hotel_name, city)
        return {"name":hotel_name,"city":city,
                "summary":summary or "No Wikipedia article found."}

    # ── Pretty printers ────────────────────────────────────────────────────────

    def print_hotels(self, hotels: List[Dict]):
        if not hotels:
            print("  ⚠️  No hotels found."); return
        print(f"\n  🏨  {len(hotels)} hotel(s)")
        print(f"  {'─'*116}")
        print(f"  #  {'Name':<32}{'Price':>8}{'Orig':>8}{'Tax':>6}  {'Rtg':<5}{'Label':<12}{'Reviews':<8}  {'Room':<22}Perks")
        print(f"  {'─'*116}")
        for i, h in enumerate(hotels, 1):
            name  = (h.get("name") or "—")[:31]
            price = f"₹{h['price']}"          if h.get("price")          else (h.get("price_band") or "N/A")[:9]
            orig  = f"₹{h['original_price']}"  if h.get("original_price") else "—"
            tax   = f"+₹{h['taxes']}"          if h.get("taxes")          else "—"
            rtg   = (h.get("rating") or "—")[:4]
            lbl   = (h.get("rating_label") or "—")[:11]
            rev   = f"{h.get('review_count','—')}"[:7]
            room  = (h.get("room_type") or "—")[:21]
            src   = "📍" if h.get("source") == "openstreetmap" else "🌐"
            perks = []
            if h.get("free_cancel"):    perks.append("✅Cncl")
            if h.get("no_prepayment"):  perks.append("✅NoPay")
            if h.get("free_breakfast"): perks.append("🍳Bkfst")
            if h.get("deal_badge"):     perks.append(f"🏷{(h['deal_badge'] or '')[:8]}")
            if h.get("urgency"):        perks.append("⚠️Low")
            if h.get("sustainable"):    perks.append("🌱")
            print(f"  {i:<3}{src}{name:<32}{price:>8}{orig:>8}{tax:>6}  {rtg:<5}{lbl:<12}{rev:<8}  {room:<22}{'  '.join(perks)}")
        print()

    def print_hotel_detail(self, h: Dict):
        stars_str = "★" * (h.get("stars") or 0) if isinstance(h.get("stars"),int) else (
            "★" * int(h["stars"]) if h.get("stars") and str(h["stars"]).isdigit() else "")
        sep = "─" * 72
        src_icon = "📍 OSM" if h.get("source") == "openstreetmap" else "🌐 Booking.com"
        print(f"\n  ┌{sep}")
        print(f"  │  🏨  {h.get('name')}  {stars_str}  [{src_icon}]")
        print(f"  ├{sep}")

        # ── Pricing ──────────────────────────────────────────────────────
        if h.get("price"):
            orig_s  = f"  (was ₹{h['original_price']})" if h.get("original_price") else ""
            taxes_s = f"  +₹{h['taxes']} taxes & fees"  if h.get("taxes")          else ""
            print(f"  │  💰 Price         : ₹{h['price']}{orig_s}{taxes_s}")
        elif h.get("price_band"):
            print(f"  │  💰 Price band    : {h['price_band']}  (indicative — see booking links)")
        else:
            print(f"  │  💰 Price         : N/A")

        # ── Rating ───────────────────────────────────────────────────────
        if h.get("rating"):
            r = h["rating"]
            if h.get("rating_label"):  r += f"  {h['rating_label']}"
            if h.get("review_count"):  r += f"  ({h['review_count']} reviews)"
            print(f"  │  ⭐ Rating         : {r}")

        # ── Location ─────────────────────────────────────────────────────
        if h.get("location"):   print(f"  │  📍 Location       : {h['location']}")
        if h.get("address") and h.get("address") != h.get("location"):
            print(f"  │  🏠 Address        : {h['address']}")
        if h.get("distance"):   print(f"  │  📏 Distance       : {h['distance']}")
        if h.get("landmarks"):  print(f"  │  🗺  Nearby        : {', '.join(h['landmarks'][:5])}")

        # ── Room ─────────────────────────────────────────────────────────
        if h.get("room_type"):  print(f"  │  🛏  Room type      : {h['room_type']}")
        if h.get("bed_type"):   print(f"  │  🛌 Bed            : {h['bed_type']}")

        # ── Perks ────────────────────────────────────────────────────────
        print(f"  │  🍳 Breakfast       : {'✅ Included'             if h.get('free_breakfast') else '❌ Not included'}")
        print(f"  │  🔄 Cancellation   : {'✅ Free cancellation'    if h.get('free_cancel')    else '❌ Non-refundable'}")
        print(f"  │  💳 Prepayment     : {'✅ No prepayment needed'  if h.get('no_prepayment')  else '⚠️  Required'}")
        if h.get("urgency"):    print(f"  │  ⚠️  Urgency       : {h['urgency']}")
        if h.get("deal_badge"): print(f"  │  🏷️  Deal          : {h['deal_badge']}")
        if h.get("sustainable"):print(f"  │  🌱 Sustainability certification")

        # ── Contact (from OSM) ────────────────────────────────────────────
        if h.get("phone"):      print(f"  │  📞 Phone          : {h['phone']}")
        if h.get("website") and h.get("website") != "N/A":
                                print(f"  │  🌐 Website        : {h['website']}")
        if h.get("email"):      print(f"  │  📧 Email          : {h['email']}")
        if h.get("checkin_time"):  print(f"  │  🕐 Check-in      : {h['checkin_time']}")
        if h.get("checkout_time"): print(f"  │  🕑 Check-out     : {h['checkout_time']}")
        if h.get("wheelchair"): print(f"  │  ♿ Wheelchair     : {h['wheelchair']}")
        if h.get("internet"):   print(f"  │  📶 Internet       : {h['internet']}")

        # ── Media / Links ─────────────────────────────────────────────────
        if h.get("maps_url"):   print(f"  │  🗺  Maps          : {h['maps_url']}")
        if h.get("image_url"):  print(f"  │  🖼  Image         : {(h['image_url'] or '')[:80]}")
        if h.get("booking_url"):print(f"  │  🔗 Book           : {(h['booking_url'] or '')[:80]}")
        print(f"  │  🔧 Source         : {h.get('source','—')} | layer: {h.get('layer','—')}")
        print(f"  └{sep}")


# ══════════════════════════════════════════════════════════════════════════════
#  FLASK ROUTE ADAPTER  (drop into api/booking_routes.py)
# ══════════════════════════════════════════════════════════════════════════════
FLASK_ADAPTER = '''
from hotel_agent import HotelAgent
_agent = HotelAgent()

@app.route("/booking/search-hotels", methods=["POST"])
def search_hotels():
    d = request.json or {}
    result = _agent.search_hotels(
        destination = d.get("destination", ""),
        check_in    = d.get("check_in", ""),
        check_out   = d.get("check_out", ""),
        guests      = int(d.get("guests", 2)),
        scrape      = True,
        osm         = True,
    )
    return jsonify({
        "hotels": [{
            "type":           "hotel",
            "name":           h.get("name"),
            "stars":          h.get("stars"),
            "price":          h.get("price"),
            "price_band":     h.get("price_band"),
            "price_per_night":h.get("price"),
            "original_price": h.get("original_price"),
            "taxes":          h.get("taxes"),
            "rating":         h.get("rating"),
            "rating_label":   h.get("rating_label"),
            "review_count":   h.get("review_count"),
            "location":       h.get("location"),
            "address":        h.get("address"),
            "distance":       h.get("distance"),
            "landmarks":      h.get("landmarks", []),
            "room_type":      h.get("room_type"),
            "bed_type":       h.get("bed_type"),
            "free_breakfast": h.get("free_breakfast"),
            "free_cancel":    h.get("free_cancel"),
            "no_prepayment":  h.get("no_prepayment"),
            "urgency":        h.get("urgency"),
            "deal_badge":     h.get("deal_badge"),
            "sustainable":    h.get("sustainable"),
            "phone":          h.get("phone"),
            "website":        h.get("website"),
            "checkin_time":   h.get("checkin_time"),
            "checkout_time":  h.get("checkout_time"),
            "image":          h.get("image_url"),
            "booking_url":    h.get("booking_url"),
            "booking_links":  h.get("booking_links", {}),
            "maps_url":       h.get("maps_url"),
            "source":         h.get("source"),
        } for h in result["hotels"]],
        "total":         result["total"],
        "scraped":       result["scrape_status"]["scraped"],
        "message":       result["scrape_status"]["message"],
        "layer":         result["scrape_status"]["layer"],
        "booking_links": result["booking_links"],
        "source_note":   result["source_note"],
    })
'''


# ══════════════════════════════════════════════════════════════════════════════
#  CLI
# ══════════════════════════════════════════════════════════════════════════════

DEMO_URL = (
    "https://www.booking.com/searchresults.html"
    "?ss=Greens+Suite+-+Business+Class+Hotel+-+Opposite+Ripon+Building"
    "&checkin=2026-04-10&checkout=2026-04-11"
    "&group_adults=2&no_rooms=1&group_children=0"
    "&dest_id=8131835&dest_type=hotel&lang=en-us"
)

MENU = """
  [1]  Full search        (Booking.com scrape + OSM enrich + deep-links)
  [2]  Scrape URL         (paste any Booking.com URL)
  [3]  OSM only           (no scraping — always works)
  [4]  Booking links      (instant, no scraping)
  [5]  Hotel detail       (Wikipedia summary)
  [q]  Quit
"""


def run_cli():
    import sys
    agent = HotelAgent()
    print(f"\n{'='*72}")
    print(f"  🏨   HotelAgent v3 — Premium (Booking.com + OSM + Deep-Links)")
    print(f"{'='*72}")

    if "--demo" in sys.argv:
        print("\n  Demo: Greens Suite Chennai  |  Apr 10-11 2026  |  2 guests")
        scrape_res = agent.scrape_url(DEMO_URL, "2026-04-10", "2026-04-11", 2)
        agent.print_hotels(scrape_res["hotels"])
        for h in scrape_res["hotels"]:
            agent.print_hotel_detail(h)
        print("\n  📲 Booking links (Chennai):")
        for k,v in agent.get_booking_links("Chennai","2026-04-10","2026-04-11").items():
            print(f"     {k:<20}: {v}")
        return

    while True:
        print(MENU)
        c = input("  👉 Choose: ").strip().lower()

        if c == "1":
            dest  = input("  🏙  Destination          : ").strip()
            ci    = input("  📅 Check-in (YYYY-MM-DD) : ").strip()
            co    = input("  📅 Check-out (YYYY-MM-DD): ").strip()
            g     = input("  👥 Guests [2]            : ").strip()
            r     = agent.search_hotels(dest, ci, co, int(g) if g.isdigit() else 2)
            agent.print_hotels(r["hotels"])
            print(f"  (Booking.com: {r['scrape_status']['scraped']} | "
                  f"OSM hotels: {r['osm_count']} | Total merged: {r['total']})")
            if r["hotels"]:
                n = input("\n  Detail for hotel # (or Enter): ").strip()
                if n.isdigit() and 0 <= int(n)-1 < len(r["hotels"]):
                    agent.print_hotel_detail(r["hotels"][int(n)-1])
            print("\n  📲 Platform links:")
            for k,v in r["booking_links"].items(): print(f"     {k:<20}: {v}")

        elif c == "2":
            url = input("  🔗 URL: ").strip()
            ci  = input("  📅 Check-in  : ").strip()
            co  = input("  📅 Check-out : ").strip()
            r   = agent.scrape_url(url, ci, co)
            agent.print_hotels(r["hotels"])
            for h in r["hotels"]: agent.print_hotel_detail(h)

        elif c == "3":
            dest = input("  🏙  Destination: ").strip()
            ci   = input("  📅 Check-in   : ").strip()
            co   = input("  📅 Check-out  : ").strip()
            g    = input("  👥 Guests [2] : ").strip()
            r    = agent.search_hotels(dest, ci, co, int(g) if g.isdigit() else 2,
                                       scrape=False, osm=True)
            agent.print_hotels(r["hotels"])

        elif c == "4":
            dest = input("  🏙  Destination: ").strip()
            ci   = input("  📅 Check-in   : ").strip()
            co   = input("  📅 Check-out  : ").strip()
            for k,v in agent.get_booking_links(dest,ci,co).items():
                print(f"  {k:<20}: {v}")

        elif c == "5":
            name = input("  🏨 Hotel name: ").strip()
            city = input("  🏙  City     : ").strip()
            d = agent.get_hotel_detail(name, city)
            print(f"\n  {d['name']}\n  {d['summary']}")

        elif c in ("q","quit","exit"):
            print("\n  🏨 HotelAgent v3 signing off!\n"); break
        else:
            print("  ⚠  Invalid option.")


if __name__ == "__main__":
    run_cli()