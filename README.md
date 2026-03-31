# 🏠 RoomShare - AI-Powered Rental & Hotel Backend

This is the high-performance Django REST API for the **RoomShare** mobile application. It features a unique **AI Location Agent** that find rooms and hotels worldwide using OpenStreetMap.

---

## 🛠️ Prerequisites

Before you begin, ensure you have the following installed:
*   **Python 3.10 or higher** (Tested on Python 3.12)
*   **pip** (bundled with Python)
*   **SQLite** (Built-in with Python)

---

## 🚀 Setup & Installation (Step-by-Step)

Follow these steps carefully to get your server running:

### 1. Project Directory
Ensure you are in the `backend` folder:
```bash
cd RoomShare/backend
```

### 2. Set Up Virtual Environment (Recommended)
This prevents conflicts with other Python projects on your machine:
```bash
# Windows
python -m venv venv
venv\Scripts\activate

# macOS / Linux
python3 -m venv venv
source venv/bin/activate
```

### 3. Install Dependencies
Install all required libraries including Django, REST Framework, and Requests:
```bash
pip install -r requirements.txt
```

### 4. Database Setup & Migrations
Create your database tables and apply updates (including the AI Hotel Agent tables):
```bash
python manage.py makemigrations api
python manage.py migrate
```

### 5. Create Admin Account (Optional)
If you want to manage users and rooms manually through the web dashboard:
```bash
python manage.py createsuperuser
```
*Access it at: http://localhost:8000/admin/*

### 6. Start the Server
Run the server so the mobile app can reach it over your local network:
```bash
python manage.py runserver 0.0.0.0:8000
```

---

## 🤖 AI Location Agent
The backend includes a specialized **AI Agent** (`AILocationAgentView`) that processes natural language search queries.

**How it works:**
1.  **Parsing**: It extracts the city (e.g., "MUMBAI") and budget (e.g., "5000") from your message.
2.  **Local Search**: It first checks the `ListedRoom` database for matches.
3.  **Global Search**: If few matches are found, it triggers the `hotel_agent.py` script.
4.  **External API**: It uses **OSM/Overpass API** to fetch real-world hotels near the location.
5.  **Caching**: All found global hotels are saved in the `HotelResult` table to make future searches instant.

---

## 📡 Essential API Routes

| Endpoint | Method | Purpose |
| :--- | :--- | :--- |
| `/api/ai-agent/location/` | POST | 💬 Chat with AI (Send: `{"query": "hotels in Chennai under 5000"}`) |
| `/api/home-rooms/<email>/` | GET | 🏠 View all available rental rooms near a user |
| `/api/register/` | POST | 👤 Account creation |
| `/api/login/` | POST | 🔑 Secure login |

---

## 🔧 Troubleshooting

### 📱 "Network Error" on Mobile
*   **Same WiFi**: Ensure your Laptop and Phone are on the same network.
*   **IP Address**: In the Android app (`RetrofitClient.kt`), update `BASE_URL` with your laptop's Local IP (e.g., `192.168.1.5`).
*   **Firewall**: Ensure your laptop's firewall allows traffic on port `8000`.

### ⚠️ "No Such Table: HotelResult"
If you get a 500 Internal Server Error when using the AI, it likely means the database isn't updated. Run:
```bash
python manage.py makemigrations api
python manage.py migrate
```

### 🌐 OSM Queries Slow?
The first time you search a specific city, the agent might take 2-5 seconds as it fetches live data from OpenStreetMap. Subsequent searches for that city will be instant from the database.

---
*Developed for RoomShare AIRental App.*
