import UIKit

protocol Borrowable: AnyObject {
    var borrowDate: Date? { get set }
    var returnDate: Date? { get set }
    var isBorrowed: Bool { get set }
    func checkIn()
}

extension Borrowable {
    func isOverdue() -> Bool {
        guard let newDate = returnDate else { return false }
        guard Date() > newDate else { return false }
        return true
    }
    
     func checkIn() {
        borrowDate = nil
        returnDate = nil
        isBorrowed = false
    }
}

enum LibraryError: Error {
    case itemNotFound, itemNotBorrowable, alreadyBorrowed
}

class Item {
    let id: String
    let title: String
    let author: String
    
    init(id: String, title: String, author: String) {
        self.id = id
        self.title = title
        self.author = author
    }
}

class Book: Item, Borrowable {
    var borrowDate: Date?
    var returnDate: Date?
    var isBorrowed: Bool
    
    init(id: String, title: String, author: String, borrowDate: Date? = nil, returnDate: Date? = nil, isBorrowed: Bool = false) {
        self.borrowDate = borrowDate
        self.returnDate = returnDate
        self.isBorrowed = isBorrowed
        super.init(id: id, title: title, author: author)
    }
}

class Library {
    // used several items for testing purpose
    var items: [String : Item] = [
        "B001": Book(id: "B001", title: "1984", author: "George Orwell",),
        "B002": Book(id: "B002", title: "To Kill a Mockingbird", author: "Harper Lee"),
        "B003": Book(id: "B003", title: "The Great Gatsby", author: "F. Scott Fitzgerald")
    ]

    func addBook(_ book: Book) {
        items[book.id] = book
    }
    
   func borrowItem(by id: String) throws -> Item {
       guard let item = items[id] else { throw LibraryError.itemNotFound }
       guard let borrowableItem = item as? Borrowable else { throw LibraryError.itemNotBorrowable }
       guard !borrowableItem.isBorrowed else { throw LibraryError.alreadyBorrowed }
       
       borrowableItem.borrowDate = Date()
       borrowableItem.returnDate = Calendar.current.date(byAdding: .day, value: 14, to: Date())
       borrowableItem.isBorrowed = true
       return item
    }
}

// MARK: Uncomment to Test Code
/*
let myLibrary = Library()

myLibrary.addBook(Book(id: "0019", title: "Mass", author: "Komvle"))

do {
   try myLibrary.borrowItem(by: "B002")
   var book = myLibrary.items["B001"] as? Book
    
} catch let error as LibraryError {
    switch error {
    case .itemNotFound:
        print("Error: Item not found.")
    case .itemNotBorrowable:
        print("Error: Item is not borrowable.")
    case .alreadyBorrowed:
        print("Error: Item is already borrowed.")
    }
} catch {
    print("An unknown error occurred: \(error)")
}
*/
