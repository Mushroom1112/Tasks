import UIKit

struct User {
    let username: String
    var email: String
    var password: String
}

class UserManager {
    var users: [String: User]
    
    var userCount: Int {
        self.users.count
    }
    
    init(users: [String : User] = [:]) {
        self.users = users
    }
    
    func registerUser(username: String, email: String, password: String) -> Bool {
        guard users[username] == nil else { return false }
        let newUser = User(username: username, email: email, password: password)
        users[username] = newUser
        return true
    }
    
    func logIn(username: String, password: String) -> Bool {
        guard users[username] != nil else { return false }
        let existingUser = users[username]
        
        if existingUser?.username == username && existingUser?.password == password {
            return true
        } else {
            return false
        }
    }
    
    func removeUser(username: String) -> Bool {
        if users[username] != nil {
            users.removeValue(forKey: username)
            return true
        } else {
            return false
        }
    }
}

class AdminUser: UserManager {
    
    deinit {
        print("AdminUser instance has been deinitialized.")
    }
    
    func listAllUsers() -> [String] {
        return Array(users.keys)
    }
}

