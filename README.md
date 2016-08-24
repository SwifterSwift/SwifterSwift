<p align="left">
  <img src="https://github.com/omaralbeik/swifterSwift/blob/master/logo.png" title="swifter Swift">
</p>

[![MIT](https://img.shields.io/badge/License-MIT-red.svg)](https://opensource.org/licenses/MIT)
[![Swift](https://img.shields.io/badge/Swift-3.0-orange.svg)](https://swift.org)
[![Platform](https://img.shields.io/badge/Platform-iOS-lightgrey.svg)](https://github.com/omaralbeik/swifterSwift)
[![Xcode](https://img.shields.io/badge/Xcode-8.0%20beta6-blue.svg)](https://developer.apple.com/xcode)

A handy collection of native Swift 3 extensions to boost your productivity.


## How to use:

Copy to the extensions folder of your Xcode project to use all extensions, or a specific extension.


## Requirements:

Xcode 8 beta5 or later with Swift 3.


## [List Of Extensions](Documentation/ExtensionsTable.md)

- [x] [Array extensions](Documentation/ExtensionsTable.md#array-extensions)
- [x] [Character extensions](Documentation/ExtensionsTable.md#character-extensions)
- [ ] [Convenience extensions](Documentation/ExtensionsTable.md#convenience-extensions)
- [x] [Date extensions](Documentation/ExtensionsTable.md#date-extensions)
- [x] [Double extensions](Documentation/ExtensionsTable.md#double-extensions)
- [x] [Float extensions](Documentation/ExtensionsTable.md#float-extensions)
- [x] [Int extensions](Documentation/ExtensionsTable.md#int-extensions)
- [x] [String extensions](Documentation/ExtensionsTable.md#string-extensions)
- [ ] [CGFloat extensions](Documentation/ExtensionsTable.md#cgfloat-extensions)
- [ ] [CGSize extensions](Documentation/ExtensionsTable.md#cgsize-extensions)
- [ ] [UIAlertController extensions](Documentation/ExtensionsTable.md#uialertcontroller-extensions)
- [ ] [UIButton extensions](Documentation/ExtensionsTable.md#uibutton-extensions)
- [ ] [UIColor extensions](Documentation/ExtensionsTable.md#uicolor-extensions)
- [ ] [UIImage extensions](Documentation/ExtensionsTable.md#uiimage-extensions)
- [ ] [UINavigationBar extensions](Documentation/ExtensionsTable.md#uinavigationbar-extensions)
- [ ] [UINavigationController extensions](Documentation/ExtensionsTable.md#uinavigationcontroller-extensions)
- [ ] [UISearchBar extensions](Documentation/ExtensionsTable.md#uisearchbar-extensions)
- [ ] [UITableView extensions](Documentation/ExtensionsTable.md#uitableview-extensions)
- [ ] [UITextField extensions](Documentation/ExtensionsTable.md#uitextfield-extensions)
- [ ] [UIView extensions](Documentation/ExtensionsTable.md#uiview-extensions)
- [ ] [UIViewController extensions](Documentation/ExtensionsTable.md#uiviewcontroller-extensions)


## How cool is this?

Swifter Swift is a library of over 150 properties and methods, designed to extend Swift's functionality and productivity, staying faithful to the original design manual.
Here are some examples:

#### Array Extensions (14)
```swift
// Remove duplicates from array
[1, 2, 3, 1, 3].removeDuplicates() -> [1, 2, 3]

// Return all indexes of specified item
["h", "e", "l", "l", "o"].indexes(of item: "l") -> [2, 3]

// Return random item from array
[1, 2, 3, 4, 5].randomItem -> 3

// and many others!
```


#### Date Extensions (23)
```swift
// Get and set components from date with ease
date.hour = 14

// Check if date is in today
Date().isInToday -> true

// Add 1 month to current date
Date().add(component: .month, value: 1)

// Return beginning of current day
Date().beginning(of component: .day)

// Check if date is in current calendar unit
Date().isIn(current: .month) -> true

// Return iso8601 string for date
Date().iso8601String -> "2016-08-23T21:26:15.287Z"

// Create date from iso8601 string
let date = Date(iso8601String: "2016-08-23T21:26:15.287Z")

// and many others!
```


#### String Extensions (48)
```swift
// Return count of substring in string
"hello world".count(of "o", caseSensitive: false) -> 2

// Return an array of strings separated by given string
"hello world".split(by separator: " ") -> ["hello", "world"]

// Return string with no spaces or new lines in beginning and end
"\n Hello   ".trimmed -> "Hello"

// Return most common character in string
"swifterSwift is making swift more swifty".mostCommonCharacter -> "i"

// Returns CamelCase of string
"Some variable name".camelCased -> "someVariableName"

// Check if string is in valid email format
"omaralbeik@gmail.com".isEmail -> true

// Check if string contains at least one letter and one number
"123abc".isAlphaNumeric -> true

// Reverse string
"123abc".reverse() -> "cba321"

// Return latinized string
"Hèllö Wórld!".latinize() -> "Hello World!"

// Return latinized string
String.random(of length: 10) -> "AhEju28kNl"

// Check if string contains one or more instance of substring
"Hello World!".contain(string: "o", caseSensitive: false) -> true

// Check if string contains one or more emojis
"string👨‍with😍emojis✊🏿".containEmoji -> true

// Convert string to numbers
"12.12".toDouble -> 12.12

// Encode string into url
"it's easy to encode strings".urlEncoded() -> "it's%20easy%20to%20encode%20strings"

// Decode url
"it's%20easy%20to%20encode%20strings".urlDecoded() -> "it's easy to encode strings"

// Repeat a string n times
"s" * 5 -> "sssss"
// and many others!
```


#### UIColor Extensions (7)
```swift
// Create new UIColor for RGB values
let color = UIColor(red: 121, green: 220, blue: 164)

// Create new UIColor for a hexadecimal value
let color = UIColor(netHex:0x45C91B)

// Return hexadecimal value string
UIColor.red.hexString -> "#FF0000"

// Return brand colors from more than 30 social brands
let facebookColor = UIColor.socialColors.facebook

// and many others!
```


#### Number Extensions (33)
```swift
// Return square root of a number
√ 9 = 3

// Return square power of a number
5 ^ 2 = 25

// Return a number plus or minus another number
5 ± 2 = (3, 7)

// Return random number in range
Int.randomBetween(min: 1, max: 10) = 6

// Return roman numeral for a number
134.romanNumeral = "CXXXIV"

// and many others!
```


#### Misc Extensions
```swift
// Return JSON string from a dictionary
let jsonString = someDictionary.jsonString(prettify: true)

// Return JSON data from a dictionary
let jsonData = someDictionary.jsonData

// Check if app is running in debugging mode
swifterSwift.isInDebuggingMode

// Check if app is running on simulator
swifterSwift.isRunningOnSimulator

// and many others!
```


## Thanks:
Special thanks to [Eng. Abdul Rahman Dabbour](https://github.com/thedabbour) for documenting the project
