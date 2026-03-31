import os
import django
import random
from decimal import Decimal

# Setup Django
os.environ.setdefault('DJANGO_SETTINGS_MODULE', 'rentalroomshare.settings')
django.setup()

from api.models import Hotel, HotelRoom
from django.contrib.auth import get_user_model

User = get_user_model()

def seed_hotels():
    hotels_data = [
        {
            "name": "The Grand Chennai",
            "city": "Chennai",
            "address": "T.Nagar, Chennai, Tamil Nadu",
            "stars": 5,
            "rating": 4.8,
            "amenities": "WiFi, Pool, Spa, Gym, Restaurant, AC",
            "image_url": "https://images.unsplash.com/photo-1566073771259-6a8506099945?auto=format&fit=crop&q=80&w=800",
            "description": "Experience luxury in the heart of T.Nagar. The Grand Chennai offers world-class amenities and premium service."
        },
        {
            "name": "Indira Residency",
            "city": "Chennai",
            "address": "Indira Nagar, Adyar, Chennai",
            "stars": 4,
            "rating": 4.5,
            "amenities": "WiFi, AC, Breakfast, Parking",
            "image_url": "https://images.unsplash.com/photo-1551882547-ff43c33ff78e?auto=format&fit=crop&q=80&w=800",
            "description": "Comfortable stay near Adyar. Perfect for business travelers and families."
        },
        {
            "name": "Beachside Suites",
            "city": "Chennai",
            "address": "ECR, Chennai, Tamil Nadu",
            "stars": 4,
            "rating": 4.2,
            "amenities": "WiFi, Beach View, Pool, Bar",
            "image_url": "https://images.unsplash.com/photo-1520250497591-112f2f40a3f4?auto=format&fit=crop&q=80&w=800",
            "description": "Relax with stunning ocean views on the East Coast Road."
        },
        {
            "name": "Silicon Valley Hub",
            "city": "Bangalore",
            "address": "Whitefield, Bangalore, Karnataka",
            "stars": 4,
            "rating": 4.6,
            "amenities": "WiFi, Gym, Conference Room, AC",
            "image_url": "https://images.unsplash.com/photo-1561501900-3701fa6a0864?auto=format&fit=crop&q=80&w=800",
            "description": "Modern suites for tech professionals in Bangalore's IT hub."
        },
        {
            "name": "Heritage Palace",
            "city": "Mysore",
            "address": "Near Palace, Mysore, Karnataka",
            "stars": 5,
            "rating": 4.9,
            "amenities": "WiFi, Heritage Decor, Spa, Fine Dining",
            "image_url": "https://images.unsplash.com/photo-1542314831-068cd1dbfeeb?auto=format&fit=crop&q=80&w=800",
            "description": "Stay like royalty in our heritage-inspired palace rooms."
        }
    ]

    room_types = [
        ("SINGLE", "Single", 1, 1500),
        ("DOUBLE", "Double", 2, 2500),
        ("DELUXE", "Deluxe", 2, 4500),
        ("SUITE", "Suite", 4, 8500),
    ]

    for h_data in hotels_data:
        hotel, created = Hotel.objects.get_or_create(
            name=h_data["name"],
            city=h_data["city"],
            defaults={
                "address": h_data["address"],
                "stars": h_data["stars"],
                "rating": h_data["rating"],
                "amenities": h_data["amenities"],
                "image_url": h_data["image_url"],
                "description": h_data["description"],
                "is_active": True
            }
        )
        
        if created:
            print(f"Created Hotel: {hotel.name}")
            # Add rooms for each hotel
            for r_code, r_name, r_cap, r_price in room_types:
                for i in range(1, 4):  # Create 3 rooms per type
                    HotelRoom.objects.create(
                        hotel=hotel,
                        room_number=f"{random.randint(1,9)}{i}0{random.randint(1,9)}",
                        room_type=r_code,
                        capacity=r_cap,
                        price_per_night=Decimal(r_price + random.randint(0, 500)),
                        is_active=True
                    )
        else:
            print(f"Hotel {hotel.name} already exists.")

if __name__ == "__main__":
    seed_hotels()
    print("Seeding complete!")
