import os
import django

os.environ.setdefault('DJANGO_SETTINGS_MODULE', 'rentalroomshare.settings')
django.setup()

from django.contrib.auth import get_user_model
User = get_user_model()

users = User.objects.all()
print(f"Total users: {len(users)}")
for u in users:
    is_lower = u.email == u.email.lower()
    print(f"User: {u.email}, is_active: {u.is_active}, is_lower: {is_lower}")
from api.models import PasswordResetOTP
otp_list = PasswordResetOTP.objects.all().order_by("-created_at")
print(f"\nTotal Password Reset OTPs: {len(otp_list)}")
for o in otp_list:
    print(f"User: {o.user.email}, OTP: {o.otp}, Created: {o.created_at}")
