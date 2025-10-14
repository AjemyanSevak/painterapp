# Painter App

Painter App is a simple yet powerful drawing platform designed exclusively for iOS. It allows users to express creativity, store artworks securely, and revisit their creations anytime — all powered by Firebase Authentication and Cloud Storage.

🚀 Key Features

🔐 Firebase Authentication:
Register and log in using your email securely through Firebase Auth.

🖌️ Create Your Own Art:
Draw and paint with an intuitive canvas powered by Flutter’s rendering engine.

📸 Upload & Store:
Save your images directly to Firebase Storage, ensuring your artwork is always safe and synced.

📂 Personal Gallery:
Browse all your uploaded images in a beautifully designed gallery screen.

🧭 Smooth Navigation:
Simple and clean 5-screen app flow — Login → Register → Home → Create Image → Gallery.

⚙️ Tech Highlights

Built with Flutter (fully optimized for iOS)
Integrated Firebase Authentication and Storage
Uses Reactive Forms and Cubit architecture for state management
Exports and displays uploaded artwork seamlessly

## Development Environment Setup

Hereafter are the steps to follow to setup a development environment based on Flutter.

Created with
(Flutter (Channel stable, 3.35.0, on macOS 15.6.1 24G90 darwin-x64, locale en-AM)
Xcode - develop for iOS and macOS (Xcode 16.2)
)

1. Install Flutter SDK [Install - Flutter](https://flutter.io/docs/get-started/install)

2. Clone the project

3. Resolve the dependencies `flutter packages get`

4. Run the project with `flutter run`

5. Build for iOS  ```flutter build ios```

## Other commands
flutter gen-l10n
dart run build_runner build --delete-conflicting-outputs

## Directory Structure

🏗️ Project Architecture

Painter App follows a Feature-Based Clean Architecture — a scalable, modular, and test-friendly structure commonly used in production Flutter apps.

- `/pubspec.yaml` - project configuration and dependencies
- `/assets` - resouces, such as images, fonts, icons shipped with the app
- `/ios` - ios project and configurations
- `/lib` - root of the app code base
- - `/main.dart` - starting point of the app
- - `/ui` - app UI components, UI layer
- - `/widgets` - app shared UI components
- - `/model` - Data models
- - `/base` - contains app base toolings and constants
- - - `/config.dart` - config loader class
- - - `/routes.dart` - class contains app routes constants.

```sh
lib/
│
├── base/                → Global constants, themes, extensions, helpers
├── core/                → Core services (API, routing, environment, etc.)
├── cubit/               → BLoC / Cubit state management layer
├── firebase/            → Firebase initialization & services
├── l10n/                → Localization files (multi-language support)
├── models/              → Data models & serializers (using built_value)
│   └── auth/            → Authentication-related data models
│
├── ui/                  → Presentation layer (feature-based)
│   ├── home/            → Home screen UI & logic
│   ├── login/           → Login page
│   ├── registration/    → Registration page
│   ├── painter_new/     → Create new drawing screen
│   ├── painter_edit/    → Edit existing drawings
│   └── overlay/loading/ → Loading overlays & UI feedback
│
├── widgets/             → Shared UI components
│
├── firebase_options.dart → Firebase configuration (auto-generated)
└── main.dart             → App entry point (initialization, routes, theme)    
|       
└── README.md
```


Architecture Principles

This structure combines Clean Architecture principles with Feature-Based modularity:

Layer	Responsibility
UI / Presentation	Widgets, screens, and visual components. Communicates with Cubits or BLoCs.
Logic / State (Cubit)	Business logic and state management; handles events and updates UI states.
Data / Core	Networking (Dio), Firebase, environment handling, dependency injection (get_it).
Models	Immutable data structures and serializers (built_value, built_collection).
Base / Utils	Global constants, extensions, and reusable helpers.

🔌 Technologies Used

State Management: BLoC
 / Cubit
Networking: Dio
Dependency Injection: GetIt
Data Models: built_value
Forms: reactive_forms
Firebase: Auth, Firestore, Storage
Routing: go_router
Localization: l10n + intl


### Libraries & Tools Used

* [connectivity](https://pub.dev/packages/connectivity) (Flutter plugin for discovering the state of the network (WiFi & mobile/cellular) connectivity on Android and iOS.)

* [image_picker](https://pub.dev/packages/image_picker) (Flutter plugin for selecting images from the Android and iOS image library, and taking new pictures with the camera.)

* [cupertino_icons](https://pub.dev/packages/cupertino_icons) — Default iOS-style icons for Flutter apps.

* [bloc](https://pub.dev/packages/bloc) — Predictable state management library for Dart and Flutter.

* [flutter_bloc](https://pub.dev/packages/flutter_bloc) — Flutter widgets and utilities for integrating the bloc state management pattern.

* [reactive_forms](https://pub.dev/packages/reactive_forms) — Powerful model-driven forms with validation and reactive updates.

* [flutter_secure_storage](https://pub.dev/packages/flutter_secure_storage) — Securely stores key-value data on Android and iOS (encrypted).

* [shared_preferences](https://pub.dev/packages/shared_preferences) — Stores small key-value data locally (e.g. user settings).

* [built_value](https://pub.dev/packages/built_value) — Generates immutable value types and serializers for Dart.

* [built_collection](https://pub.dev/packages/built_collection) — Immutable collection classes used with built_value.

* [flutter_localization](https://pub.dev/packages/flutter_localization) — Simplifies adding multi-language support to your app.

* [intl](https://pub.dev/packages/intl) — Provides internationalization, date/time formatting, and localization utilities.

* [dio](https://pub.dev/packages/dio) — Powerful HTTP client for Dart with interceptors, configuration, and file upload/download.

* [rxdart](https://pub.dev/packages/rxdart) — Reactive extensions for Dart streams with operators like debounce and combineLatest.

* [auto_size_text](https://pub.dev/packages/auto_size_text) — Automatically resizes text to fit within its bounds.

* [google_fonts](https://pub.dev/packages/google_fonts) — Easily use Google Fonts in your Flutter project.

* [fluttertoast](https://pub.dev/packages/fluttertoast) — Display customizable toast messages on Android and iOS.

* [flutter_dotenv](https://pub.dev/packages/flutter_dotenv) — Load environment variables from a .env file.

* [get_it](https://pub.dev/packages/get_it) — Simple and efficient service locator for dependency injection.

* [flutter_native_splash](https://pub.dev/packages/flutter_native_splash) — Automatically generates native splash screens for Android and iOS.

* [go_router](https://pub.dev/packages/go_router) — Declarative, URL-based navigation and routing for Flutter.

* [flutter_colorpicker](https://pub.dev/packages/flutter_colorpicker) — Simple color picker widgets for Flutter.

* [connectivity_wrapper](https://pub.dev/packages/connectivity_wrapper) — Detects and displays network connection status in Flutter apps.

* [image_picker](https://pub.dev/packages/image_picker) — Select images from gallery or capture via camera.

* [share_plus](https://pub.dev/packages/share_plus) — Share text, files, or links to other apps.

* [flutter_local_notifications](https://pub.dev/packages/flutter_local_notifications) — Display local notifications on Android, iOS, macOS, and more.

* [firebase_core](https://pub.dev/packages/firebase_core) — Required for initializing and connecting your app with Firebase.

* [firebase_auth](https://pub.dev/packages/firebase_auth) — Firebase Authentication for user sign-up, sign-in, and account management.

* [cloud_firestore](https://pub.dev/packages/cloud_firestore) — Cloud Firestore database plugin for real-time app data.

* [firebase_storage](https://pub.dev/packages/firebase_storage) — Firebase Cloud Storage plugin for uploading and managing files.


  assets:
    - assets/icons/
    - assets/images/
    - assets/

## Maintainers
- Sevak Ajemyan - Flutter developer

