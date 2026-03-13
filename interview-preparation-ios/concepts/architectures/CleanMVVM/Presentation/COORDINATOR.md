## Coordinator Pattern in Swift (MVVM)

The Coordinator pattern is commonly used in iOS apps to manage navigation flow outside of ViewControllers. When combined with MVVM, it keeps your architecture clean, testable, and scalable.

A Coordinator in Swift/SwiftUI is a design pattern acting as an architectural component that manages application flow, navigation, and dependency injection outside of the views, separating navigation logic from UI code. 

It decouples screens, enabling better scalability, testability, and reuse of modular components in complex applications. 

### Key Responsibilities of a Coordinator:

- **Navigation Management:** Orchestrates the flow of the app (e.g., pushing, presenting screens) based on user actions or programmatical events.
- **Dependency Injection:** Responsible for creating ViewModels and Views, injecting necessary data, and passing them to the next screen in the flow.
- **Separation of Concerns:** Removes navigation logic from SwiftUI views, keeping them focused solely on rendering data and capturing user input.
- **Coordinating Flow:** Handles complex, multi-screen scenarios by organizing parent and child coordinators to manage specific feature flows (e.g., login, checkout). 

In SwiftUI, a coordinator can be a class (often ObservableObject) that updates a NavigationPath or a View state, allowing the UI to react to navigation changes. It is often used to replace direct NavigationLink usage for more control over navigation flow. 


### Golden Rule

```
AppCoordinator
   ↓ strong
ChildCoordinator
   ↓ strong
ViewController
   ↓ strong
ViewModel
   ↓ weak
Coordinator (via closure)
```

### Coordinator vs Dependency Container

|                    |  Dependency Container             |  Coordinator          |
| ------------------ | --------------------------------- | --------------------- |
| Responsibility     | Creates objects                   | Controls navigation   |
| Layer              | Composition Root (Infrastructure) | Presentation          |
| Knows about        | Services, Repositories, UseCases  | Screens & routes      |
| Owns               | Dependencies                      | Navigation state      |
| Should contain     | Factories                         | No business logic     |
| Should NOT contain | Navigation logic                  | Object creation logic |


### Clean Architecture Layer Placement

```
Presentation
   ├── Views
   ├── ViewModels
   └── Coordinator  ✅

Domain
   ├── Entities
   ├── UseCases
   └── Repository Protocols

Data
   ├── Repository Implementations
   └── API Services

Infrastructure
   └── Dependency Container  ✅
```

- Dependencies flow

`Coordinator → Container → ViewModel → UseCases → Repositories → API`

### Full Flow Diagram

```
AppContainer (builds everything)
        ↓
Coordinator (asks container for VM)
        ↓
SwiftUI View (owns VM with @StateObject)
        ↓
ViewModel (uses UseCases)

```

### Refrences
- [Coordinators & SwiftUI](https://vbat.dev/coordinators-swiftui)
