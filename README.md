# waypoint_frontend

Software Engineering (CS317) PIT

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

lib/
│
├── main.dart
│
├── core/
│   ├── constants/
│   │   ├── app_colors.dart
│   │   ├── app_text_styles.dart
│   │   ├── app_sizes.dart
│   │   └── app_strings.dart
│   │
│   └── theme/
│       └── app_theme.dart
│
├── data/
│   ├── models/
│   │   ├── user_model.dart
│   │   ├── reading_plan_model.dart
│   │   ├── journal_model.dart
│   │   └── prayer_model.dart
│   │
│   └── services/
│       ├── auth_service.dart
│       ├── firestore_service.dart
│       └── remote_api_service.dart    // if using external APIs
│
├── presentation/
│   ├── screens/
│   │   ├── splash/
│   │   │   └── splash_screen.dart
│   │   ├── auth/
│   │   │   ├── login_screen.dart
│   │   │   ├── signup_screen.dart
│   │   │   ├── forgot_password_screen.dart
│   │   │   └── verification_screen.dart
│   │   ├── home/
│   │   │   └── home_screen.dart
│   │   ├── profile/
│   │   │   └── profile_screen.dart
│   │   ├── journal/
│   │   │   └── journal_screen.dart
│   │   ├── prayers/
│   │   │   └── prayer_screen.dart
│   │   ├── reading/
│   │   │   └── reading_plan_screen.dart
│   │   ├── lyrics/
│   │   │   └── lyrics_screen.dart
│   │   └── church_info/
│   │       └── church_info_screen.dart
│   │
│   ├── widgets/
│   │   ├── custom_button.dart
│   │   ├── custom_textfield.dart
│   │   ├── page_header.dart
│   │   └── loading_indicator.dart
│   │
│   └── navigation/
│       ├── app_router.dart
│       └── bottom_nav.dart
│
└── state/
    ├── auth_provider.dart
    ├── user_provider.dart
    ├── reading_plan_provider.dart
    ├── journal_provider.dart
    └── prayer_provider.dart
