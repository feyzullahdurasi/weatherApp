# Weather App

A SwiftUI-based iOS weather application that provides current weather information and forecasts.

## Features

- Current weather display
- Weather forecasts
- Location-based weather information
- Search functionality for different locations
- Customizable settings
- iOS widget support

## Technologies Used

- SwiftUI
- WidgetKit
- SDWebImageSwiftUI

## Project Structure

The project is organized into the following main components:

- `weatherApp`: The main application target
  - `ui`: Contains the user interface components
    - `weather`: Weather-related views and view models
    - `detail`: Detailed weather information views and view models
  - `data`: Data models and API services

- `WidgetExtension`: The widget extension target

## Setup and Installation

1. Clone the repository
2. Open `weatherApp.xcodeproj` in Xcode
3. Ensure you have the necessary developer account set up in Xcode
4. Build and run the project on your iOS device or simulator

## Dependencies

This project uses the following third-party library:

- [SDWebImageSwiftUI](https://github.com/SDWebImage/SDWebImageSwiftUI): For efficient image loading and caching

The dependency is managed using Swift Package Manager and should be automatically resolved when opening the project in Xcode.

## Configuration

The app requires location permissions to function properly. Make sure to grant the necessary permissions when prompted.

## Widget Support

The app includes a widget extension that allows users to add weather information to their home screen. To use the widget:

1. Long press on the home screen
2. Tap the "+" button
3. Search for "Weather"
4. Choose the desired widget size and add it to your home screen
