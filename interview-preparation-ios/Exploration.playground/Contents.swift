import UIKit
var greeting = "Hello, playground"

func removeExtraSpaces(from string: String) -> String {
    var chars = string.split(separator: "")
    var stack: [Int] = []
    
    for (index, char) in chars.enumerated() {  // O(n)
        if char == "(" {
            stack.append(index)
        } else if char == ")" {
            if stack.count > 0 {
                stack.removeLast()
            } else {
                chars[index] = ""
            }
        }
    }
    
    while(stack.count > 0) { // O(n)
        chars[stack.removeLast()] = ""
    }
    
    return chars.joined(separator: "")
}


print(removeExtraSpaces(from: "()(((()))()(()"))
