## Interceptor-Based Network Layer 

```
Presentation (SwiftUI Views)
    ↓
ViewModel (MVVM)
    ↓
UseCase (Domain Layer)
    ↓
Repository (Abstraction)
    ↓
Network Layer (Data Layer)
    ↓
Interceptor Chain
    ↓
URLSession

```
 
### 🎯 Goals of Interceptor-Based Networking

 An interceptor allows you to:

 - Add auth tokens automatically
 - Log requests & responses
 - Handle retries
 - Refresh tokens
 - Global error handling
 - Modify headers dynamically
