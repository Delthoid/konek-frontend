# Konek

An open-source, self-hostable alternative for messaging applications such as Discord, Google Chats, and Microsoft Teams.

## Project Overview

Konek is a free, open-source communication platform designed to provide users with a self-hosted solution for team messaging and collaboration. It combines a modern Flutter frontend with a robust Java Spring Boot backend, offering a seamless communication experience.

## Technology Stack

- **Frontend**: Flutter
- **Backend**: Java Spring Boot
- **Database**: PostgreSQL

## Getting Started

### Prerequisites

- Flutter SDK ([Install Flutter](https://docs.flutter.dev/get-started/install))
- Dart SDK (comes with Flutter)
- A running instance of the Konek backend (Java Spring Boot)
- Docker (optional, for running the Spring Boot API and PostgreSQL database)

### Installation

1. Clone the repository
2. Navigate to the project directory
3. Run `flutter pub get` to install dependencies
4. Run the application with `flutter run`

### Backend Setup

The Spring Boot API and PostgreSQL database can be run using Docker. Refer to the Konek backend repository for Docker setup instructions and docker-compose configuration.

## Project Structure

This is the frontend component of the Konek project. For the backend implementation, refer to the Konek backend repository.

- **lib/**: Dart source code for the Flutter application
- **android/**: Android-specific configuration and code
- **ios/**: iOS-specific configuration and code
- **web/**: Web platform configuration
- **macos/**: macOS platform configuration
- **linux/**: Linux platform configuration
- **windows/**: Windows platform configuration

## Contributing

Contributions are welcome! Please feel free to submit a pull request or open an issue for any bugs or feature requests.

## License

This project is open-source and available under an open-source license.

## Resources

For more information about Flutter development, visit the [Flutter documentation](https://docs.flutter.dev/).
