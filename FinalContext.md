# Silent Moon - Final Context & Architecture Documentation

## Project Overview
Silent Moon is a Flutter application designed for meditation, sleep, and relaxation. It utilizes **Clean Architecture** to ensure separation of concerns, scalability, and testability. The project is structured by features, with a core module for shared resources.

## Architecture Pattern
The application strictly follows **Clean Architecture** combined with the **Provider** state management pattern.

### Layers
1.  **Domain Layer** (Inner Circle)
    *   **Entities**: Pure Dart classes representing core business objects (e.g., `Session`, `Track`, `Download`).
    *   **Repositories (Interfaces)**: Abstract definitions of data operations (e.g., `ISessionRepository`).
    *   **Use Cases**: Encapsulate specific business logic/actions (e.g., `GetSessionsUseCase`, `ToggleFavoriteUseCase`).
    *   *Dependencies*: None (pure Dart).

2.  **Data Layer** (Middle Circle)
    *   **Models**: Data transfer objects (DTOs) that extend Entities, handling JSON/Firestore serialization (e.g., `SessionModel`).
    *   **Data Sources**: Low-level data access (Remote via Firestore, Local via Storage).
    *   **Repositories (Implementations)**: Concrete implementations of Domain interfaces, coordinating data sources.
    *   *Dependencies*: Domain Layer, External Packages (Firestore, Firebase Auth).

3.  **Presentation Layer** (Outer Circle)
    *   **Pages/Screens**: UI definitions (e.g., `HomeScreen`, `MusicScreen`).
    *   **Widgets**: Reusable UI components.
    *   **Providers**: State management classes (extending `ChangeNotifier`) that hold business logic state and communicate with Use Cases.
    *   *Dependencies*: Domain Layer, Flutter SDK.

---

## Feature Details

### 1. Core Module (`lib/core`)
Shared infrastructure used across features.
*   **Constants**: `AppColors`, `AppAssets` (Images/Icons), `AppTypography`, `AppStrings`, `AppDimensions`.
*   **Routes**: Centralized navigation via `AppRouter` and `AppRoutes`.
*   **Utils**: `SizeUtils` (Responsive adaptation), `StorageService` (SharedPreferences/SecureStorage wrapper).
*   **Widgets**: `BottomNavBar`, `SharedBottomNav`, `ResponsiveBuilder`.
*   **Theme**: `AppTheme` (Light/Dark mode definitions).

### 2. Authentication (`lib/features/authentication`)
Handles user sign-in, sign-up, and session management.
*   **Data**: `AuthService` (Firebase Auth wrapper).
*   **Presentation**:
    *   `AuthProvider`: Manages user state (`User?`), loading state, and error handling. Checks secure storage for persistent login.
    *   `SignInScreen` / `SignUpScreen`: UI for auth forms.
    *   `SignInSignUpScreen`: Landing page for unauthenticated users.
    *   `AuthWrapper`: Root widget that decides whether to show Home or Auth screens based on session validity.

### 3. Home (`lib/features/home`)
The main dashboard of the application.
*   **Domain**: `Session` entity, `GetSessionsUseCase`.
*   **Data**: `SessionRemoteDataSource` (Firestore 'sessions'), `SessionRepositoryImpl`.
*   **Presentation**:
    *   `HomeProvider`: Fetches and caches sessions.
    *   `HomeScreen`: Displays greetings, daily thought, and a horizontal list of recommended sessions.

### 4. Sleep (`lib/features/sleep`)
Sleep-focused content and music.
*   **Domain**: `Track` entity, `GetTracksUseCase`.
*   **Data**: `TrackRemoteDataSource` (Firestore 'tracks'), `TrackRepositoryImpl`.
*   **Presentation**:
    *   `SleepProvider`: Fetches sleep tracks.
    *   `SleepScreen`: Displays "Sleep Stories" and categories.
    *   `SleepMusicScreen`: Grid view of sleep music tracks.

### 5. Meditation (`lib/features/meditation`)
Meditation courses and topic selection.
*   **Pages**:
    *   `ChooseTopicScreen`: Grid of topics (Stress, Happiness, etc.).
    *   `MeditateScreen`: Main meditation hub with categories and "Daily Calm".
    *   `CourseDetailScreen`: Detailed view of a session, with narrator selection and sub-sessions.

### 6. Music (`lib/features/music`)
Music playback interfaces.
*   **Pages**:
    *   `MusicScreen`: Full-screen player with visualizations (vectors), playback controls, and progress bar.
    *   `MusicV2Screen`: Alternative player design with a lighter theme.
    *   `PlayOptionScreen`: Pre-flight screen showing track details before playing.

### 7. Downloads (`lib/features/downloads`)
Manages offline content.
*   **Domain**: `Download` entity, `GetDownloadsUseCase`, `ToggleDownloadUseCase`.
*   **Data**: `DownloadRemoteDataSource` (Firestore `users/{uid}/downloads`), `DownloadModel`.
*   **Presentation**:
    *   `DownloadProvider`: Manages list of downloaded items and toggle status.
    *   `DownloadScreen`: Grid view of downloaded content.

### 8. Favorites (`lib/features/favorites`)
Manages user favorite items.
*   **Domain**: `Favorite` entity, `GetFavoritesUseCase`, `ToggleFavoriteUseCase`.
*   **Data**: `FavoriteRemoteDataSource` (Firestore `users/{uid}/favorites`), `FavoriteModel`.
*   **Presentation**:
    *   `FavoriteProvider`: Reactive list of favorites.
    *   `FavoriteScreen`: Grid view of favorite items.

### 9. User / Profile (`lib/features/user`, `lib/features/profile`)
User settings and cross-feature user actions.
*   **User Feature (`lib/features/user`)**:
    *   Focuses on logic for toggling states (Favorites/Downloads) via `UserProvider`.
    *   `UserRemoteDataSource`: Low-level Firestore operations for adding/removing IDs from user subcollections.
*   **Profile Feature (`lib/features/profile`)**:
    *   `UserProfileScreen`: UI for viewing avatar, name, email, and accessing Favorites/Downloads/Settings. Handles logout, username updates, and account deletion.

### 10. Reminders (`lib/features/reminders`)
*   **Domain**: `Reminder` entity.
*   **Presentation**: `RemindersPage` with time picker and day selection bubbles.

### 11. Welcome (`lib/features/welcome`)
Onboarding screens.
*   `WelcomeScreen`: "Get Started" landing.
*   `WelcomeSleepScreen`: Specific onboarding for sleep features.

---

## Directory Structure Snapshot

```
lib/
├── core/
│   ├── constants/
│   ├── errors/
│   ├── routes/
│   ├── styles/
│   ├── theme/
│   ├── utils/
│   └── widgets/
├── features/
│   ├── authentication/
│   ├── downloads/
│   ├── favorites/
│   ├── home/
│   ├── meditation/
│   ├── music/
│   ├── profile/
│   ├── reminders/
│   ├── sample/
│   ├── sleep/
│   ├── todo/
│   ├── user/
│   └── welcome/
├── firebase_options.dart
└── main.dart
```

## Key Dependency Injection (`main.dart`)
The app uses `MultiProvider` to inject features at the root level.
*   `AuthProvider`: Available globally.
*   `DownloadProvider`: Injected with `GetDownloadsUseCase` and `ToggleDownloadUseCase`.
*   `UserProvider`: Injected with use cases for managing favorites and downloads references.
*   `HomeProvider`, `SleepProvider`, `FavoriteProvider` are often scoped to specific screens or routes using `ChangeNotifierProvider(create: ...)` within `build` methods or route generators to ensure fresh data loading.

