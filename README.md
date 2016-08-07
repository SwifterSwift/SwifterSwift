# Swifier Swift
collection of priceless swift 3 extensions
![Alt text](https://github.com/omaralbeik/SwiftierSwift/blob/master/logo.png "Swiftier Swift")

## Table Of Contents
- [String extensions](#string-extensions)

-----

## String extensions
### locale: Locale
Return current locale

### count(of string: String) -> Int
Return count of substring in a string

### contain(string: String) -> Bool
Return true if String contains another substring

### start(with prefix: String) -> Bool
Return true is String starts with the given substring

### end(with suffix: String) -> Bool
Return true if String ends with the given substring

### isEmpty: Bool
Return true if string is empty or contains only spaces or new lines

### split(by separator: Character) -> [String]
Return an array of Strings by sipliting the given String into another strings

### trimmed: String
Return trimmed string (remove spaces and new lines from beginning and end of string)

### trim()
Trim a string (remove spaces and new lines from beginning and end of string)

### firstCharacter: String?
Return first character in a string

### lastCharacter: String?
Return last character in a string

### mostCommonCharacter: String
Return the most common character in a string

### camelCaseString: String
Return a camelcase string

### camelize()
Make string camelcased

### lines() -> [String]
Separtare new line delimated string into array of strings

### isEmail: Bool
Return true is string is a valid email format

### reversed: String
Return reversed string

### reverse()
Reverse string

### firstIndex(of string: String) -> Int?
Return the first index of a substring in a string

### replace(string: String, with: String) -> String
Replace part of string with another string

### hasNumbers: Bool
Return true is string contain one or more decimal number

### hasLetters: Bool
Return true is string contain one or more letter

### isAlphaNumeric: Bool
Return true is string contain one or more letters and one or more number, usually used to validate passwords

### isAlphabetic: Bool
Return true is string contain letters only

### isNumeric: Bool
Return true is string contain decimal numbers only

### latinized: String
Return latinized string, changes non latin letters with latin letters. eg: è becomes e

### latinize()
Latinize a string, changes non latin letters with latin letters. eg: è becomes e

### toInt: Int?
Return Int value from string (if possible)

### toInt8: Int8?
Return Int8 value from string (if possible)

### toInt16: Int16?
Return Int16 value from string (if possible)

### toInt32: Int32?
Return Int32 value from string (if possible)

### toInt64: Int64?
Return Int64 value from string (if possible)

### toInt: Int?
Return Int value from string (if possible)

### toFloat: Float?
Return Float value from string (if possible)

### toFloat32: Float32?
Return Float32 value from string (if possible)

### toFloat64: Float64?
Return Float64 value from string (if possible)

### toFloat80: Float80?
Return Float80 value from string (if possible)

### Double: Double?
Return Double value from string (if possible)

-----
