import UIKit

func isPalindrome(_ input: String) -> Bool {
    let filtered = input.filter{ $0.isLetter || $0.isNumber }.lowercased()
    guard filtered.count > 1 else { return false }
    
    var left = filtered.startIndex
    var right = filtered.index(before: filtered.endIndex)
    
    while left < right {
        if filtered[left] != filtered[right] {
            return false
        } else {
            left = filtered.index(after: left)
            right = filtered.index(before: right)
            print(filtered[left], filtered[right])
        }
    }
    return true
}

