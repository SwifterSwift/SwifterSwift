![Alt text](https://github.com/omaralbeik/SwiftierSwift/blob/master/logo.png "Swiftier Swift")

[![MIT](https://img.shields.io/badge/License-MIT-red.svg)](https://opensource.org/licenses/MIT)
[![Swift](https://img.shields.io/badge/Swift-3.0-orange.svg)](https://swift.org)
[![Platform](https://img.shields.io/badge/Platform-iOS-lightgrey.svg)](https://github.com/omaralbeik/SwiftierSwift)
[![Xcode](https://img.shields.io/badge/Xcode-8.0%20beta6-blue.svg)](https://developer.apple.com/xcode)

A collection of priceless native swift 3 extensions to make working with your projects a real joy ;)


## How to use:

Copy Extensions folder to your Xcode project to use all extensions, or a specific extension


## Requirements:

Xcode 8 beta5 or later with Swift 3 is required to use these extensions

## How cool is this?

SwiftierSwift includes more than 150 property and method ..

### Array Extensions (19)
```swift
// Remove duplicates from array.
[1, 2, 3, 1, 3].removeDuplicates() = [1, 2, 3]

// Return all indexes of specified item.
["h", "e", "l", "l", "o"].indexes(of item: "l") = [2, 3]

// Return random item from array.
[1, 2, 3, 4, 5].randomItem = 3
```

### Date Extensions (24)
```swift
// Check if date is in today
Date().isInToday = true

// Add 1 month to current date
Date().add(component: .month, value: 1)

// Return beginning of current day
Date().beginning(of component: .day)

// Check if date is in current calendar unit
Date().isIn(current: .month) = true

// Return iso8601 string for date
Date().iso8601String = "2016-08-23T21:26:15.287Z"

// Create date from iso8601 string
let date = Date(iso8601String: "2016-08-23T21:26:15.287Z")
```

### Numbers Extensions (36)
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
```

### String Extensions (49)
```swift
// Return count of substring in string.
"hello world"count(of "o", caseSensitive: false) = 2

// Return string with no spaces or new lines in beginning and end
"\n Hello   ".trimmed = "Hello"

// Return most common character in string
"SwiftierSwift is making swift more swifty".mostCommonCharacter = "i"

// Returns CamelCase of string
"Some variable name".camelCased = "someVariableName"

// Check if string is in valid email format
"omaralbeik@gmail.com".isEmail = true

// Check if string contains at least one letter and one number
"123abc".isAlphaNumeric = true

// Return latinized string
"Hèllö Wórld!".latinized = "Hello World!"

// Return latinized string
let random = String.random(of length: 10) = "AhEju28kNl"

// Check if string contains one or more instance of substring
"Hello World!".contain(string: "o", caseSensitive: false) = true

// Check if string contains one or more emojis
"string👨‍with😍emojis✊🏿".containEmoji = true
```

### Dictionary Extensions
```swift
// Return JSON string from a dictionary
let jsonString = someDictionary.jsonString(prettify: true)

// Return JSON data from a dictionary
let jsonData = someDictionary.jsonData
```

### UIColor Extensions (35)
```swift
// Create new UIColor for RGB values
let color = UIColor(red: 121, green: 220, blue: 164)

// Create new UIColor for a hexadecimal value
let color = UIColor(netHex:0x45C91B)

// Return hexadecimal value string
UIColor.red.hexString = "#FF0000"

// Return brand colors from more than 30 social brands
let facebookColor = UIColor.socialColors.facebook
```

### Misc Extensions
```swift
// Check if app is running in debugging mode
SwiftierSwift.isInDebuggingMode

// Check if app is running on simulator
SwiftierSwift.isRunningOnSimulator
```

## List Of Extensions

- [x] [String extensions](#string-extensions)
- [x] [Date extensions](#date-extensions)
- [x] [Array extensions](#array-extensions)
- [x] [Double extensions](#double-extensions)
- [x] [Float extensions](#float-extensions)
- [x] [Int extensions](#int-extensions)
- [x] [Character extensions](#character-extensions)
- [ ] [Convenience extensions](#convenience-extensions)
- [ ] [UIColor extensions](#uicolor-extensions)
- [ ] [UIImage extensions](#uiimage-extensions)
- [ ] [UINavigationController extensions](#uinavigationcontroller-extensions)
- [ ] [UIView extensions](#uiview-extensions)
- [ ] [UITextField extensions](#uitextfield-extensions)


## Thanks:
Special thanks to [Eng. AbdulRahman Dabbour](https://github.com/thedabbour) for documenting the project
