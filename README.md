# LearnHub – Flutter Learning Dashboard

A Flutter mobile application for browsing courses, tracking lesson progress, and supporting offline access to previously loaded course data.

## 1. Architecture

The application follows a lightweight **MVVM/Clean Architecture approach** using GetX for state management.

The main flow is:

```text
UI
 ↓
GetX Controller / ViewModel
 ↓
Repository
 ↓
Remote API + Local Storage
```

I chose this architecture because it keeps UI, business logic, and data access separated. GetX provides reactive state management and dependency injection, while the Repository layer makes it easier to replace the mock API with a real API without changing the UI.

The application is organized around:

- **Views** – UI and user interaction
- **Controllers** – presentation/business state using GetX
- **Repository** – coordinates remote and local data
- **Models** – application data models
- **Local Storage** – offline course and lesson data

---

## 2. Offline Support

I use **GetStorage** as a lightweight local cache.

After courses are successfully loaded from the API, the course data is stored locally.

When the API request fails, the Repository checks GetStorage and returns the previously cached courses.

```text
API Success
    ↓
Save to GetStorage
    ↓
Display Courses

API Failure / Offline
    ↓
Read GetStorage
    ↓
Display Cached Courses
```

Lesson completion and course progress are also persisted locally so the user's progress can remain available after restarting the application.

---

## 3. Security

In a production application, authentication tokens should not be stored in plain SharedPreferences or GetStorage.

I would use a secure platform-backed solution such as:

- **Android Keystore**
- **iOS Keychain**

In Flutter, this can be accessed through a secure-storage solution such as `flutter_secure_storage`.

Access tokens should also have an appropriate expiration strategy, with refresh tokens handled securely.

---

## 4. Scale

For an application with 1 million users and hundreds of courses, I would improve the following:

1. **Backend scalability**
   - Use horizontally scalable APIs behind a load balancer.
   - Add caching/CDN where appropriate.

2. **Pagination**
   - Avoid downloading hundreds of courses at once.
   - Implement server-side pagination and lazy loading.

3. **Database and caching**
   - Use an optimized production database with proper indexing.
   - Add Redis or another caching layer for frequently requested data.

4. **API and application performance**
   - Use pagination, compression, efficient JSON responses, and background synchronization.
   - Cache frequently accessed data on the device.

5. **Monitoring and reliability**
   - Add crash reporting, analytics, API monitoring, logging, and automated CI/CD.

---

## 5. Second Platform

The application is built using **Flutter**, so the same Dart codebase can be used to build the iOS application.

The existing:

- UI
- GetX controllers
- Repository
- Models
- Business logic

can largely be shared between Android and iOS.

Platform-specific functionality can be isolated behind platform abstractions when required, such as secure storage, notifications, permissions, file handling, or native integrations.

For iOS, I would configure the required Xcode project settings, signing, permissions, deployment target, and App Store configuration while keeping the core Flutter application code shared.

---

## Testing

The project includes a meaningful unit test covering the core progress calculation behavior.

The test verifies that when a pending lesson is marked as completed:

- The lesson status changes.
- The completed lesson count increases.
- The course progress is recalculated correctly.

Run tests with:

```bash
flutter test
```

---

## Tech Stack

- Flutter
- Dart
- GetX
- GetStorage
- MVVM / Repository Architecture
- Material 3

## Features

- Login with validation
- Course dashboard
- Course progress tracking
- Course details
- Lesson completion
- Reactive progress updates
- Loading, empty, and error states
- Offline course caching
- Local lesson progress persistence
- Unit testing
