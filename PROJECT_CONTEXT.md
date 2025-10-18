# Konek Frontend - Project Context

## Project Overview
Konek is an open-source, self-hostable messaging application frontend built with Flutter. It provides a Discord/Slack/Google Chats-like experience for team communication.

## Architecture

### Design Pattern
- **Primary Architecture**: Clean Architecture with Feature-First Layering
- **Project Structure**:
  ```
  lib/
  ├── features/
  │   ├── [feature_name]/
  │   │   ├── data/
  │   │   │   ├── datasources/
  │   │   │   ├── models/
  │   │   │   └── repositories/
  │   │   ├── domain/
  │   │   │   ├── entities/
  │   │   │   ├── repositories/
  │   │   │   └── usecases/
  │   │   └── presentation/
  │   │       ├── bloc/
  │   │       ├── pages/
  │   │       └── widgets/
  │   └── [other features...]
  ├── core/
  │   ├── constants/
  │   ├── errors/
  │   ├── extensions/
  │   └── utils/
  └── main.dart
  ```

### State Management
- **Primary**: Flutter Bloc (BLoC pattern)
- **Testing**: bloc_test for bloc testing
- **Separation of concerns**: UI presentation layer uses BLoCs to manage state

## Core Dependencies

### Navigation & Routing
- **go_router**: Feature-based routing with deep linking support

### State Management
- **flutter_bloc**: Core state management using BLoC pattern
- **bloc_test**: Testing BLoCs

### Local Storage & Database
- **sqflite**: Local SQL database for offline functionality and data caching
- **shared_preferences**: Key-value storage for user preferences and settings (future implementation for offline functionality)

### Networking & API Communication
- **dio**: HTTP client for API requests with interceptors
- **web_socket_channel**: WebSocket support for real-time messaging

### Authentication
- **JWT Tokens**: Token-based authentication (handled in data layer)
- Storage in secure manner (consider flutter_secure_storage for sensitive tokens)

### Push Notifications
- **OneSignal**: Push notification service (free tier)

### Media & File Handling
- **image_picker**: Camera and gallery access for image selection
- **file_picker**: File selection for file sharing

### Permissions & Connectivity
- **permission_handler**: Runtime permission management for camera, microphone, gallery, etc.
- **connectivity**: Network connectivity monitoring

### Logging & Debugging
- **logger**: Structured logging for debugging and monitoring

### Testing
- **flutter_test**: Flutter's built-in testing framework
- **bloc_test**: BLoC-specific testing utilities
- **mockito**: Mocking library for unit tests

## Platform Support

### Current Support
- **macOS** ✓
- **Windows** ✓

### Planned Support (Future)
- **iOS** (awaiting developer profiles)
- **Android** (awaiting developer profiles)

### Not Planned
- **Web** (not in initial scope, but Flutter Web setup already exists)
- **Linux** (not in initial scope, but Flutter Linux setup already exists)

## Feature Modules (Planned/In Progress)

Example feature structure:
- **Authentication**: Login, Registration, JWT token management
- **Messaging**: Message sending/receiving, real-time updates via WebSocket
- **Channels/Conversations**: Channel management, message history
- **User Profile**: User settings, preferences
- **Media**: Image/file sharing and management
- **Connectivity**: Offline detection and handling

## API Integration

### Backend
- **Java Spring Boot** API backend
- **PostgreSQL** database
- **Docker**: Spring Boot API and PostgreSQL can be containerized

### Communication
- **REST API**: Standard HTTP requests via Dio
- **WebSocket**: Real-time messaging via web_socket_channel
- **Authentication**: JWT token-based with Bearer authorization

## Data Flow

1. **Presentation Layer**: Flutter widgets + BLoC
2. **Domain Layer**: Entities, Repositories (interfaces), Use Cases
3. **Data Layer**: Datasources (API/Local), Models, Repository implementations
4. **External**: REST API (Dio), WebSocket (web_socket_channel), Local DB (sqflite)

## Error Handling

- Custom exception classes in `core/errors/`
- BLoC states to represent error states
- User-friendly error messages in presentation layer

## Dependencies Notes

### Future Considerations
- **shared_preferences**: Add when offline functionality is implemented
- **flutter_secure_storage**: Consider adding for secure token storage
- **firebase_crashlytics** or similar: Add when production monitoring is needed

### OneSignal Notes
- Free tier available
- Integration requires platform-specific setup
- Configure in both Android (Firebase) and iOS (APNs) when those platforms are ready

## Development Guidelines

1. **Feature-First Organization**: Each feature is self-contained and independently testable
2. **Separation of Concerns**: Clear boundaries between presentation, domain, and data layers
3. **Dependency Injection**: Use service locators or get_it for dependency management (consider adding if not using)
4. **Error Handling**: Consistent error handling across the app
5. **Logging**: Use logger package for debugging

## Testing Strategy

- **Unit Tests**: Test use cases, repositories, and BLoCs using mockito
- **Widget Tests**: Test individual widgets
- **Integration Tests**: Test feature flows
- **Mock External Services**: Mock API calls and local storage for testing

## Build & Run

### Prerequisites
- Flutter SDK installed
- Dart SDK (included with Flutter)
- Running Konek backend (Java Spring Boot + PostgreSQL)
- Docker (optional, for backend setup)

### Commands
```bash
# Get dependencies
flutter pub get

# Run app
flutter run -d macos  # or -d windows for Windows

# Run tests
flutter test

# Build for distribution
flutter build macos
flutter build windows
```

## Git Workflow

- Branch naming: `feature/feature-name`, `fix/bug-name`, `docs/documentation`
- Commit messages: Clear and descriptive
- PR reviews before merging to main

---

**Last Updated**: October 18, 2025  
**Project Lead**: Delthoid  
**Repository**: konek_frontend
