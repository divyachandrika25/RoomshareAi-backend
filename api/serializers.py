from rest_framework import serializers
from django.db.models import Q
from django.contrib.auth import authenticate, get_user_model

from .models import (
    UserLifestyle,
    UserBudgetLocation,
    MatchResult,
    UserProfile,
    FavoriteMatch,
    UserAccountSettings,
    ListedRoom,
    ListedRoomPhoto,
    AppNotification,
    RoomShareRequest,
    Notification,
    BookingHistory,
    Room,
)

User = get_user_model()


class RegisterSerializer(serializers.Serializer):
    full_name = serializers.CharField(max_length=100)
    gender = serializers.CharField(max_length=20)
    age = serializers.IntegerField(min_value=18, max_value=100)
    occupation = serializers.CharField(max_length=100)
    email = serializers.EmailField()
    address = serializers.CharField()
    password = serializers.CharField(write_only=True, min_length=6)

    def validate_gender(self, value):
        val = value.strip().capitalize()
        if val not in ["Male", "Female", "Other"]:
            return "Other"
        return val

    def validate_email(self, value):
        return value.lower().strip()

    def create(self, validated_data):
        full_name = validated_data.pop("full_name")
        gender = validated_data.pop("gender")
        age = validated_data.pop("age")
        occupation = validated_data.pop("occupation")
        address = validated_data.pop("address")

        user = User.objects.create_user(
            email=validated_data["email"],
            password=validated_data["password"]
        )

        UserProfile.objects.create(
            user=user,
            full_name=full_name,
            gender=gender,
            age=age,
            occupation=occupation,
            address=address,
            room_status="SEEKING_ROOM",
        )

        return user


class LoginSerializer(serializers.Serializer):
    email = serializers.EmailField()
    password = serializers.CharField(write_only=True)

    def validate(self, attrs):
        email = attrs.get("email").lower().strip()
        password = attrs.get("password")

        user = authenticate(username=email, password=password)

        if user is None:
            try:
                user_obj = User.objects.get(email=email)
                if user_obj.check_password(password):
                    user = user_obj
            except User.DoesNotExist:
                pass

        if user is None:
            raise serializers.ValidationError("Invalid email or password")

        attrs["user"] = user
        return attrs


class VerifyOTPSerializer(serializers.Serializer):
    email = serializers.EmailField()
    otp = serializers.CharField(max_length=6)


class ForgotPasswordSerializer(serializers.Serializer):
    email = serializers.EmailField()


class ResetPasswordSerializer(serializers.Serializer):
    email = serializers.EmailField()
    otp = serializers.CharField(max_length=6)
    new_password = serializers.CharField(write_only=True, min_length=6)


class UserLifestyleSerializer(serializers.ModelSerializer):
    class Meta:
        model = UserLifestyle
        fields = "__all__"
        read_only_fields = ["user"]


class UserBudgetLocationSerializer(serializers.ModelSerializer):
    class Meta:
        model = UserBudgetLocation
        fields = "__all__"
        read_only_fields = ["user"]


class UserProfileCreateUpdateSerializer(serializers.ModelSerializer):
    class Meta:
        model = UserProfile
        fields = [
            "full_name",
            "gender",
            "age",
            "occupation",
            "address",
            "room_status",
            "photo",
            "profile_photo",
            "about_me",
            "target_area",
            "budget_range",
            "move_in_date",
            "is_premium",
        ]
class UserProfileDataSerializer(serializers.ModelSerializer):
    profile_photo = serializers.SerializerMethodField()
    photo = serializers.SerializerMethodField()

    class Meta:
        model = UserProfile
        fields = [
            "full_name",
            "gender",
            "age",
            "address",
            "room_status",
            "photo",
            "profile_photo",
            "about_me",
            "occupation",
            "target_area",
            "budget_range",
            "move_in_date",
            "saved_rooms",
            "trust_score",
            "bookings",
            "is_premium",
            "created_at",
        ]

    def get_profile_photo(self, obj):
        request = self.context.get("request")
        if obj and obj.profile_photo:
            return request.build_absolute_uri(obj.profile_photo.url) if request else obj.profile_photo.url
        return None

    def get_photo(self, obj):
        request = self.context.get("request")
        if obj and obj.photo:
            return request.build_absolute_uri(obj.photo.url) if request else obj.photo.url
        return None


class UserProfileSerializer(serializers.Serializer):
    id = serializers.IntegerField(read_only=True)
    email = serializers.EmailField(read_only=True)
    profile = serializers.SerializerMethodField()
    lifestyle = serializers.SerializerMethodField()
    budget_location = serializers.SerializerMethodField()

    def get_profile(self, obj):
        profile = UserProfile.objects.filter(user=obj).first()
        return UserProfileDataSerializer(profile, context=self.context).data if profile else None

    def get_lifestyle(self, obj):
        lifestyle = UserLifestyle.objects.filter(user=obj).first()
        return UserLifestyleSerializer(lifestyle).data if lifestyle else None

    def get_budget_location(self, obj):
        budget = UserBudgetLocation.objects.filter(user=obj).first()
        return UserBudgetLocationSerializer(budget).data if budget else None


class MatchResultSerializer(serializers.ModelSerializer):
    matched_user = serializers.SerializerMethodField()
    tags = serializers.SerializerMethodField()
    # Keep flat fields for web compatibility if needed, or just let the mobile app use the nested one
    full_name = serializers.SerializerMethodField()
    email = serializers.SerializerMethodField()
    photo = serializers.SerializerMethodField()
    occupation = serializers.SerializerMethodField()
    age = serializers.SerializerMethodField()
    room_status = serializers.SerializerMethodField()
    preferred_city = serializers.SerializerMethodField()
    monthly_budget = serializers.SerializerMethodField()
    sleep_schedule = serializers.SerializerMethodField()
    cleanliness = serializers.SerializerMethodField()
    social_interaction = serializers.SerializerMethodField()
    reason = serializers.SerializerMethodField()
    is_favorite = serializers.SerializerMethodField()

    class Meta:
        model = MatchResult
        fields = [
            "id",
            "compatibility_score",
            "ai_explanation",
            "reason",
            "matched_user",
            "tags",
            # flat fields below
            "full_name",
            "email",
            "photo",
            "occupation",
            "age",
            "room_status",
            "preferred_city",
            "monthly_budget",
            "sleep_schedule",
            "cleanliness",
            "social_interaction",
            "is_favorite",
        ]

    def get_matched_user(self, obj):
        user = obj.matched_user
        profile = UserProfile.objects.filter(user=user).first()
        request = self.context.get("request")
        
        photo_url = None
        if profile:
            if getattr(profile, "profile_photo", None):
                photo_url = request.build_absolute_uri(profile.profile_photo.url) if request else profile.profile_photo.url
            elif getattr(profile, "photo", None):
                photo_url = request.build_absolute_uri(profile.photo.url) if request else profile.photo.url

        return {
            "id": user.id,
            "email": user.email,
            "full_name": profile.full_name if profile and profile.full_name else user.email,
            "photo": photo_url,
            "occupation": profile.occupation if profile else None,
            "age": profile.age if profile else None,
            "address": profile.address if profile else None,
        }

    def get_reason(self, obj):
        return obj.ai_explanation

    def get_full_name(self, obj):
        profile = UserProfile.objects.filter(user=obj.matched_user).first()
        return profile.full_name if profile and profile.full_name else obj.matched_user.email

    def get_is_favorite(self, obj):
        user = obj.user # The user who owns this match result
        return FavoriteMatch.objects.filter(user=user, matched_user=obj.matched_user).exists()

    def get_email(self, obj):
        return obj.matched_user.email

    def get_occupation(self, obj):
        profile = UserProfile.objects.filter(user=obj.matched_user).first()
        return profile.occupation if profile else None

    def get_age(self, obj):
        profile = UserProfile.objects.filter(user=obj.matched_user).first()
        return profile.age if profile else None

    def get_room_status(self, obj):
        profile = UserProfile.objects.filter(user=obj.matched_user).first()
        if not profile:
            return None
        return getattr(profile, "room_status", None)

    def get_photo(self, obj):
        request = self.context.get("request")
        profile = UserProfile.objects.filter(user=obj.matched_user).first()
        if profile and getattr(profile, "profile_photo", None):
            return request.build_absolute_uri(profile.profile_photo.url) if request else profile.profile_photo.url
        if profile and getattr(profile, "photo", None):
            return request.build_absolute_uri(profile.photo.url) if request else profile.photo.url
        return None

    def get_preferred_city(self, obj):
        budget = UserBudgetLocation.objects.filter(user=obj.matched_user).first()
        return budget.preferred_city if budget else None

    def get_monthly_budget(self, obj):
        budget = UserBudgetLocation.objects.filter(user=obj.matched_user).first()
        if budget and budget.monthly_budget is not None:
            try:
                return f"${int(float(budget.monthly_budget)):,}"
            except Exception:
                return str(budget.monthly_budget)
        return None

    def get_lifestyle(self, obj):
        return UserLifestyle.objects.filter(user=obj.matched_user).first()

    def get_sleep_schedule(self, obj):
        life = self.get_lifestyle(obj)
        return life.sleep_schedule if life else None

    def get_cleanliness(self, obj):
        life = self.get_lifestyle(obj)
        return life.cleanliness if life else None

    def get_social_interaction(self, obj):
        life = self.get_lifestyle(obj)
        return life.social_interaction if life else None

    def get_tags(self, obj):
        user = obj.matched_user
        profile = UserProfile.objects.filter(user=user).first()
        life = self.get_lifestyle(obj)
        
        tags = []
        if profile and profile.occupation:
            tags.append(profile.occupation.upper())
        
        if life:
            if life.cleanliness: tags.append(life.cleanliness.upper())
            if life.social_interaction: tags.append(life.social_interaction.upper())
            if len(tags) < 3 and life.sleep_schedule: tags.append(life.sleep_schedule.upper())
        
        if not tags:
            tags = ["SEARCHING", "VERIFIED"]
        return tags[:3]


class DiscoverRoommateSerializer(serializers.Serializer):
    email = serializers.EmailField(read_only=True)
    full_name = serializers.SerializerMethodField()
    age = serializers.SerializerMethodField()
    city = serializers.SerializerMethodField()
    photo = serializers.SerializerMethodField()
    monthly_budget = serializers.SerializerMethodField()
    tags = serializers.SerializerMethodField()
    room_status = serializers.SerializerMethodField()
    match_percentage = serializers.SerializerMethodField()
    is_favorite = serializers.SerializerMethodField()
    request_status = serializers.SerializerMethodField()

    def get_full_name(self, obj):
        profile = UserProfile.objects.filter(user=obj).first()
        return profile.full_name if profile and profile.full_name else obj.email

    def get_age(self, obj):
        profile = UserProfile.objects.filter(user=obj).first()
        return profile.age if profile else None

    def get_city(self, obj):
        profile = UserProfile.objects.filter(user=obj).first()
        budget = UserBudgetLocation.objects.filter(user=obj).first()
        
        if profile and profile.target_area:
            return profile.target_area
        if profile and profile.address:
            # Try to get the first part of the address (often the area)
            return profile.address.split(',')[0].strip()
        
        return budget.preferred_city if budget else "Chennai"

    def get_photo(self, obj):
        request = self.context.get("request")
        profile = UserProfile.objects.filter(user=obj).first()
        if profile and getattr(profile, "profile_photo", None):
            return request.build_absolute_uri(profile.profile_photo.url) if request else profile.profile_photo.url
        if profile and getattr(profile, "photo", None):
            return request.build_absolute_uri(profile.photo.url) if request else profile.photo.url
        return None

    def get_monthly_budget(self, obj):
        budget = UserBudgetLocation.objects.filter(user=obj).first()
        if budget and budget.monthly_budget is not None:
            try:
                return f"${int(float(budget.monthly_budget)):,}"
            except Exception:
                return str(budget.monthly_budget)
        return None

    def get_tags(self, obj):
        profile = UserProfile.objects.filter(user=obj).first()
        lifestyle = UserLifestyle.objects.filter(user=obj).first()
        
        tags = []
        if profile and profile.occupation:
            tags.append(profile.occupation.upper())
            
        if lifestyle:
            if lifestyle.cleanliness:
                tags.append(lifestyle.cleanliness.upper())
            if lifestyle.social_interaction:
                tags.append(lifestyle.social_interaction.upper())
            if len(tags) < 3 and lifestyle.sleep_schedule:
                tags.append(lifestyle.sleep_schedule.upper())
        
        if not tags:
            return ["SEARCHING", "VERIFIED"]
        return tags[:3]

    def get_room_status(self, obj):
        profile = UserProfile.objects.filter(user=obj).first()
        if not profile:
            return None
        return getattr(profile, "room_status", None)

    def get_is_favorite(self, obj):
        current_user = self.context.get("current_user")
        if not current_user:
            return False
        return FavoriteMatch.objects.filter(user=current_user, matched_user=obj).exists()

    def get_request_status(self, obj):
        current_user = self.context.get("current_user")
        if not current_user:
            return None
        req = RoomShareRequest.objects.filter(
            (Q(requester=current_user) & Q(room_owner=obj)) | 
            (Q(requester=obj) & Q(room_owner=current_user))
        ).first()
        return req.status if req else None

    def get_match_percentage(self, obj):
        current_user = self.context.get("current_user")
        if not current_user:
            return 75
        
        # This is a bit recursive if used in a list, but fine for Discover 
        from .views import calculate_detailed_compatibility
        try:
            compat = calculate_detailed_compatibility(current_user, obj)
            return compat["total_match"]
        except:
            return 80


class RoommateProfileDetailSerializer(serializers.Serializer):
    email = serializers.EmailField(read_only=True)
    full_name = serializers.SerializerMethodField()
    age = serializers.SerializerMethodField()
    city = serializers.SerializerMethodField()
    photo = serializers.SerializerMethodField()
    room_status = serializers.SerializerMethodField()
    about_me = serializers.SerializerMethodField()
    social = serializers.SerializerMethodField()
    cleanliness = serializers.SerializerMethodField()
    sleep_schedule = serializers.SerializerMethodField()
    monthly_budget = serializers.SerializerMethodField()
    occupation = serializers.SerializerMethodField()
    target_area = serializers.SerializerMethodField()
    budget_range = serializers.SerializerMethodField()
    move_in_date = serializers.SerializerMethodField()
    address = serializers.SerializerMethodField()
    gender = serializers.SerializerMethodField()
    is_favorite = serializers.SerializerMethodField()
    request_status = serializers.SerializerMethodField()
    tags = serializers.SerializerMethodField()

    def _get_profile(self, obj):
        return UserProfile.objects.filter(user=obj).first()

    def _get_budget(self, obj):
        return UserBudgetLocation.objects.filter(user=obj).first()

    def _get_lifestyle(self, obj):
        return UserLifestyle.objects.filter(user=obj).first()

    def get_full_name(self, obj):
        profile = self._get_profile(obj)
        return profile.full_name if profile and profile.full_name else obj.email

    def get_age(self, obj):
        profile = self._get_profile(obj)
        return profile.age if profile else None

    def get_city(self, obj):
        profile = self._get_profile(obj)
        budget = self._get_budget(obj)
        
        if profile and profile.target_area:
            return profile.target_area
        if profile and profile.address:
            return profile.address.split(',')[0].strip()
        
        return budget.preferred_city if budget else "Chennai"

    def get_photo(self, obj):
        request = self.context.get("request")
        profile = self._get_profile(obj)
        if profile and profile.profile_photo:
            try: return request.build_absolute_uri(profile.profile_photo.url) if request else profile.profile_photo.url
            except ValueError: pass
        if profile and profile.photo:
            try: return request.build_absolute_uri(profile.photo.url) if request else profile.photo.url
            except ValueError: pass
        return None

    def get_room_status(self, obj):
        profile = self._get_profile(obj)
        if not profile:
            return None
        return getattr(profile, "room_status", None)

    def get_about_me(self, obj):
        profile = self._get_profile(obj)
        return profile.about_me if profile else None

    def get_social(self, obj):
        lifestyle = self._get_lifestyle(obj)
        return lifestyle.social_interaction if lifestyle else None

    def get_cleanliness(self, obj):
        lifestyle = self._get_lifestyle(obj)
        return lifestyle.cleanliness if lifestyle else None

    def get_sleep_schedule(self, obj):
        lifestyle = self._get_lifestyle(obj)
        return lifestyle.sleep_schedule if lifestyle else None

    def get_monthly_budget(self, obj):
        budget = self._get_budget(obj)
        if budget and budget.monthly_budget is not None:
            try:
                return f"${int(float(budget.monthly_budget)):,}"
            except Exception:
                return str(budget.monthly_budget)
        return None

    def get_occupation(self, obj):
        profile = self._get_profile(obj)
        return profile.occupation if profile else None

    def get_tags(self, obj):
        profile = self._get_profile(obj)
        life = self._get_lifestyle(obj)
        
        tags = []
        if profile and profile.occupation:
            tags.append(profile.occupation.upper())
            
        if life:
            if life.cleanliness: tags.append(life.cleanliness.upper())
            if life.social_interaction: tags.append(life.social_interaction.upper())
            if len(tags) < 3 and life.sleep_schedule: tags.append(life.sleep_schedule.upper())
        
        if not tags:
            return ["SEARCHING", "VERIFIED"]
        return tags[:3]

    def get_target_area(self, obj):
        profile = self._get_profile(obj)
        return profile.target_area if profile else None

    def get_budget_range(self, obj):
        profile = self._get_profile(obj)
        return profile.budget_range if profile else None

    def get_move_in_date(self, obj):
        profile = self._get_profile(obj)
        return profile.move_in_date if profile else None

    def get_address(self, obj):
        profile = self._get_profile(obj)
        return profile.address if profile else None

    def get_gender(self, obj):
        profile = self._get_profile(obj)
        return profile.gender if profile else None

    def get_is_favorite(self, obj):
        current_user = self.context.get("current_user")
        if not current_user:
            return False
        return FavoriteMatch.objects.filter(user=current_user, matched_user=obj).exists()

    def get_request_status(self, obj):
        current_user = self.context.get("current_user")
        if not current_user:
            return None
        req = RoomShareRequest.objects.filter(
            (Q(requester=current_user) & Q(room_owner=obj)) | 
            (Q(requester=obj) & Q(room_owner=current_user))
        ).first()
        return req.status if req else None


class UserAccountSettingsSerializer(serializers.ModelSerializer):
    class Meta:
        model = UserAccountSettings
        fields = "__all__"


class ListedRoomPhotoSerializer(serializers.ModelSerializer):
    image = serializers.SerializerMethodField()

    class Meta:
        model = ListedRoomPhoto
        fields = ["id", "image"]

    def get_image(self, obj):
        request = self.context.get("request")
        if obj.image:
            return request.build_absolute_uri(obj.image.url) if request else obj.image.url
        return None


class ListedRoomSerializer(serializers.ModelSerializer):
    photos = serializers.SerializerMethodField()

    class Meta:
        model = ListedRoom
        fields = [
            "id",
            "apartment_title",
            "address",
            "city",
            "monthly_rent",
            "description",
            "status",
            "bathroom_type",
            "roommate_count",
            "entry_type",
            "is_active",
            "photos",
            "tags",
            "available_from",
        ]

    def get_photos(self, obj):
        photos = obj.photos.all().order_by("created_at")
        return ListedRoomPhotoSerializer(photos, many=True, context=self.context).data


class AppNotificationSerializer(serializers.ModelSerializer):
    class Meta:
        model = AppNotification
        fields = "__all__"


class HomeRoomListSerializer(serializers.ModelSerializer):
    photos = serializers.SerializerMethodField()
    match_percentage = serializers.SerializerMethodField()
    status_label = serializers.SerializerMethodField()
    monthly_rent_display = serializers.SerializerMethodField()

    class Meta:
        model = ListedRoom
        fields = [
            "id",
            "apartment_title",
            "address",
            "city",
            "monthly_rent",
            "monthly_rent_display",
            "status",
            "status_label",
            "bathroom_type",
            "roommate_count",
            "entry_type",
            "photos",
            "match_percentage",
            "tags",
            "available_from",
        ]

    def get_photos(self, obj):
        photos = obj.photos.all().order_by("created_at")
        return ListedRoomPhotoSerializer(photos, many=True, context=self.context).data

    def get_match_percentage(self, obj):
        current_user = self.context.get("current_user")
        if not current_user:
            return 75

        budget = UserBudgetLocation.objects.filter(user=current_user).first()
        score = 70

        if budget:
            if budget.preferred_city and obj.city and budget.preferred_city.strip().lower() == obj.city.strip().lower():
                score += 15

            try:
                gap = abs(float(budget.monthly_budget) - float(obj.monthly_rent))
                if gap <= 100:
                    score += 13
                elif gap <= 300:
                    score += 10
                elif gap <= 500:
                    score += 7
                elif gap <= 1000:
                    score += 4
            except Exception:
                pass

        return min(score, 99)

    def get_status_label(self, obj):
        return "Available" if obj.status == "AVAILABLE" else "Sold Out"

    def get_monthly_rent_display(self, obj):
        try:
            return f"${int(float(obj.monthly_rent)):,}"
        except Exception:
            return str(obj.monthly_rent)


class HomeRoomDetailSerializer(serializers.ModelSerializer):
    photos = serializers.SerializerMethodField()
    monthly_rent_display = serializers.SerializerMethodField()
    status_label = serializers.SerializerMethodField()
    potential_roommates = serializers.SerializerMethodField()

    class Meta:
        model = ListedRoom
        fields = [
            "id",
            "apartment_title",
            "address",
            "city",
            "monthly_rent",
            "monthly_rent_display",
            "description",
            "status",
            "status_label",
            "bathroom_type",
            "roommate_count",
            "entry_type",
            "photos",
            "potential_roommates",
            "tags",
            "available_from",
            "owner_name",
            "owner_email",
            "owner_photo",
        ]

    owner_name = serializers.SerializerMethodField()
    owner_email = serializers.SerializerMethodField()
    owner_photo = serializers.SerializerMethodField()

    def get_owner_name(self, obj):
        profile = UserProfile.objects.filter(user=obj.user).first()
        return profile.full_name if profile else obj.user.email

    def get_owner_email(self, obj):
        return obj.user.email

    def get_owner_photo(self, obj):
        profile = UserProfile.objects.filter(user=obj.user).first()
        request = self.context.get("request")
        if profile and profile.profile_photo:
            return request.build_absolute_uri(profile.profile_photo.url) if request else profile.profile_photo.url
        return None

    def get_photos(self, obj):
        photos = obj.photos.all().order_by("created_at")
        return ListedRoomPhotoSerializer(photos, many=True, context=self.context).data

    def get_monthly_rent_display(self, obj):
        try:
            return f"${int(float(obj.monthly_rent)):,}"
        except Exception:
            return str(obj.monthly_rent)

    def get_status_label(self, obj):
        return "Available" if obj.status == "AVAILABLE" else "Sold Out"

    def get_potential_roommates(self, obj):
        current_user = self.context.get("current_user")
        request = self.context.get("request")

        if not current_user:
            return []

        matches = MatchResult.objects.filter(user=current_user).order_by("-compatibility_score")[:2]
        data = []

        for match in matches:
            matched_user = match.matched_user
            profile = UserProfile.objects.filter(user=matched_user).first()

            photo = None
            if profile and getattr(profile, "profile_photo", None):
                photo = request.build_absolute_uri(profile.profile_photo.url) if request else profile.profile_photo.url
            elif profile and getattr(profile, "photo", None):
                photo = request.build_absolute_uri(profile.photo.url) if request else profile.photo.url

            data.append({
                "email": matched_user.email,
                "full_name": profile.full_name if profile and profile.full_name else matched_user.email,
                "photo": photo,
                "match_percentage": match.compatibility_score,
            })

        return data


class RoomShareRequestSerializer(serializers.ModelSerializer):
    class Meta:
        model = RoomShareRequest
        fields = "__all__"


class RoomShareVerificationSerializer(serializers.ModelSerializer):
    identity_document = serializers.SerializerMethodField()

    class Meta:
        model = RoomShareRequest
        fields = [
            "id",
            "room",
            "requester",
            "identity_document",
            "identity_upload_source",
            "identity_verified",
            "status",
        ]

    def get_identity_document(self, obj):
        request = self.context.get("request")
        if obj.identity_document:
            return request.build_absolute_uri(obj.identity_document.url) if request else obj.identity_document.url
        return None


class RoomShareFinalReviewSerializer(serializers.ModelSerializer):
    room_title = serializers.ReadOnlyField(source="room.apartment_title")
    owner_name = serializers.SerializerMethodField()
    owner_photo = serializers.SerializerMethodField()

    class Meta:
        model = RoomShareRequest
        fields = [
            "id",
            "room",
            "room_title",
            "owner_name",
            "owner_photo",
            "your_share_monthly",
            "group_security_deposit",
            "total_move_in",
            "preferred_move_in_date",
            "duration_of_stay",
            "employment_status",
            "status",
        ]

    def get_owner_name(self, obj):
        profile = UserProfile.objects.filter(user=obj.room_owner).first()
        return profile.full_name if profile else obj.room_owner.email

    def get_owner_photo(self, obj):
        profile = UserProfile.objects.filter(user=obj.room_owner).first()
        request = self.context.get("request")
        if profile and profile.profile_photo:
            return request.build_absolute_uri(profile.profile_photo.url) if request else profile.profile_photo.url
        return None


class RoomShareRequestSentSerializer(serializers.ModelSerializer):
    room_title = serializers.SerializerMethodField()

    class Meta:
        model = RoomShareRequest
        fields = [
            "id",
            "room_title",
            "status",
            "identity_verified",
            "created_at",
        ]

    def get_room_title(self, obj):
        return obj.room.apartment_title


class NotificationSerializer(serializers.ModelSerializer):
    class Meta:
        model = Notification
        fields = "__all__"


class BookingHistorySerializer(serializers.ModelSerializer):
    class Meta:
        model = BookingHistory
        fields = "__all__"


class RoomSerializer(serializers.ModelSerializer):
    class Meta:
        model = Room
        fields = "__all__"


class UserProfileImageUploadSerializer(serializers.ModelSerializer):
    class Meta:
        model = UserProfile
        fields = [
            "user",
            "photo",
            "profile_photo",
        ]