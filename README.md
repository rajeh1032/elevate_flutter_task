# elevate_flutter_task

A clean Flutter application that fetches and displays product data using BLoC and Clean Architecture principles.

This project uses a layered structure based on Clean Architecture:

- **core/** contains API manager, dependency injection, routing, theming, and utility classes
- **Data/** includes data models, remote data sources, and repository implementations
- **Domain/** contains entities, abstract repositories, and use cases
- **presentation/** holds UI and Cubit state management logic for screens like home screen

To run the app:

1. Clone the repository:
   `git clone https://github.com/rajeh1032/elevate_flutter_task.git`

2. Navigate to the project directory and install dependencies:
   `flutter pub get`

3. Then run the project:
   `flutter run`

Key Features:

- Clean Architecture structure
- BLoC for state management
- Dependency Injection
- Remote API integration
- Modular code with reusable components and styles

Example important files:

- `Data/Models/GetProductsDm.dart` – Product data model
- `Domain/entity/GetProductsEntity.dart` – Entity shared across layers
- `core/api manager/api_manager.dart` – Handles API requests
- `presentation/home_screen/ui/` – Main UI
- `core/di/di.dart` – Dependency injection setup

This task is meant for practice and evaluation. Feel free to improve or extend the project.
