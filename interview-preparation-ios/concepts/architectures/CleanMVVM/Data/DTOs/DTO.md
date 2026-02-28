## DTO (Data Transfer Object)

It is used to transfer data between external systems (API, database, Firebase, etc.) and your app — without leaking those external formats into your domain layer.

### How DTO Flows Through the Architecture
```
API → DTO → Mapper → Domain Model → ViewModel → View
```
### 🧠 Why Not Use DTO Everywhere?

Because:

 - API format may change
 - You don’t want API field names in your business logic
 - Domain should be independent of external systems
 - Keeps architecture clean & testable

> *DTO protects your Domain layer from external dependencies.*

**In Clean Architecture:**

 - ResponseModel = raw API format
 - DTO = object used by repository
 - Domain Model = business model
 
 ### DTO vs ResponseModel
 
| Concept                        | Meaning                                     | Where It Lives      |
| ------------------------------ | ------------------------------------------- | ------------------- |
| **ResponseModel**              | Model that mirrors API response             | Networking layer    |
| **DTO (Data Transfer Object)** | Object used to transfer data between layers | Data layer boundary |

* 🔹 ResponseModel

  - Mirrors API exactly
  - Tightly coupled to endpoint
  - Often contains nested structures
  - May include unused fields

* 🔹 DTO

  - Cleaned-up transfer object
  - Contains only needed fields
  - May normalize types (e.g., String → Date)
  - Used between Data layer and Domain

<h3> <strong>Note: </strong> In medium/samll projects usally response model is skipped to avoid extra transformation.</h3>

### CASE 1 — Fetching Data (GET Request)

```
View
  ↓
ViewModel
  ↓
UseCase (Domain)
  ↓
Repository (Domain interface)
  ↓
Repository Implementation (Data)
  ↓
API Service
  ↓
ResponseModel
  ↓
DTO
  ↓
Domain Model
  ↑
ViewModel
  ↑
View
```

### CASE 2 — Sending Data (POST Request)

```
View
  ↓
ViewModel
  ↓
Domain Model
  ↓
Mapper
  ↓
DTO
  ↓
API
```
### 🚫 What DTO Should NOT Do

 - Contain business rules
 - Be used directly in Views
 - Be used directly in ViewModels (ideally)
 - Be passed into Domain layer
