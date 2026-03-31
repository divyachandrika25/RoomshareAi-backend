import django, os
os.environ['DJANGO_SETTINGS_MODULE'] = 'rentalroomshare.settings'
django.setup()
from django.db import connection
cursor = connection.cursor()
# Fix migration name
cursor.execute("DELETE FROM django_migrations WHERE name LIKE '0027_%'")
cursor.execute("INSERT INTO django_migrations (app, name, applied) VALUES ('api', '0027_hotel_chatmessage_hotelroom_hotelroombooking_and_more', NOW())")
print("Migration 0027 fixed!")
