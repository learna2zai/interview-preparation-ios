## Clean Architecture + MVVM

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
