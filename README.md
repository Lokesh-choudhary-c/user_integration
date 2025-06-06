# Flutter Assessment App – User Management with BLoC & DummyJSON

This Flutter app demonstrates a complete user management flow using BLoC pattern and integrates with the DummyJSON API. It features pagination, search, user detail views, offline caching, and modern UI with dark mode support.

---

## Features

- Infinite scroll and pull-to-refresh
- Real-time user search
- User detail with posts and todos
- Create post (stored locally)
- Light/Dark mode toggle
- API integration using DummyJSON
- Offline caching with SQLite
- Clean architecture (BLoC + Repository pattern)

---

## Demo Video / Screenshots

###  Video Demo

assets/video/

### Screenshots

assets/screenshots/

---

##  Setup Instructions

```bash
git clone https://github.com/Lokesh-choudhary-c/user_integration.git
cd flutter-user-management-app
flutter pub get
flutter run



lib/
├── blocs/              # All BLoC files: events, states, cubits
│   ├── user/           # UserBloc (fetch, search, paginate)
│   ├── post/           # PostBloc (load/create)
│   ├── todo/           # TodoBloc (load)
│   └── theme/          # ThemeCubit (dark/light mode toggle)
│
├── models/             # Data models (User, Post, Todo)
├── repositories/       # API logic
│   └── user_repository.dart
│
├── screens/            # UI Screens
│   ├── user_list_screen.dart
│   ├── user_detail_screen.dart
│   └── create_post_screen.dart
│
├── theme/              # Light/Dark themes
└── main.dart           # App entry point


### Architecture Overview

The app follows the Clean Architecture principles with BLoC for state management:

BLoC Pattern (flutter_bloc) to separate business logic from UI.

Repository Layer abstracts the DummyJSON API.

Service Layer handles API requests using http.

StatefulWidget + BLoCBuilder to render the UI based on state changes.#   u s e r _ i n t e g r a t i o n 
 
 # user_integration
