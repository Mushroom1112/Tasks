import UIKit
/*
 Design a simple University Student Management System to practice and test all types of initializers in Swift. This task will focus on:
  Designated Initializers, Convenience Initializers, Failable Initializers, Required Initializers, Memberwise Initializers (for structs), Inheritance and initializer chaining
 What should be done
 Steps to Implement:
 1. Create a Person base class with the following:
 • Properties: name (String), age (Int)
 • A designated initializer
 • A failable initializer (fails if age is less than 16)

 2. Create a Student subclass that inherits from Person with additional properties:
 • studentID (String)
 • major (String)
 • A required initializer
 • A convenience initializer

 3. Create a Professor subclass with additional properties:
 • faculty (String)
 • A custom initializer calling the superclass
 4. Create a University struct with properties:
 
 • name (String), location (String)
 • A memberwise initializer (default in Swift for structs)
 */

class Person {
    let name: String
    var age: Int
    
    init(name: String, age: Int) {
        self.name = name
        self.age = age
    }
    
    init?(validated name: String, age: Int) {
        if age < 16 {
            return nil
        }
        self.name = name
        self.age = age
    }
}

class Student: Person {
    let studentId: String
    var major: String
    
    required init(name: String, age: Int, studentId: String, major: String) {
        self.studentId = studentId
        self.major = major
        super.init(name: name, age: age)
    }
        
    convenience init(name: String, age: Int, studentId: String) {
        self.init(name: name, age: age, studentId: studentId, major: "[Unknown]")
    }
}

class Professor: Person {
    var faculty: String
    var description: String
    
    init(name: String, age: Int, faculty: String, description: String) {
        self.faculty = faculty
        self.description = "Professor \(name) is teaching on \(faculty) faculty."
        super.init(name: name, age: age)
    }
}

struct University {
    let name: String
    var location: String
    
    // Memberwise nitializer
    init(name: String, location: String) {
        self.name = name
        self.location = location
    }
}
