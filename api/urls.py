from django.urls import path
from .views import (
    SendOTPView,
    VerifyOTPView,
    RegisterView,
    LoginView,
    ForgotPasswordView,
    ResetPasswordView,
    UserLifestyleView,
    UserBudgetLocationView,
    UserProfileCreateUpdateView,
    UserProfileView,
    MatchListView,
    MatchDetailView,
    SaveFavoriteMatchView,
    FavoriteListView,

    DirectChatCreateOrGetView,
    DirectChatDetailView,
    DirectChatSendMessageView,
    MessagesInboxView,
    ProfileDashboardView,
    ProfileUpdateView,
    ProfilePhotoUploadView,
    AccountSettingsView,
    ChangeEmailView,
    ChangePasswordView,
    DeleteAccountView,
    NotificationsListView,
    MarkNotificationReadView,
    MarkAllNotificationsReadView,
    ListedRoomCreateUpdateView,
    ListedRoomDetailView,
    HomeRoomsListView,
    HomeRoomDetailView,
    RoomShareRequestFormView,
    SubmitRoomShareRequestView,
    DirectRoomShareRequestView,
    RoomShareRequestDetailView,
    RoomShareVerificationView,
    UploadIdentityDocumentView,
    RoomShareFinalReviewView,
    SendRoomShareRequestView,
    RoomShareRequestSentView,
    LogoutView,
    DiscoverRoommatesView,
    RoommateProfileDetailView,
    AICompatibilityView,
    AILocationAgentView,
    AIChatbotView,
    HotelListView,
    HotelDetailView,
    HotelRoomBookingView,
    MyHotelBookingsView,
    RecommendationView,
    BookingHistoryView,
    NotificationCountView,
    ToggleFavoriteHotelView,
    FavoriteHotelsListView,
    ToggleFavoriteRoomView,
    FavoriteRoomsListView,
    SubscriptionUpdateView,
    CreatePaymentIntentView,
)

urlpatterns = [

    # ================= AUTH =================
    path("send-otp/", SendOTPView.as_view()),
    path("verify-otp/", VerifyOTPView.as_view()),
    path("register/", RegisterView.as_view()),
    path("login/", LoginView.as_view()),
    path("forgot-password/", ForgotPasswordView.as_view()),
    path("reset-password/", ResetPasswordView.as_view()),
    path("logout/", LogoutView.as_view()),
    path("update-subscription/", SubscriptionUpdateView.as_view()),
    path("create-payment-intent/", CreatePaymentIntentView.as_view()),

    # ================= ONBOARDING =================
    path("lifestyle/", UserLifestyleView.as_view()),
    path("budget-location/", UserBudgetLocationView.as_view()),

    # ================= PROFILE =================
    path("user-profile/", UserProfileCreateUpdateView.as_view()),
    path("profile/<str:email>/", UserProfileView.as_view()),
    path("profile-dashboard/<str:email>/", ProfileDashboardView.as_view()),
    path("profile-update/", ProfileUpdateView.as_view()),
    path("profile-photo-upload/", ProfilePhotoUploadView.as_view()),

    # ================= MATCHES =================
    path("matches/<str:email>/", MatchListView.as_view()),
    path("match-detail/<int:match_id>/", MatchDetailView.as_view()),
    path("save-favorite/", SaveFavoriteMatchView.as_view()),
    path("favorites/<str:email>/", FavoriteListView.as_view()),

    # ================= DISCOVER + AI =================
    path("discover-roommates/<str:email>/", DiscoverRoommatesView.as_view()),
    path("roommate-profile/<str:current_email>/<str:target_email>/", RoommateProfileDetailView.as_view()),
    path("ai-compatibility/<str:current_email>/<str:target_email>/", AICompatibilityView.as_view()),



    # ================= DIRECT CHAT =================
    path("direct-chat/create/", DirectChatCreateOrGetView.as_view()),
    path("direct-chat/<int:chat_id>/<str:email>/", DirectChatDetailView.as_view()),
    path("direct-chat/send-message/", DirectChatSendMessageView.as_view()),
    path("messages/<str:email>/", MessagesInboxView.as_view()),

    # ================= ROOMS =================
    path("listed-room/", ListedRoomCreateUpdateView.as_view()),
    path("listed-room/<str:email>/", ListedRoomDetailView.as_view()),
    path("home-rooms/<str:email>/", HomeRoomsListView.as_view()),
    path("home-room-detail/<str:room_id>/<str:email>/", HomeRoomDetailView.as_view()),

    # ================= ROOM SHARE =================
    path("room-share-form/<str:room_id>/<str:email>/", RoomShareRequestFormView.as_view()),
    path("submit-room-share-request/", SubmitRoomShareRequestView.as_view()),
    path("room-share-request/<int:request_id>/", RoomShareRequestDetailView.as_view()),
    path("room-share-verification/<int:request_id>/", RoomShareVerificationView.as_view()),
    path("upload-identity-document/", UploadIdentityDocumentView.as_view()),
    path("room-share-final-review/<int:request_id>/", RoomShareFinalReviewView.as_view()),
    path("send-room-share-request/", SendRoomShareRequestView.as_view()),
    path("room-share-request-sent/<int:request_id>/", RoomShareRequestSentView.as_view()),
    path("room-share/request/", DirectRoomShareRequestView.as_view()),



    # ================= SETTINGS =================
    path("account-settings/<str:email>/", AccountSettingsView.as_view()),
    path("account-settings/", AccountSettingsView.as_view()),
    path("change-email/", ChangeEmailView.as_view()),
    path("change-password/", ChangePasswordView.as_view()),
    path("delete-account/", DeleteAccountView.as_view()),

    # ================= NOTIFICATIONS =================
    path("notifications/mark-read/", MarkNotificationReadView.as_view(), name="notifications-mark-read"),
    path("notifications/mark-all-read/", MarkAllNotificationsReadView.as_view(), name="notifications-mark-all-read"),
    path("notifications/<str:email>/", NotificationsListView.as_view(), name="notifications-list"),
   
   # ================= AI AGENT =================
   path("ai-agent/location/", AILocationAgentView.as_view()),

   # ================= AI CHATBOT =================
   path("chatbot/", AIChatbotView.as_view()),
   path("chatbot/<str:email>/", AIChatbotView.as_view()),

   # ================= HOTELS & ROOMS =================
   path("hotels/toggle-favorite/", ToggleFavoriteHotelView.as_view()),
   path("rooms/toggle-favorite/", ToggleFavoriteRoomView.as_view()),
   path("hotels/", HotelListView.as_view()),
   path("hotels/<str:hotel_id>/", HotelDetailView.as_view()),
   path("hotels/favorites/<str:email>/", FavoriteHotelsListView.as_view()),
   path("hotel-booking/", HotelRoomBookingView.as_view()),
   path("rooms/favorites/<str:email>/", FavoriteRoomsListView.as_view()),
   path("my-hotel-bookings/<str:email>/", MyHotelBookingsView.as_view()),

   # ================= RECOMMENDATIONS =================
   path("recommendations/<str:email>/", RecommendationView.as_view()),

   # ================= BOOKING HISTORY =================
   path("booking-history/<str:email>/", BookingHistoryView.as_view()),

   # ================= NOTIFICATION COUNT =================
   path("notification-count/<str:email>/", NotificationCountView.as_view()),
]