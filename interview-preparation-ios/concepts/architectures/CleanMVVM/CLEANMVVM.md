## Clean Architecture + MVVM (Clean. Testable. Scalable.)

### 🔹 What is Clean Architecture?

Introduced by Robert C. Martin (Uncle Bob), Clean Architecture is based on layers arranged in concentric circles.

- Clean Architecture organizes your app by layers of responsibility

Core idea:
> 👉 Dependencies always point inward.

### 🔹 Typical Layers

| Entities – Enterprise business rules
| Use Cases – Application-specific business rules
| Interface Adapters – Controllers, Presenters, Gateways
| Frameworks & Drivers – UI, DB, external tools

### ✅ Strengths

 - Framework-independent
 - Highly testable
 - Flexible
 - Long-term maintainability
 - Scales very well

### ❌ Weaknesses
 - More abstract
 - Can feel complex
 - Learning curve
 
### Structure:

 - 1️⃣ DOMAIN LAYER (Pure Business Logic)

    ❗ No SwiftUI
    ❗ No URLSession
    ❗ No frameworks

    - Entities
    - UseCases
    
 - 2️⃣ DATA LAYER (Implementation Details)

    This is where networking happens.
    
    - Repositories
    - API
    
 - 3️⃣ PRESENTATION LAYER (MVVM)
    - View
    - ViewModel
    
 - 4️⃣ Dependency Injection (Glue Everything Together)

### Flow:

View → ViewModel → UseCase → Repository → API

### Layers
* **Domain Layer** = Entities + Use Cases + Repositories Interfaces
* **Data Repositories Layer** = Repositories Implementations + API (Network) + Persistence DB
* **Presentation Layer (MVVM)** = ViewModels + Views

![Alt text](ReadMeImages/CleanArchitectureDependencies.png?raw=true "Modules Dependencies")

### Why it’s popular:

 - Clean layering
 - Less boilerplate than VIPER
 - Works great with SwiftUI
 - Scales well


### Folder Structure 

```
MyApp/
│
├── Domain/
│   ├── Entities/
│   │   ├── User.swift
│   │
│   ├── UseCases/
│   │   ├── LoginUseCase.swift
│   │   ├── SignupUseCase.swift
│   │   ├── FetchProfileUseCase.swift
│   │   ├── LogoutUseCase.swift
│   │
│   ├── Repositories/
│       ├── AuthRepository.swift
│       ├── UserRepository.swift
│
├── Data/
│   ├── Network/
│   │   ├── APIClient.swift
│   │
│   ├── DTOs/
│   │   ├── UserDTO.swift
│   │
│   ├── Repositories/
│       ├── AuthRepositoryImpl.swift
│       ├── UserRepositoryImpl.swift
│
├── Presentation/
│   ├── App/
│   │   ├── AppView.swift
│   │   ├── AppViewModel.swift
│   │
│   ├── Login/
│   │   ├── LoginView.swift
│   │   ├── LoginViewModel.swift
│   │
│   ├── Signup/
│   │   ├── SignupView.swift
│   │   ├── SignupViewModel.swift
│   │
│   ├── Dashboard/
│   │   ├── DashboardView.swift
│   │   ├── DashboardViewModel.swift
│   │
│   ├── Settings/
│   │   ├── SettingsView.swift
│   │   ├── SettingsViewModel.swift
│
└── App/
    ├── DependencyContainer.swift
    ├── MyApp.swift

```

### 🔥 What This Architecture Gives You

 - Multiple screens cleanly separated
 - Business logic isolated
 - Easy to unit test
 - Easy to scale to 50+ screens
 - Replace backend without touching UI
 - Clear navigation control

### 🏢 Enterprise Folder Structure (Feature Modular)

```
MyApp/
│
├── App/
│   ├── MyApp.swift
│   ├── AppView.swift
│   ├── AppViewModel.swift
│   ├── AppDIContainer.swift
│
├── Core/
│   ├── Networking/
│   ├── Persistence/
│   ├── Extensions/
│   ├── DesignSystem/
│
├── Domain/
│   ├── Entities/
│   ├── UseCases/
│   ├── Repositories/
│
├── Data/
│   ├── Network/
│   ├── Persistence/
│   ├── RepositoryImplementations/
│
├── Features/
│   ├── Auth/
│   │   ├── Presentation/
│   │   ├── DI/
│   │   ├── Tests/
│   │
│   ├── Dashboard/
│   │   ├── Presentation/
│   │   ├── DI/
│   │
│   ├── Settings/
│   │   ├── Presentation/
│   │   ├── DI/
│
├── Shared/
│   ├── Components/
│   ├── ViewModifiers/
│
└── Resources/
```

## Analytics

```
Presentation (ViewModel)
        ↓
Domain (AnalyticsTracking protocol)
        ↓
Data (FirebaseAnalyticsService)
        ↓
Firebase SDK

```

Dependency rule respected:
 - Outer layers depend on inner
 - Domain does NOT depend on Firebase

### ❌ Common Mistakes

Bad practice:
 - ❌ Calling Firebase directly in ViewModel
 - ❌ Importing Firebase in Domain
 - ❌ Passing [String: Any] everywhere
 - ❌ Hardcoding event names in UI

### 🧠 Final Clean Architecture Mapping
Layer               Responsibility
Domain              Define AnalyticsTracking protocol + events
Data                Implement SDK wrapper
Presentation        Call analytics
DI                  Inject implementation

### 🏆 Final Result
You now have:
 - Analytics decoupled from UI
 - Business-level events
 - Swappable providers
 - Testable tracking
 - Clean layering
