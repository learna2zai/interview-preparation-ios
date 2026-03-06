## Coordinator Pattern in Swift (MVVM)

The Coordinator pattern is commonly used in iOS apps to manage navigation flow outside of ViewControllers. When combined with MVVM, it keeps your architecture clean, testable, and scalable.


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
