//: [Previous](@previous)

import Foundation

/**
 
 Imagine your app running.

 Your program gets a big chunk of RAM from the OS.

 Inside that memory there are two very important areas:

 STACK  → fast, small, automatic
 HEAP   → larger, slower, manual/managed

 Very simplified diagram:

 Memory
 │
 ├── Stack
 │   ├── local variables
 │   ├── function calls
 │   └── value types (often)
 │
 └── Heap
     ├── objects
     ├── large data
     └── reference types
 
 
 Why classes go on the heap

 In Swift:

 Structs → value types

 Classes → reference types

 When something is a reference type, multiple variables can point to the same instance, so Swift stores that instance in the heap.

 Example:

 class Car {
     var speed = 0
 }

 let car1 = Car()
 let car2 = car1

 What happens here:

 Stack                Heap
 -----                ----
 car1  ───────────▶  Car instance
 car2  ───────────▶  (speed = 0)

 Both car1 and car2 point to the same object in heap memory.
 
 
 Step 1 — What actually lives in the stack?

 When you write:

 let car1 = Car()

 A variable called car1 is created inside the stack frame of the function.

 But car1 does NOT store the object itself.

 Instead it stores a reference (memory address) that points to the object in the heap.

 Conceptually like:

 Stack
 -----
 car1 = 0x7fa21a

 That 0x7fa21a is just an address in memory.

 Step 2 — Where the actual object lives

 When Car() is created, Swift allocates memory in the heap.

 That heap memory contains the real object:

 Heap
 ----
 0x7fa21a
    └── Car
        speed = 0
 Step 3 — When you assign another variable

 Now you do:

 let car2 = car1

 Swift does NOT copy the object.

 Instead it copies the reference.

 So now memory looks like this:

 Stack
 -----
 car1 = 0x7fa21a
 car2 = 0x7fa21a

 Heap
 ----
 0x7fa21a
    └── Car
        speed = 0

 So both variables point to the same heap object.

 That’s why changing via one variable affects the other.
 
 
 1️⃣ Stack Frames (Function Memory)

 Every time a function runs, the system creates a stack frame.

 Example:

 func test() {
     let car1 = Car()
 }

 When test() starts, memory looks like this:

 STACK (top of stack frame)
 --------------------------
 car1 = 0x7fa21a   ← reference to heap object
 --------------------------

 HEAP
 --------------------------
 0x7fa21a
    Car
    speed = 0

 The stack frame stores:

 local variables

 parameters

 return addresses
 
 
 Let’s connect this to Stack vs Heap

 Earlier we simplified it as:

 Struct → Stack

 Class → Heap

 But Swift is actually smarter than that.

 What really matters is:

 Type    Behavior    Memory idea
 struct    Value copy    usually stack
 class    Reference shared    heap

 But large structs can also go on the heap if Swift decides it's better for performance.

 So the real rule is:

 👉 Value vs Reference matters more than Stack vs Heap.
 
 
 Code:

 class Cat {
     deinit {
         print("Cat removed")
     }
 }

 func test() {
     let c1 = Cat()
 }
 Step 1 — Function starts

 A stack frame for test() is created.

 Conceptually:

 STACK (test frame)
 -------------------
 c1 ───► Cat instance

 HEAP
 -------------------
 Cat object
 Reference count = 1

 c1 holds the only reference to the heap object.
 
 */


// MARK: - Struct (Value Type)
import Foundation

print("=== MEMORY LAYOUT DEMO ===\n")

// MARK: - 1️⃣ Struct (Value Type)
struct Point {
    var x: Int
    var y: Int
}

var p1 = Point(x: 10, y: 20)
var p2 = p1 // copy

withUnsafePointer(to: &p1) { print("p1 stack address:", $0) }
withUnsafePointer(to: &p2) { print("p2 stack address:", $0) }

p2.x = 50
print("p1.x:", p1.x, "p2.x:", p2.x)
print("MemoryLayout<Point>.size:", MemoryLayout<Point>.size)
print("MemoryLayout<Point>.stride:", MemoryLayout<Point>.stride)
print("MemoryLayout<Point>.alignment:", MemoryLayout<Point>.alignment)
print("\n")

// MARK: - 2️⃣ Class (Reference Type)
class Car {
    var speed: Int
    init(speed: Int) { self.speed = speed }
    deinit { print("Car deallocated") }
}

let c1 = Car(speed: 100)
let c2 = c1 // reference copy

print("c1 heap address:", Unmanaged.passUnretained(c1).toOpaque())
print("c2 heap address:", Unmanaged.passUnretained(c2).toOpaque())

c2.speed = 200
print("c1.speed:", c1.speed, "c2.speed:", c2.speed)
print("\n")

// MARK: - 3️⃣ Weak Reference & ARC
class Person {
    var name: String
    weak var friend: Person? // weak breaks retain cycle
    init(name: String) { self.name = name }
    deinit { print("\(name) deallocated") }
}

var alice: Person? = Person(name: "Alice")
var bob: Person? = Person(name: "Bob")

alice!.friend = bob
bob!.friend = alice

alice = nil // ARC sees 0 strong reference for Alice → deinit
bob = nil   // ARC sees 0 strong reference for Bob → deinit
print("\n")

// MARK: - 4️⃣ Manual Heap Allocation
let count = 3
let pointer = UnsafeMutablePointer<Int>.allocate(capacity: count)

pointer[0] = 10
pointer[1] = 20
pointer[2] = 30

for i in 0..<count {
    print("pointer[\(i)] =", pointer[i])
}

pointer.deallocate()
print("\n")

// MARK: - 5️⃣ malloc Example
let size = MemoryLayout<Int>.size * 3
let rawPointer = malloc(size)
let intPointer = rawPointer!.bindMemory(to: Int.self, capacity: 3)

intPointer[0] = 100
intPointer[1] = 200
intPointer[2] = 300

for i in 0..<3 {
    print("intPointer[\(i)] =", intPointer[i])
}

free(rawPointer)
print("\n")

// MARK: - 6️⃣ Stack Variable Inspection
var x = 123
withUnsafePointer(to: &x) { ptr in
    print("Stack address of x:", ptr)
}

// MARK: - UnsafeBufferPointer / UnsafeMutableBufferPointer
// Represent a contiguous block of memory
//Useful for arrays, performance, or C interop

print("UnsafeMutableBufferPointer")
let buffer = UnsafeMutableBufferPointer<Int>.allocate(capacity: 5)
for i in 0..<5 { buffer[i] = i*10 }
for i in buffer { print(i) }
buffer.deallocate()


// MARK: - withUnsafeBytes / withUnsafeMutableBytes
//Lets you access the bytes of a struct or array directly

print("\n withUnsafeBytes / withUnsafeMutableBytes")

struct USPoint { var x: Int32; var y: Int32 }
var p = USPoint(x: 10, y: 20)

withUnsafeBytes(of: &p) { bytes in
    for byte in bytes {
        print(byte)  // prints the raw memory of x & y
    }
}

//: [Next](@next)
