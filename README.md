# RealEstate App

This is a modern iOS application to discover properties and save your favourites properties, built with Swift, UIKit and SwiftUI and following clean architecture principles.


## 📱 Features

- List properties
- Complete details for real estate
- Manage favourite properties with data persistence using CoreData
- Smooth navigation through UITabBarController and UINavigationController
- Image visualization


## 🏗️ Architecture

The project follows VIPER and some MVVM for SwiftUI presentation with a focus on SOLID principles:

- **Views**: Scenes and views using UIKit and SwiftUI
- **Interactor and services**: Domain and data (network and repository)
- **Presenter (ViewModel - SwiftUI)**: Presentation logic and data transformation
- **Entities**: Basic data representation like 'RealEstate', 'RealEstateDetail'
- **Router**: Navigation between views


### Implemented patterns

- **Dependency Injection**: To facilitate testing and decoupling
- **Factory Pattern**: Creation of UI modules
- **Coordinator Pattern**: Centralized navigation management
- **Repository Pattern**: Abstraction of data sources
- **Builder Pattern**: Construction of a complex object from its presentation
- **Delegation Pattern**: Class or structure can pass on (delegate) some of its responsibilities to an instance of another type


## 🛠️ Technologies

- **Swift**: Language development
- **SwiftUI**: Apple's declarative UI framework
- **CoreData**: Apple's data persistence framework
- **URLSession**: For network communication
- **Concurrency**: Use of async/await for asynchronous operations
- **Swift Package Manager**: Manage SDKs
- **XCTest**: Unit Testing & UI Testing


![List](https://github.com/user-attachments/assets/a148515c-bf88-4836-9991-f1b319dff7b4)

![Detail](https://github.com/user-attachments/assets/c36c9f88-d9b5-4051-858b-1867f7a018ec)

![Location](https://github.com/user-attachments/assets/2910e8aa-1101-4a81-8fb4-ff1c99bf844b)

![Favourites](https://github.com/user-attachments/assets/c1ea07b8-50db-4728-aff3-eeb88c46d0f0)
