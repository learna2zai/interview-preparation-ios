1️⃣ Stack vs Heap in Swift: How Swift decides

| Type              | Allocation                         | Notes                                                      |
| ----------------- | ---------------------------------- | ---------------------------------------------------------- |
| **Small structs** | Usually **stack**                  | Copying is cheap, fast access                              |
| **Large structs** | May go **heap**                    | Swift may use **copy-on-write** to avoid expensive copying |
| **Classes**       | **Heap**                           | Always reference type                                      |
| **Closures**      | **Heap** if they capture variables | Otherwise may be stack-allocated                           |


- Example: Small vs Large struct

```swift
struct Small {
    var a: Int
    var b: Int
}

struct Large {
    var data: [Int] // could be 1000 elements
}

var s1 = Small(a: 1, b: 2)    // usually on stack
var l1 = Large(data: Array(0..<1000)) // heap for internal array

```

s1: fits in a few bytes → stays on stack

l1: array is large → array elements live on heap (Swift uses copy-on-write)


### Copy-on-Write (COW)
Swift arrays, strings, dictionaries use COW
Actual memory is shared until a write occurs

Prevents unnecessary heap copies

Example:

```swift
var arr1 = [1,2,3]
var arr2 = arr1  // shares memory
arr2.append(4)   // now arr2 gets its own heap copy
```
 - Example

```swift
struct HugeStruct {
    var data = Array(0..<10000)
}

var h1 = HugeStruct()
var h2 = h1
```
Swift arrays use copy-on-write, so h2 initially shares the same heap memory as h1. Only if you modify h2 will it get its own heap copy.

Visualizing it:
```
STACK
-----
h1 → pointer to array on heap
h2 → pointer to same array on heap

HEAP
-----
[0, 1, 2, ..., 9999]  ← shared by h1 & h2
```

If you now do h2.data.append(10000), Swift creates a new heap allocation for h2.

2️⃣ Memory Alignment

Memory alignment ensures the CPU can access memory efficiently.
Every type has an alignment (e.g., Int = 8 bytes)
Swift may add padding to structs to satisfy alignment

```swift
struct Misaligned {
    var a: Int8
    var b: Int64
}
print(MemoryLayout<Misaligned>.size)     // 16 bytes
print(MemoryLayout<Misaligned>.stride)   // 16 bytes (includes padding)
```

CPU reads in multiples of alignment → faster
Padding avoids misaligned memory access

3️⃣ Optimizations

Stack allocation is fastest
Heap allocation is slower (requires ARC reference counting)
Swift may promote a struct to heap if it’s too big or captured in closures

Use structs for small, frequent data
Use classes for shared, reference-based data

4️⃣ Visual summary of layout

STACK                      HEAP
-----                      ----
Local value types   ───►   Large struct/array data
Function calls      ───►   Class instances
Primitive types     ───►   Copy-on-write buffers

Stack: automatic, fast, limited size
Heap: manual/ARC-managed, slower, flexible size
