## 🔄 Offline-First Architecture

Modern apps must work without internet.

Offline-First means:

| The app works fully without internet. Network sync is secondary.

Key idea:

Local database is the source of truth.
Network updates the local database — not the UI directly.

🎯 Principles
 - Local DB is source of truth
 - Network syncs in background
 - Writes are queued
 - Conflicts are resolved
 - UI always reads from local
 
 ```
 View → Repository → Local DB → UI

Background:
Repository → API → Update Local DB → UI auto-updates
 
 ```
 
 ### Clean Architecture + Offline-First

 ```
 Presentation
    ↓
Domain (UseCases)
    ↓
Repository (decides local vs remote)
    ↓
LocalDataSource ←→  SyncEngine  ←→  API ←→ RemoteDataSource

Note: When remote completes → Local DB updates → UI refreshes automatically.
 
 ```
 
 ### Write Operations (Important!)
 
 Offline writes must be queued.
 Example: User creates a task offline.
 
| Create task → Save locally with "pending" status → SyncEngine sends to server later

**Sync Engine Design**

The SyncEngine runs:
 - On app launch
 - On network reconnect
 - Periodically in background

```swift
// Add Sync Status Field

struct TaskEntity {
    let id: String
    let title: String
    let syncStatus: SyncStatus
}

enum SyncStatus {
    case synced
    case pending
    case failed
}

// SyncEngine Example

final class SyncEngine {
    
    func syncPendingTasks() async {
        
        let pending = localDataSource.fetchPending()
        
        for task in pending {
            do {
                try await remoteDataSource.upload(task)
                localDataSource.markAsSynced(task)
            } catch {
                localDataSource.markAsFailed(task)
            }
        }
    }
}

```
 
### Conflict Resolution Strategies

When both local and remote changed:

**Common Strategies**

 - Last write wins
 - Server wins
 - Client wins
 - Merge fields
 - Manual resolution
 
 ```swift
 final class ConflictResolver {
    
    func resolve(local: Item, remote: Item) -> Item {
        return local.updatedAt > remote.updatedAt ? local : remote
    }
}
 ```
 
 ### Example
 
 ```swift
 
 func fetchDashboard() async throws -> [Item] {
    
    // 1️⃣ Get local first
    let localItems = localDataSource.fetchItems()
    
    // 2️⃣ Trigger background refresh
    Task {
        do {
            let remoteItems = try await remoteDataSource.fetchItems()
            localDataSource.save(remoteItems)
        } catch {
            // Log error but don’t break UI
        }
    }
    
    return localItems
}
 
 ```
 
### Data Layer Structure

```
Data/
├── Local/
│   ├── CoreDataManager.swift
│   ├── LocalUserDataSource.swift
│
├── Remote/
│   ├── APIClient.swift
│   ├── RemoteUserDataSource.swift
│
├── Sync/
│   ├── SyncEngine.swift
│   ├── ConflictResolver.swift
│
└── Repositories/
    ├── UserRepositoryImpl.swift
```

### Local Database Options

For iOS:
 - Core Data
 - SQLite
 - Realm
 - SwiftData (modern Apple stack)

Local DB must support:
 - Queries
 - Observability
 - Transactions

### 🔥 Production Additions
 - Background sync queues
 - Conflict resolution strategy
 - Retry policy
 - Request queue persistence

Offline-first is critical for:
 - Fintech
 - Field apps
 - Messaging apps
 
### 🏆 When to Use Offline-First

Must use if:
 - Users operate in weak connectivity
 - App handles critical data
 - App must feel instant
 - Business requires reliability

### ⚠️ Tradeoffs

Offline-first adds:
 - Complexity
 - Sync logic
 - Conflict handling
 - More testing needs


