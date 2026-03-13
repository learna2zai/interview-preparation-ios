//: [Previous](@previous)

import Foundation
import SwiftUI
import PlaygroundSupport

var greeting = "Hello, playground"

let values: Result<Int, Never> = .success(32)

switch values {
    case .success(let value):
        print("Success: \(value)")
    case .failure:
        print("Failure")
}

func calculateSum(_ numbers: Double...) -> Never {

    while true {
        print("Hello")
    }
    
//    return 1.0 + 2.0
}

//calculateSum(1.0, 2.0)

struct SampleA {
    
    class SampleB {
        var name: String
        init(name: String) {
            self.name = name
        }
        
        func showName() {
            print(name)
        }
    }
}


let classInstance = SampleA.SampleB(name: "Test")

extension SampleA.SampleB {
    var age: Int {
       45
    }
    
    class func showClassName() {
        print("SampleB")
    }
}

enum ValidCases {
    case a, b
}

let validCase: ValidCases
validCase = .a

// MARK: - Required initializer as protocol requirements

protocol TestProtocol {
    init(value: Int)
}

struct TestStruct: TestProtocol {
    var value: Int
}

final class TestClass: TestProtocol {
    var value: Int
    init(value: Int) {
        self.value = value
    }
}

// MARK: - Property wrappers

@propertyWrapper
struct Trimmer: DynamicProperty {
    @State private var text: String
    
    var wrappedValue: String {
        get { text }
        set {
            text = newValue.replacingOccurrences(of: "  ", with: "", options: .regularExpression)
        }
    }
    
    var projectedValue: Binding<String> {
        Binding(
            get: { text },
            set: {
                self.text = $0.replacingOccurrences(of: "  ", with: "", options: .regularExpression)
        })
    }
    
    init(wrappedValue value: String) {
        _text = State(initialValue: value.replacingOccurrences(of: "  ", with: "", options: .regularExpression))
    }
}


struct PostView: View {
    @Trimmer private var descripion = "3254 v 324 k       Swift 32r 23 32 23rintroduced property wrappers so you can write 2 3r23 23rthat logic   once and reuse it.       "
    
    var body: some View {
        VStack {
            Text("Post Title")
                .font(.headline)
            Text(descripion).font(.body)
            TextField("Enter Description", text: Binding(projectedValue: $descripion))
            
        }
        .task {
            //
        }
        .onAppear(perform: {
            
        })
        .padding()
    }
}

var postView = PostView()
PlaygroundPage.current.setLiveView(postView)



// MARK: - Dynamic Member Lookup

@dynamicMemberLookup
struct KnowledgeBase {
    private var data: [String: String]
    
    init(data: [String : String]) {
        self.data = data
    }
    
    subscript(dynamicMember key: String) -> String {
        return data[key] ?? "No information available for that key."
    }
}

let knowledgeBase = KnowledgeBase(data: [
    "swift": "Swift is a general-purpose programming language developed by Apple.",
    "ios": "iOS is an operating system developed by Apple for use on Apple's smartphones and tablet computers.",
    "macOS": "macOS is the operating system for Apple's personal computers, including the iMac, Mac Pro, and Apple Watch."
])

print(knowledgeBase.swift)




//: [Next](@next)
