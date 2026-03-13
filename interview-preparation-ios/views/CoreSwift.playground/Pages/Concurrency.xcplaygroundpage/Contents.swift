//: [Previous](@previous)

import Foundation
import PlaygroundSupport

// MARK: - Swift Concurrency

// Concurrency refers to combonation of asynchronus and parallel code execution. Async code can be suspend and resume.
// Swift has built in support for wrtting asynchronus and parallel code in structured way.

// Concurrency model is built on top threads, but don't interact with threadds directly.
// An async func in swift can give up the thread that its running on.
// On the thread another async function run until first async function blocked. And once first async function resumes back swift doesn't give guarantee about which thread that function will run on.

// Data race - it occures when multiple piedes of code tries to access some piece of shared mutable state in concurrent code execution.

// Swift detects and prevents data races, most data races produce at compile time
// We use actors and isolation to protect against data races.

// We use async keyword to make function or method asynchronus. async before throws
// When calling async method, execution suspend until that method returns. We write await keyword in front of suspention point statements.
// When we adding concurrent code to existing porject we need to take top down approach as in bottomup approach sync code can't ever call aysnc code.

func someAyncFunc() async throws -> [String] {
    try await Task.sleep(for: .seconds(2))
    return ["a", "b", "c"]
}

do {
    let result = try await someAyncFunc()
    print(result)
} catch {
    print("Error: \(error)")
}

// MARK: - Asynchronus Sequences
//
let handle = FileHandle.standardInput
for try await line in handle.bytes.lines {
    print(line)
}

struct CountDwon: Sequence, IteratorProtocol {
    var count: Int
    
    mutating func next() -> Int? {
        guard count > 0 else { return nil }
        defer { count -= 1 }
        return count
    }
}

struct AsyncCountDwon: AsyncSequence, AsyncIteratorProtocol {
    
    var count: Int
    
    func makeAsyncIterator() -> Self {
        self
    }
    
    mutating func next() async -> Int? {
        guard count > 0 else { return nil }
        defer { count -= 1 }
        return count
    }
}


let countDwon = CountDwon(count: 5)
for count in countDwon {
    print(count)
}

let asyncCount = AsyncCountDwon(count: 5)

for await count in asyncCount {
    print(count)
}

// MARK: - Calling async function parallel

func downlaodFunc(fileName: String, _ time: Int) async throws -> String {
    try await Task.sleep(for: .seconds(time))
    defer { print("\(fileName) Done => \(Date().formatted(date: .omitted, time: .standard))")}
    return "File Data  - \(fileName)"
}

func downloadAndPrint() async throws {
    let firstFile = try await downlaodFunc(fileName: "file1", 2)
    let secondFile = try await downlaodFunc(fileName: "file2", 3)
    let thirdFile = try await downlaodFunc(fileName: "file3", 1)
    
    [firstFile, secondFile, thirdFile].forEach { print($0) }
}

// When we want to run async functions in parallel then we write async in fron of let constant and await each time when we use the constant.

func downloadAndPrintInAsyncWay() async throws {
    async let firstFile =  downlaodFunc(fileName: "paralle file1", 2)
    async let secondFile = downlaodFunc(fileName: "paralle file2", 3)
    async let thirdFile =  downlaodFunc(fileName: "paralle file3", 1)
    async let fourthFile =  downlaodFunc(fileName: "paralle file4", 2)
    
    try await [firstFile, secondFile, thirdFile, fourthFile].forEach { print($0) }
}

print("\nSequential Download")
try? await downloadAndPrint()
print("\nParallel Download")
try? await downloadAndPrintInAsyncWay()


func downloadWithTaskGroup(files names: [String]) async throws -> [String] {
//    await withTaskGroup { group in
//        for name in names {
//            group.addTask {
//                return try? await downlaodFunc(fileName: name, Int.random(in: 1...5))
//            }
//        }
//        
//        for await fileData in group {
//            print(fileData ?? "NA")
//        }
//    }
    
   return try await withThrowingTaskGroup { group in
        
        for name in names {
//            group.addTask {
//                return try await downlaodFunc(fileName: name,
//                                              Int.random(in: 1...5))
//            }
            let added = group.addTaskUnlessCancelled {
                Task.isCancelled ? nil : try await downlaodFunc(fileName: name, Int.random(in: 1...5))
            }
            
            guard added else { break }
        }
        var result: [String] = []
        for try await fileData in group {
            print(fileData ?? "")
            result.append(fileData ?? "")
        }
        return result
    }
}

print("\nDownload with Task Group")
try? await downloadWithTaskGroup(files: ["file5", "file6", "file7", "file8", "file9"])


// MARK: - Task and Task Group

// Child Tasks - A child task is tied to its parent task. It inherits the parent’s priority and task-local values. It also gets cancelled if the parent is cancelled.

// Detached Tasks - A detached task doesn’t rely on any parent. It’s free-floating.
//



//: [Next](@next)
