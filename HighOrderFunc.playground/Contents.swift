import UIKit
/*
 1. Assume you have an array of dictionaries. Each dictionary contains details about books (title, author, year, price, and genre).
 2. Define new global variable of type Array<Double> named`discountedPrices` that will include just the prices of the above books with a 10% discount applied. Use `map`/`compactMap` to solve this.
 3. Define new global variable of type Array<String> named `booksPostedAfter2000` that will include book titles of the books published after the year 2000. Use `filter` to solve this.
 4. Define new global variable of type Set<String> named `allGenres` that will include all the genres available in the books. Use `flatMap` to solve this.
 5. Define new global variable of type Int named `totalCost` to find out how much it would cost to purchase one instance of each book. Use `reduce`.

 */

let books = [
["title": "Swift Fundamentals", "author": "John Doe", "year": 2015, "price": 40, "genre": ["Programming", "Education"]],
["title": "The Great Gatsby", "author": "F. Scott Fitzgerald", "year": 1925, "price": 15, "genre": ["Classic", "Drama"]],
["title": "Game of Thrones", "author": "George R. R. Martin", "year": 1996, "price": 30, "genre": ["Fantasy", "Epic"]],
["title": "Big Data, Big Dupe", "author": "Stephen Few", "year": 2018, "price": 25, "genre": ["Technology", "Non-Fiction"]],
["title": "To Kill a Mockingbird", "author": "Harper Lee", "year": 1960, "price": 20, "genre": ["Classic", "Drama"]]
]

let discountedPrices: [Double] = books.compactMap { book in
    if let price = book["price"] as? Double {
        return price * 0.9
    } else if let price = book["price"] as? Int {
        return Double(price) * 0.9
    } else {
        return nil
    }
}
let booksAfter2000 = books
    .filter { ($0["year"] as? Int ?? 0) > 2000 }
    .compactMap { $0["title"] as? String }

let allGenres: Set<String> = Set(
books.flatMap { $0["genre"] as? [String] ?? [] }
)

let totalCost: Int = books.reduce(0) { total, book in
    total + (book["price"] as? Int ?? 0)
}
