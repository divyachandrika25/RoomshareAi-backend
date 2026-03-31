import os
import django

os.environ.setdefault('DJANGO_SETTINGS_MODULE', 'rentalroomshare.settings')
django.setup()

from api.models import HotelRoomBooking, BookingHistory, CustomUser

email = 'eswarch2004y@gmail.com'
try:
    user = CustomUser.objects.get(email=email)
    print(f"User: {user.email}")
    
    print("\nHotel Room Bookings:")
    for b in HotelRoomBooking.objects.filter(user=user):
        print(f"ID: {b.id}, Room: {b.room.room_number}, Hotel: {b.hotel.name}, Check-in: {b.check_in}, Check-out: {b.check_out}, Status: {b.status}")
        
    print("\nBooking History:")
    for h in BookingHistory.objects.filter(user=user):
        print(f"ID: {h.id}, Title: {h.room_title}, Amt: {h.amount}, Date: {h.booking_date}, Hotel: {h.is_hotel}, Created: {h.created_at}")
        
except CustomUser.DoesNotExist:
    print(f"User {email} not found")
except Exception as e:
    print(f"Error: {e}")
