import UIKit
/*
 Define a struct called School that will house the primary functional elements of the school system.
 Inside the School struct, create a nested enum named SchoolRole with these cases: student, teacher, administrator.
 Define a nested class within the School struct called Person, which will have the following properties:

 name: A string indicating the person's name.
 role: A SchoolRole indicating the person's role in the school.

 Implement a subscript in the School struct to retrieve arrays of Person objects based on their SchoolRole. This will allow efficient access to categorized groups, such as all students or all teachers.
 Define new method in School addPerson(_ :)that will update its people list.
 Create three functions: countStudents, countTeachers, and countAdministrators. Each of these functions will:

 Take an instance of School as a parameter.
 Use the previously implemented subscript to access the list of Person instances by role.
 Return the count (type Int) of individuals for each respective role (students, teachers, administrators).
 */

struct School {
    enum SchoolRole {
        case student, teacher, administrator
    }
    
    class Person {
        let name: String
        var role: SchoolRole
        
        init(name: String, role: SchoolRole) {
            self.name = name
            self.role = role
        }
    }
    
    var people: [Person] = []
    
    subscript(role: SchoolRole) -> [Person] {
        people.filter{$0.role == role }
    }
    
    mutating func addPerson(_ person: Person) {
        people.append(person)
    }
}

func countStudents(in school: School) -> Int { school[.student].count }
func countTeachers(in school: School) -> Int { school[.teacher].count }
func countAdministrators(in school: School) -> Int { school[.administrator].count }
