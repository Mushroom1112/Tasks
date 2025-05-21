/*
 Write a function isBalancedParentheses(input: String) -> Bool
 that returns true if the parentheses in a string are balanced, and false otherwise.
 
 public func isBalancedParentheses(input: String) -> Bool {
 // Add you implmentation here
 return false
 }
 
 - Only parentheses () are considered; other brackets or characters should be ignored.
 - The input string might contain multiple lines.
 - For example, "(())" is balanced, but "(()" is not.
 */

import UIKit

public func isBalancedParentheses(_ input: String) -> Bool {
    let filtered = input.filter{$0 == "(" || $0 == ")" }
    var balance = 0
    
    for character in filtered {
        if character == "(" {
            balance += 1
        } else if character == ")" {
            balance -= 1
        }
        if balance < 0 {
            return false
        }
    }
    return balance == 0
}
