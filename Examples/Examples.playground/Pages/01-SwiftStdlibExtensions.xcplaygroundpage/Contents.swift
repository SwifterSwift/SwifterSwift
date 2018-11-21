//: [Table of Contents](00-ToC)

//: [Previous](@previous)

import SwifterSwift

//: ## SwiftStdlib extensions

//: ### Array extensions

// Remove duplicates from an array
var array = ["h", "e", "l", "l", "o"]
array.removeDuplicates()

//: ### Dictionary extensions

var dict: [String: Any] = ["id": 1, "Product-Name": "SwifterSwift"]

// Check if key exists in dictionary.
dict.has(key: "id")

// Lowercase all keys in dictionary.
dict.lowercaseAllKeys()

// Create JSON Data and string from a dictionary
let json = dict.jsonString(prettify: true)

//: ### Int extensions

// Return square root of a number
√9

// Return square power of a number
5 ** 2

// Return a number plus or minus another number
5 ± 2

// Return roman numeral for a number
134.romanNumeral

//: ### Random Access Collection extensions

// Return all indices of specified item
["h", "e", "l", "l", "o"].indices(of: "l")

//: ### String extensions

// Return count of substring in string
"hello world".count(of: "", caseSensitive: false)

// Return string with no spaces or new lines in beginning and end
"\n Hello   ".trimmed

// Return most common character in string
"swifterSwift is making swift more swifty".mostCommonCharacter()

// Returns CamelCase of string
"Some variable nAme".camelCased

// Check if string is in valid email format
"someone@somewebsite.com".isEmail

// Check if string contains at least one letter and one number
"123abc".isAlphaNumeric

// Reverse string
var str1 = "123abc"
str1.reverse()

// Return latinized string
var str2 = "Hèllö Wórld!"
str2.latinize()

// Create random string of length
String.random(ofLength: 10)

// Check if string contains one or more instance of substring
"Hello World!".contains("o", caseSensitive: false)

// Check if string contains one or more emojis
"string👨‍with😍emojis✊🏿".containEmoji

// Subscript strings easily
"Hello"[safe: 2]

// Slice strings
let str = "Hello world"
str.slicing(from: 6, length: 5)

// Convert string to numbers
"12.12".double

// Encode and decode URLs
"it's easy to encode strings".urlEncoded
"it's%20easy%20to%20encode%20strings".urlDecoded

// Encode and decode base64
"Hello World!".base64Encoded
"SGVsbG8gV29ybGQh".base64Decoded

// Truncate strings with a trailing
"This is a very long sentence".truncated(toLength: 14, trailing: "...")

// Repeat a string n times
"s" * 5

// NSString has never been easier
let boldString = "this is string".bold.colored(with: .red)

//: [Next](@next)
