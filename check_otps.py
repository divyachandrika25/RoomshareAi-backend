import os
import django

os.environ.setdefault('DJANGO_SETTINGS_MODULE', 'rentalroomshare.settings')
django.setup()

from api.models import PasswordResetOTP
otp_list = PasswordResetOTP.objects.all().order_by("-created_at")[:10]
print(f"Latest 10 Password Reset OTPs:")
for o in otp_list:
    print(f"User: {o.user.email}, OTP: {o.otp}, Created: {o.created_at}")
