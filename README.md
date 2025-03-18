# MoveChallange

## Overview

MoveChallange is an app that allows users to explore **Star Wars** characters, films, and spaceships, and save their favorites. Users can browse detailed information about each category and keep track of their favorite characters, films, and spaceships. The app uses **SwiftData** for persistence, ensuring that saved favorites are retained across app launches.

## Architecture Choices

### MVVMC (Model-View-ViewModel-Coordinator)

MVVMC was chosen to separate concerns effectively across the app’s components. This architecture allows for clean management of the UI, data handling, and business logic, promoting easier testing and scalability. The ViewModel handles the logic of retrieving data from APIs or SwiftData, while the View remains purely concerned with the UI.

### Dependency Injection with Swinject

**Swinject** is used for dependency injection, which helps manage the app’s dependencies in a clean and modular way. This approach ensures that the app’s components are loosely coupled, making it easier to test and maintain.

## Known Issues and Areas for Improvement

### SwiftData Error

The app currently encounters the following error:  
`SwiftData: Could not materialize Objective-C class named "Array" from declared attribute value type "Array<String>" of attribute named speciesPersistent.`

This error arises from incorrect attribute type handling in the SwiftData model. A revision of the attribute type is required to fix compatibility issues.

### Deletion Option

Currently, there is no deletion option to remove saved favorites. I would like to implement a feature that allows users to delete characters, films, or spaceships from their saved favorites, with proper confirmation prompts.

### Liked Item Visual Feedback

The app includes the ability to "like" characters, films, and spaceships, but the UI currently does not display a filled heart icon when an item is liked. This will be added to provide visual feedback to users when they save an item to their favorites.

## Contributing

Contributions are welcome! Feel free to fork the repository and submit pull requests. Areas for improvement include:

- Fixing the SwiftData issue related to the `Array<String>` type.
- Adding the option to delete saved favorites.
- Implementing a filled heart icon when an item is liked.

#### Did not focus on git commits due to time crunch.
