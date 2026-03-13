//: [Previous](@previous)

import Foundation
import PlaygroundSupport

PlaygroundPage.current.needsIndefiniteExecution = true

actor DataManager {
    var data: [String] = []
}

// let manger = DataManager()
// let someData = manger.data

// Explaination:
// Actors protect their state using actor isolation.
// So any property or method that belongs to an actor is isolated to that actors execution context.
// That means external code cannot access it synchronously. In order to access it asynchronously we have async context and await for wating to retrun value.

func seeData() async {
    let manger = DataManager()
    let someData = await manger.data
}

//await seeData()
//PlaygroundPage.current.finishExecution()

// actor isolation + async access.

/**
 
 A slightly stronger senior-level phrasing would be:
 
 Actors protect isolated mutable state
 Access from outside the actor may require suspending the current task
 await indicates a possible suspension point while the actor processes requests sequentially

 So the key idea is:
 ➡️ await signals that the task may suspend while waiting for the actor to provide access.
 */

/**
 SwiftUI View is a value type, so its properties are immutable during rendering.

 Without state management:
 The view doesn't trigger re-render
 The compiler may complain about mutation in a struct
 
 */


// MARK: - Weak vs Unowned

class SomeClass {
    
    func someAction() {
      let data =  { [unowned self] in
          self.fetchData()
        }
    }
    
    func fetchData() {}
}
/**
 A clearer interview-quality explanation

 weak:
 Reference becomes nil automatically when the object is deallocated
 Always declared as optional
 Safe to use when the lifetime of the object is uncertain

 unowned:
 Does not become nil
 Assumes the object will always exist
 If the object is deallocated and accessed → runtime crash

 So in our closure case:
 completion = { [weak self] in
     self?.handleResponse()
 }

 We use weak because:
 The closure might execute after NetworkManager is deallocated
 Using unowned could cause a crash
 */

// MARK: - State

import SwiftUI

/**
 SwiftUI View is a value type, so its properties are immutable during rendering.

 Without state management:
 -  The view doesn't trigger re-render
 -  The compiler may complain about mutation in a struct

 Correct approach conceptually:

 @State private var count = 0

 Then the button modifies the state.
 When count changes → SwiftUI invalidates the view and recomputes body.
 */

class User: ObservableObject {
    @Published var name: String = "World"
    @Published var age: Double = 0.0
    
    init() {
        print("Called....")
    }
}

struct ProfileView: View {
    @ObservedObject var user: User = User()
    @Binding var age: Double
    
    var body: some View {
        VStack {
            Text("hello")
            Slider(value: $age, in: 1...100)
                .frame(maxWidth: .infinity)
        }
        .padding()
        .frame(width: 200, height: 200)
    }
}

struct SomeParentView: View {
    @State var age: Double = 50.0
    
    var body: some View {
        if age > 80 {
            EmptyView()
        } else {
            ProfileView(age: $age)
        }
    }
}

var profileView =  SomeParentView()
PlaygroundPage.current.setLiveView(profileView)

/**
 Issue with above code is - object creation inside the view with @ObservedObject.
 
 Why this problem is:
  - SwiftUI views are recreated frequently when the state changes.
  - with User() - a new model instance may be created multiple times which cause:
    - state reset
    - repeated network call
    - lost data
 
 Correct Ownership Rule (Very important interview concept)
 
 | Property Wrapper     | When to use                                |
 | -------------------- | ------------------------------------------ |
 | `@StateObject`       | View **creates and owns** the object       |
 | `@ObservedObject`    | Object is **created outside and injected** |
 | `@EnvironmentObject` | Shared dependency from environment         |

 // StateObject -  ensures:
    The object is created once
    It persists across view re-renders
 
 // ObservedObjects - ensures
    The parent view creates the ViewModel
    ProfileView only observes it
    Ownership stays with the parent
 
 Use @StateObject when the View owns the object.
 Use @ObservedObject when the object is provided by another view.
 
 1️⃣ Current Problem

 In your code:

 struct ProfileView: View {
     @ObservedObject var user: User = User()
     ...
 }

 Every time ProfileView is created, a new User() is instantiated.

 This defeats the purpose of @ObservedObject, because it’s supposed to observe a shared object, not create a fresh one each time.

 That’s why we usually do:

 @StateObject var user = User()
 
 @StateObject initializes the object once for the lifetime of the view, and SwiftUI keeps it alive across view refreshes.

 ✅ So the fix in traditional SwiftUI is to use @StateObject when the view owns the object.
 
 2️⃣ Why not @State?

 @State is meant for value types (like Int, String, Bool) that SwiftUI manages internally.

 You cannot use @State for ObservableObject and expect @Published properties to trigger view updates correctly.

 @State does not conform to ObservableObject, so you lose the reactive behavior.

 3️⃣ The New Observation Framework

 Swift recently introduced Swift 5.9 Observation (aka @Observable) in SwiftUI / Swift Concurrency. Some key differences:

 You can now declare classes as observable without ObservableObject:

 import Observation

 @Observable
 class User {
     var name: String = "World"
     var age: Double = 0.0
 }

 Then in the view you can just do:

 struct ProfileView: View {
     @State var user = User() // works because Observation framework observes automatically
 }

 Here, @State works because SwiftUI + Observation now tracks property changes, unlike old @State which only works for value types.

 4️⃣ So to answer your question:
 Can we use @State instead of @StateObject in the new Observation framework?
 ✅ Yes, in Swift 5.9+ with @Observable, because the Observation system tracks changes automatically.
 ❌ No, in classic SwiftUI (ObservableObject), because @State won’t trigger updates from @Published properties.
 
 */

// MARK: - List View issue - indices

struct Todo: Identifiable {
    var id = UUID()
    var text: String
}

struct TodosView: View {
    
    @State private var todos: [Todo] = [
        Todo(text: "Learn Swift Programming"),
        Todo(text: "Prepar for interview."),
        Todo(text: "Get Job")
    ]
    
    var body: some View {
        VStack {
            List(todos.indices, id: \.self) { index in
                Text(todos[index].text)
            }
            Button("Remove First") {
                todos.removeFirst()
            }
        }
        .frame(width: 400, height: 400)
    }
}

PlaygroundPage.current.setLiveView(TodosView())

/**
 
 1. Problem with using indices
 After removing first:

 0 → Task2
 1 → Task3

 SwiftUI thinks:

 Row 0 changed from Task1 → Task2
 Row 1 changed from Task2 → Task3
 
 Instead of:

 Delete Task1
 Move Task2
 Move Task3

 So SwiftUI diffing becomes incorrect, causing:
 wrong animations
 incorrect UI updates
 performance issues
 
 2. Correct way to build the List
 Since Todo already conforms to Identifiable, SwiftUI can track items using stable identity.
 Conceptually it should iterate directly over the data.
 
 3. Why stable identity matters

 SwiftUI performs diffing between view updates.
 Stable identity allows SwiftUI to determine:
  - which rows were inserted
  - which were deleted
  - which were moved
  - which simply changed

 Without stable identity SwiftUI may:
  - recreate views unnecessarily
  - produce wrong animations
  - cause state loss in rows
 */

// MARK: - Value Scemantice vs Reference Scemantics

/**
 Reference vs value semantics: critical in Swift for function arguments, SwiftUI state management, and performance reasoning

 Explaining why it happens is just as important as what happens

 Bonus: Mention that using inout can allow a struct to be mutated inside a function
 */

// MARK: - SwiftUI State Propogation & Performance

class AppSettings: ObservableObject {
    @Published var username: String = "SwiftLover"
    @Published var isDarkMode: Bool = false
}

struct HeaderView: View {
    
    @ObservedObject var appSettings: AppSettings
    
    var body: some View {
        Text("Hello,  \(appSettings.username)")
            .padding()
    }
}

struct SettingsView: View {
    @StateObject var appSettings: AppSettings = AppSettings()
    
    var body: some View {
        VStack {
            HeaderView(appSettings: appSettings)
            Toggle("Dark Mode", isOn: $appSettings.isDarkMode)
            Text("Dark mode is \(appSettings.isDarkMode ? "on" : "off")")
        }
    }
}

PlaygroundPage.current.setLiveView(SettingsView())

/**
 
 1️⃣ What happens now
 @Published var isDarkMode: Bool = false

 @Published triggers objectWillChange on the entire AppSettings object
 Any view observing AppSettings will recompute its body, even if it only depends on username
 So HeaderView re-renders unnecessarily, even though it doesn’t care about isDarkMode
 ✅ This is the performance problem.

 2️⃣ Optimization options
 Option 1: Observation framework (@Observable in Swift 5.9+)
 Mark the class as:

 @Observable class AppSettings {
     var username: String = "John"
     var isDarkMode: Bool = false
 }

 Swift automatically creates fine-grained dependency tracking
 Only views using a particular property will re-render
 HeaderView only uses username → won’t re-render when isDarkMode changes
 Toggle and the Text dependent on isDarkMode will update correctly
 
 Option 2: Legacy approach (pre-5.9)

 Split state into separate ObservableObjects
 One for username, one for isDarkMode
 Inject only the relevant object into each view
 Achieves similar fine-grained control

 3️⃣ Principle behind optimization

 SwiftUI uses data-driven view updates
 Observation framework introduces property-level dependency tracking
 This reduces unnecessary view recomputation → better performance, especially in large apps with complex hierarchies
 Key concept: “minimize the number of views that re-render when unrelated state changes”
 
 */


/**
 
 🔥 Senior iOS Interview Questions (Swift, SwiftUI & Architecture)
 1) Swift Concurrency

 ❓ Explain actor isolation and the difference between @MainActor and using DispatchQueue.main.async.
 (emphasis on safe concurrency and main thread requirements)

 2) State Management in SwiftUI

 ❓ What’s the difference between @StateObject, @ObservedObject, and @EnvironmentObject — and when should you use each one?
 (real interview favorite)

 3) Compose SwiftUI & Bindings
 struct ChildView: View {
     var isOn: Bool
     var body: some View {
         Toggle("Enable", isOn: $isOn)
     }
 }

 ❓ Why doesn’t this compile? How do you fix it and explain why?

 (This tests understanding that binding comes from source‑of‑truth state)

 4) Property Wrappers & Data Flow

 ❓ When would you use @AppStorage vs @SceneStorage vs plain UserDefaults?
 (SwiftUI state persistence questions are trending)

 5) Memory Management

 ❓ Explain weak vs unowned — when would using unowned be dangerous?
 (common senior Swift topic)

 6) Architecture

 ❓ How would you structure a large SwiftUI app using MVVM? How do you handle navigation and dependency injection cleanly?
 (companies want architecture depth)

 7) Swift Language — Protocols

 ❓ What is an associated type in a protocol and how do you use it?
 (often seen in senior Swift questions)

 8) Swift Generics

 ❓ Write a generic Cacheable protocol and a concrete implementation for caching objects.
 (This kind of task‑based question is showing up in real interviews)

 9) SwiftUI Optimization

 ❓ Why does using indices in a List cause weird UI behavior? How do you fix it?
 (Real SwiftUI debugging question)

 10) Swift UI Rendering

 ❓ Explain how SwiftUI’s body is recomputed. If you attach .id(UUID()) to a view, what effect does that have?
 (Testing deep SwiftUI lifecycle knowledge)

 11) Async / Await + Networking

 ❓ How do you cancel an async task? What’s the difference between structured concurrency and unstructured tasks?
 (Senior concurrency + cancellation are frequent)

 12) Navigation / Routing

 ❓ In SwiftUI, how do you build a coordinator‑style navigation system that isn’t tightly coupled to view hierarchy?
 (Asked by larger teams building modular apps)

 13) Testing

 ❓ How do you write unit tests for a ViewModel using Combine/async code? How would you test view behavior in SwiftUI?
 (Real senior‑level practical question)
 */
