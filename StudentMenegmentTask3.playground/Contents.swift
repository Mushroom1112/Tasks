import UIKit

class Person {
    let name: String
    var age: Int
    var isAdult: Bool {
        age >= 18
    }
    static let minAgeForEnrollment = 16
    lazy var profileDescription: String = {
        "\(name) is \(age) years old."
    }()
    
    init(name: String, age: Int) {
        self.name = name
        self.age = age
    }

    init?(validated name: String, age: Int) {
        if age < Person.minAgeForEnrollment { return nil }
        self.name = name
        self.age = age
    }
}

class Student: Person {
    let studentId: String
    var major: String
    nonisolated(unsafe) static var studentCount: Int = 0
    weak var advisor: Professor?
    var formattedID: String {
        return "ID: \(studentId.uppercased())"
    }
    
    required init(name: String, age: Int, studentId: String, major: String) {
        self.studentId = studentId
        self.major = major
        super.init(name: name, age: age)
        Student.studentCount += 1
    }
        
    convenience init(name: String, age: Int, studentId: String) {
        self.init(name: name, age: age, studentId: studentId, major: "[Unknown]")
    }
    
    deinit {
        Student.studentCount -= 1
    }
}

class Professor: Person {
    var faculty: String
    var fullTitle: String {
        "Professor \(name), \(faculty) faculty"
    }
    
    nonisolated(unsafe) static var professorCount = 0
    
    init(name: String, age: Int, faculty: String) {
        self.faculty = faculty
        super.init(name: name, age: age)
        Professor.professorCount += 1
    }
    
    deinit {
        Professor.professorCount -= 1
    }
}

struct University {
    let name: String
    var location: String
    var description: String {
        return "\(name) University located in \(location)"
    }
    
    // Memberwise nitializer
    init(name: String, location: String) {
        self.name = name
        self.location = location
    }
}



