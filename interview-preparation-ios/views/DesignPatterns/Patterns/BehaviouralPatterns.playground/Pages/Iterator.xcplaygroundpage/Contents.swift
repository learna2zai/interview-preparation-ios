//: [Previous](@previous)

import Foundation

// MARK: - Iterator Pattern

// its bdp that allows sequential traversal through complex data structure without exposing its internal details.


struct Student {
    let name: String
}

class Students {
    lazy var list: [Student] = []
    
    func append(_ student: Student) {
        list.append(student)
    }
}

extension Students: Sequence {
    func makeIterator() -> AnyIterator<Student> {
        var index = 0
        let students = self.list
        return AnyIterator {
            defer { index += 1 }
            return index < students.count ? students[index] : nil
        }
    }
}

//extension Students: Sequence {
//    func makeIterator() -> StudentIterator {
//        return StudentIterator(list)
//    }
//}

class StudentIterator: IteratorProtocol {
    typealias Element = Student
    var index = 0
    
    let students: [Student]
    
    init(_ students: [Student]) {
        self.students = students
    }

    func next() -> Student? {
        defer { index += 1 }
        return index < students.count ? students[index] : nil
    }
}

var students = Students()
students.append(Student(name: "A"))
students.append(Student(name: "B"))
students.append(Student(name: "C"))

for student in students {
    print(student.name)
}


//: [Next](@next)
