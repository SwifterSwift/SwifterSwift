# Swifier Swift

A collection of priceless native swift 3 extensions to make working with your projects a real joy ;)
![Alt text](https://github.com/omaralbeik/SwiftierSwift/blob/master/logo.png "Swiftier Swift")

[![Swift](https://img.shields.io/badge/SWIFT-3-orange.svg)](https://swift.org)
[![Platform](https://img.shields.io/badge/Platform-iOS%20%7C%20macOS%20%7C%20tvOS%20%7C%20watchOS-lightgrey.svg)]()


## List Of Extensions

- [ ] [String extensions](#string-extensions)
- [ ] [Date extensions](#date-extensions)
- [ ] [Array extensions](#array-extensions)
- [ ] [Double extensions](#double-extensions)
- [ ] [Int extensions](#int-extensions)
- [ ] [UIColor extensions](#uicolor-extensions)
- [ ] [UIImage extensions](#uiimage-extensions)
- [ ] [UINavigationController extensions](#uinavigationcontroller-extensions)
- [ ] [UIView extensions](#uiview-extensions)
- [ ] [UITextField extensions](#uitextfield-extensions)


## String extensions

|Name | Type | Return Type | Description |
|:--- | :--- | :--- | :--- |
|**isEmpty** | Variable | Bool | Return true if string is empty or contains only spaces or new lines |
|**isEmail** | Variable | Bool | Return true is string is a valid email format |
|**firstCharacter** | Variable | String? | Return first character in a string |
|**lastCharacter** | Variable | String? | Return last character in a string |
|**start(with prefix: String)** | Function | Bool | Return true if String starts with the given substring |
|**end(with suffix: String)** | Function | Bool | Return true if String ends with the given substring |
|**count(of string: String)** | Function | Int | Return count of substring in a string |
|**contain(string: String)** | Function | Bool | Return true if String contains another substring |
|**split(by separator: Character)** | Function | [String] | Return an array of Strings by splitting the given String into another strings |
|**trimmed** | Variable | String | Return trimmed string (remove spaces and new lines from beginning and end of string) |
|**trim()** | Function | -- | Trim a string (remove spaces and new lines from beginning and end of string) |
|**mostCommonCharacter** | Variable | String | Return the most common character in a string |
|**camelize()** | Function | -- | Make string camelcased |
|**camelCaseString** | Variable | String | Return a camelcase string |
|**lines()** | Function | [String] | Separate new line delimited string into array of strings |
|**reverse()** | Function | -- | Reverse string |
|**reversed** | Variable | String | Return reversed string |
|**firstIndex(of string: String)** | Variable | Int? | Return the first index of a substring in a string |
|**replace(string: String, with: String)** | Function | String | Replace part of string with another string |
|**locale** | Variable | Locale | Return current locale |
|**hasNumbers** | Variable | Bool | Return true is string contain one or more decimal number |
|**hasLetters** | Variable | Bool | Return true is string contain one or more letter |
|**isAlphaNumeric** | Variable | Bool | Return true is string contain one or more letters and one or more number, usually used to validate passwords |
|**isAlphabetic** | Variable | Bool | Return true is string contain letters only |
|**isNumeric** | Variable | Bool | Return true is string contain decimal numbers only |
|**latinized** | Variable | String | Return latinized string, changes non latin letters with latin letters. eg: è becomes e |
|**latinize()** | Function | -- | Latinize a string, changes non latin letters with latin letters. eg: è becomes e |
|**toInt** | Variable | Int? | Return Int value from string (if possible) |
|**toInt8** | Variable | Int8? | Return Int8 value from string (if possible) |
|**toInt16** | Variable | Int16? | Return Int16 value from string (if possible) |
|**toInt32** | Variable | Int32? | Return Int32 value from string (if possible) |
|**toInt64** | Variable | Int32? | Return Int64 value from string (if possible) |
|**toFloat** | Variable | Float? | Return Float value from string (if possible) |
|**toFloat32** | Variable | Float32? | Return Float32 value from string (if possible) |
|**toFloat64** | Variable | Float64? | Return Float64 value from string (if possible) |
|**toFloat80** | Variable | Float80? | Return Float80 value from string (if possible) |
|**toDouble** | Variable | Double? | Return Double value from string (if possible) |
|**toBool** | Variable | Bool? | Return Bool value from string (if possible) |


## Date extensions

|Name | Type | Return Type | Description |
|:--- | :--- | :--- | :--- |
|**init(calendar, timeZone, era, year, month, day, hour, minute, second, nanosecond)** | Initializer | -- | Create a new Date from Date components values |
|**calendar** | Variable | Calendar | Returns the user’s current calendar |
|**timeZone** | Variable | TimeZone | Returns the time zone currently used by the system|
|**nanosecond** | Variable | nanosecond | Nanoseconds from a date (read only) |
|**second** | Variable | Int | Seconds from a date |
|**minute** | Variable | Int | Minutes from a date |
|**hour** | Variable | Int | Hour from a date |
|**day** | Variable | Int | Day from a date |
|**weekday** | Variable | Int | Weekday from a date (read only) |
|**weekOfMonth** | Variable | Int | WeekOfMonth from a date (read only) |
|**weekOfYear** | Variable | Int | WeekOfYear from a date (read only) |
|**month** | Variable | Int | Month from a date |
|**year** | Variable | Int | Year from a date |
|**era** | Variable | Int | Era from a date (read only) |
|**quarter** | Variable | Int | Quarter from a date (read only) |
|**isInToday** | Variable | Bool | Return true if date is in today (read only) |
|**add(component: Calendar.Component, value: Int)** | Function | -- | Add calendar components to date |
|**beginning(of component: Calendar.Component)** | Function | Date | Return beginning of given date component |


## Array extensions

|Name | Type | Return Type | Description |
|:--- | :--- | :--- | :--- |
|**randomItem** | Variable | Element | Return a random item from an array |
|**firstIndex(of item: Item)** | Function | Int? | Return the first index of an element in an array |
|**lastIndex(of item: Item)** | Function | Int? | Return the last index of an element in an array |
|**remove(object: Element)** | Function | -- | Remove an element from an array |
|**uniqueValues** | Variable | Array | Return the unique values from an array |
|**removeDuplicates()** | Function | -- | Remove duplicates from an array |
|**shuffle()** | Function | Array | Shuffle the array |
|**shuffled** | Variable | Array | Return a shuffled array |
|**indexes(of item)** | Function | [Int] | Return all indexes of a given item |


## Double extensions

|Name | Type | Return Type | Description |
|:--- | :--- | :--- | :--- |
|**abs** | Variable | Double | Return absolute value of double |
|**floor** | Variable | Double | Return the largest integer <= self. |
|**ceil** | Variable | Double | Rounds self to the smallest integer >= self. |


## Int extensions

|Name | Type | Return Type | Description |
|:--- | :--- | :--- | :--- |
|**abs** | Variable | Int | Return absolute value of double |
|**isEven** | Variable | Bool | Return true if Int is even |
|**isOdd** | Variable | Bool | Return true if Int is odd |
|**digits** | Variable | [Int] | Return an array of all digits in an Integer |
|**digitsCount** | Variable | Int | Return digits count for an Integer |
|**factorial** | Variable | Int? | Return factorial for an integer (if possible) |


# UIColor extensions

|Name | Type | Return Type | Description |
|:--- | :--- | :--- | :--- |
|**init(red, green, blue)** | Initializer | -- | Create new UIColor for RGB values |
|**init(red, green, blue, transparency)** | Initializer | -- | Create new UIColor for RGB values with transparency |
|**init(netHex)** | Initializer | -- | Create new UIColor for a hexadecimal |
|**init(netHex, transparency)** | Initializer | -- | Create new UIColor for a hexadecimal value with transparency |
|**hexString** | Variable | String | Return hexadecimal value string |
|**random** | Static Variable | UIColor | Return a random color (read only) |


# UIImage extensions

|Name | Type | Return Type | Description |
|:--- | :--- | :--- | :--- |
|**init(color, size)** | Initializer | -- | Create new Image from color and size |


# UINavigationController extensions

|Name | Type | Return Type | Description |
|:--- | :--- | :--- | :--- |
|**popViewControllerWithHandler(completion)** | Functions | -- | popViewController with a completion handler |
|**pushViewController(viewController, completion)** | Functions | -- | pushViewController with a completion handler |

# UIView extensions

|Name | Type | Return Type | Description |
|:--- | :--- | :--- | :--- |
|**shake()** | Function | -- | Shake view |
|**cornerRadius** | Variable | CGFloat | get and set cornerRadius for a view from code or storyboard |
|**borderWidth** | Variable | CGFloat | get and set borderWidth for a view from code or storyboard |
|**borderColor** | Variable | UIColor | get and set borderColor for a view from code or storyboard |

# UITextField extensions

|Name | Type | Return Type | Description |
|:--- | :--- | :--- | :--- |
|**isEmpty** | Variable | Bool | Return true if text field is empty (read only) |
