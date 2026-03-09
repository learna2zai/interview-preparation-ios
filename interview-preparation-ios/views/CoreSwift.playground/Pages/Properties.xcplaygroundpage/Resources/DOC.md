Swift Properties & Methods Cheat Sheet
1️⃣ Stored Property

Definition: Stores a value in memory.

Syntax:

var count: Int = 0

Can have observers (willSet, didSet)

var score: Int = 0 {
    willSet { print("New score: \(newValue)") }
    didSet { print("Old score: \(oldValue)") }
}
2️⃣ Lazy Stored Property

Definition: Stored property initialized only when first accessed.

Keyword: lazy

Syntax:

lazy var database = DatabaseConnection()

Access: First time only → value is stored

3️⃣ Computed Property

Definition: Doesn’t store value, calculates each time it’s accessed.

Syntax (read-only):

var area: Int { width * height }

Syntax (read-write):

var area: Int {
    get { width * height }
    set { width = newValue / height }
}

Observation: Use setter instead of willSet/didSet.

4️⃣ Property Observers
Observer    When runs?    Parameter    Notes
willSet    Before value changes    newValue    Can access old via property itself
didSet    After value changes    oldValue    Can access new via property itself

Tip: Only for stored properties, not computed.

5️⃣ Overriding Properties

Stored property in superclass → cannot override directly

Override stored property as computed in subclass

class Vehicle { var speed: Int = 0 }
class Car: Vehicle {
    override var speed: Int {
        get { super.speed }
        set {
            super.speed = newValue
            print("Car speed updated")
        }
    }
}

Combines getter/setter + observation in subclass.
