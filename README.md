# GlobalWeather

# Project Name

Brief project description.

## Table of Contents

- [Project Overview](#project-overview)
- [Architecture](#architecture)
- [Dependencies](#dependencies)
- [Getting Started](#getting-started)
- [Usage](#usage)
- [Contributing](#contributing)
- [License](#license)

## Project Overview

The core functionality of the GlobalWeather is to fetch weather data for the given city location. This feature allows users to quickly check the weather conditions in given location.
Users can also search for weather information for specific locations by entering the city name or coordinates (latitude and longitude)

## Architecture

This project follows the VIPER architecture pattern, which stands for View, Interactor, Presenter, Entity, and Router. It promotes a clean separation of concerns and modularity in the codebase.

- **View**: The View layer in the VIPER architecture is responsible for the user interface (UI) and presentation logic. Its main responsibilities include:

Rendering the user interface elements and displaying data to the user.
Handling user input and interactions, such as button clicks and gestures.
Transmitting user actions to the Presenter for processing.
Listening to updates from the Presenter and displaying data accordingly.
Implementing platform-specific UI components (e.g., iOS UIKit or SwiftUI) based on the design specifications.
Keeping the UI responsive and providing feedback to the user.

- **Interactor**: The Interactor layer contains the application's business logic and serves as an intermediary between the Presenter and the data sources. Its primary responsibilities include:

Processing business logic, including data fetching, validation, and manipulation.
Communicating with external data sources, such as APIs or databases, to retrieve data.
Ensuring data consistency and integrity.
Responding to requests from the Presenter and providing data for presentation.
Handling data caching and storage, if necessary.
Enforcing business rules and application logic independently of the UI.

- **Presenter**: The Presenter layer acts as an intermediary between the View and the Interactor, facilitating communication and controlling the flow of data. Its key responsibilities include:

Receiving user input and translating it into requests for the Interactor.
Formatting and preparing data for presentation.
Sending data to the View for rendering and displaying to the user.
Handling navigation and routing decisions, such as transitioning between screens.
Responding to events from the View, such as user actions or UI updates.
Keeping the View layer agnostic of the business logic by decoupling the UI from the data processing.

- **Entity**: The Entity layer represents the application's data model or domain objects. Its primary responsibilities include:

Defining the structure and attributes of data objects used within the application.
Encapsulating data and behavior specific to these objects.
Maintaining the integrity and consistency of data.
Applying data validation rules and business logic relevant to data entities.
Serving as a representation of real-world entities within the application's domain (e.g., user profiles, weather forecasts, or location data).

- **Router**: The Router layer handles navigation and routing within the application. Its responsibilities include:

Managing the flow of screens or modules within the app.
Handling transitions between different parts of the app, such as pushing or presenting new View controllers.
Deciding which modules or screens to display based on user actions or navigation events.
Navigating to external URLs or deep linking into specific parts of the app.
Coordinating with the Presenter to initiate navigation based on business logic and user interactions.
Ensuring that the app's navigation remains consistent and user-friendly.

Additionally, we use Combine for reactive programming and Composite VIPER Modules for modularization.

## Dependencies

List the major dependencies used in the project, including any third-party libraries or frameworks. Include version numbers if applicable.

- Combine: Reactive programming framework.
- MapKit: Apple's framework for map integration.
- Realm: Persist data
- SnapKit: Layut views
- Alamofire: Networking
- Service Locator: A design pattern used in software development to manage and provide access to various services or dependencies within an application

## Getting Started

Provide instructions on how to set up the project locally and get it running on a developer's machine.

1. Clone the repository: `git clone https://github.com/dmptv/GlobalWeather.git`
2. Install dependencies: `pod install` (if using CocoaPods)
3. Open the Xcode workspace: `open GlobalWeather.xcworkspace`
4. Build and run the project.

## Usage

Explain how to use the project and its features. Include code examples or usage scenarios if necessary.

## Contributing

Describe how others can contribute to the project, including guidelines for submitting pull requests, reporting issues, and code style conventions.

## License

Specify the project's license. For example:

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.


