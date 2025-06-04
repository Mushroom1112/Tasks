import UIKit

/*
 1) Create a generic class Stack that uses a type placeholder T.
 2) Implement the following methods:
 3) push(_ element: T): Adds an element to the stack.
 4) pop() -> T?: Removes and returns the top element of the stack, or returns nil if the stack is empty.
 5) size() -> Int: Returns the number of elements in the stack.
 6) Implement a function printStackContents -> String that prints the elements of the stack.
 */

class Stack<T> {
    var items: [T] = []
    
    func push(_ element: T) {
        items.append(element)
    }

    func pop() -> T? {
        if !items.isEmpty {
            return items.popLast()
        } else {
            return nil
        }
    }
    
    func size() -> Int {
        return items.count
    }
    
    func printStackContents() -> String {
        let joinedItems = items.map{ "\($0)" }.joined(separator: ", ")
        print(joinedItems)
        return joinedItems
    }
}
