![Alt text](https://github.com/omaralbeik/SwiftierSwift/blob/master/logo.png "Swiftier Swift")

[![MIT](https://img.shields.io/badge/License-MIT-red.svg)](https://opensource.org/licenses/MIT)
[![Swift](https://img.shields.io/badge/Swift-3.0-orange.svg)](https://swift.org)
[![Platform](https://img.shields.io/badge/Platform-iOS-lightgrey.svg)](https://github.com/omaralbeik/SwiftierSwift)
[![Xcode](https://img.shields.io/badge/Xcode-8.0%20beta6-blue.svg)](https://developer.apple.com/xcode)


A collection of priceless native swift 3 extensions to make working with your projects a real joy ;)


## How to use:

Copy Extensions folder to your Xcode project to use all extensions, or a specific extension


## Requirements:

Xcode 8 beta4 or later with Swift 3 is required to use these extensions


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


## Array extensions

|Name | Type | Return Type | Description |
|:--- | :--- | :---: | :--- |
|**randomItem** | Variable | Element | Return random item from array |
|**firstIndex(of item: Item)** | Function | Int? | Return first index of element in array |
|**lastIndex(of item: Item)** | Function | Int? | Return last index of element in array |
|**remove(object: Element)** | Function | -- | Remove element from array |
|**uniqueValues** | Variable | Array | Return unique values of array |
|**removeDuplicates()** | Function | -- | Remove duplicates from array |
|**shuffle()** | Function | -- | Shuffle array |
|**shuffled** | Variable | Array | Return shuffled version of array |
|**indexes(of item)** | Function | [Int] | Return all indexes of specified item |
|**prepend(item)** | Function | -- | Prepend an element to array |
|**sum** | Variable | Array | Sum of all elements in the array |
|**average** | Variable | Double | Average of all elements in array |

## Character extensions

|Name | Type | Return Type | Description |
|:--- | :--- | :---: | :--- |
|**locale** | Read-Only Variable | Locale | Return current locale |
|**isNumber** | Read-Only Variable | Bool | Return true if character is number |
|**toString** | Read-Only Variable | String | Return string from character |
|**toInt** | Read-Only Variable | Int? | Return integer from character (if applicable) |
|**isEmoji** | Read-Only Variable | Bool | Return true if character is an emoji |

## Convenience extensions

|Name | Type | Return Type | Description |
|:--- | :--- | :---: | :--- |
|**sharedApplication** | Read-Only Variable | UIApplication | Return shared instance of UIApplication |
|**delegate** | Read-Only Variable | AppDelegate | Return shared instance of AppDelegate |
|**appVersion** | Read-Only Variable | String? | Return app current version |
|**appBuild** | Read-Only Variable | String? | Return app current build number |
|**systemVersion** | Read-Only Variable | String? | Return system current version |
|**currentDevice** | Read-Only Variable | UIDevice | Return shared instance of current device |
|**deviceName** | Read-Only Variable | String | Return current device name |
|**deviceModel** | Read-Only Variable | String | Return current device model |
|**batteryLevel** | Read-Only Variable | Float | Return current battery level |
|**isMultitaskingSupported** | Read-Only Variable | Bool | Return true if multitasking is supported in current device |
|**deviceOrientation** | Read-Only Variable | UIDeviceOrientation | Return current orientation of device |
|**applicationIconBadgeNumber** | Variable | Int | Application icon badge number |
|**isNetworkActivityIndicatorVisible** | Variable | Bool | Network activity indicator visibility |
|**isStatusBarHidden** | Variable | Bool | Status bar visibility |
|**keyWindow** | Read-Only Variable | UIView? | Return key window |
|**mostTopViewController** | Variable | String? | Most top view controller |
|**isRegisteredForRemoteNotifications** | Read-Only Variable | Bool | Return true if device is registered for remote notifications for current app |
|**statusBarStyle** | Variable | UIStatusBarStyle? | Current status bar style |
|**userDefaults** | Read-Only Variable | UserDefaults | Return shared instance of standard UserDefaults |
|**set(value, forKey)** | Function | -- | Save an object to UserDefaults |
|**object(forKey)** | Function | AnyObject? | Get an object from UserDefaults |
|**isInDebuggingMode** | Read-Only Variable | Bool | Return true if app is running in debug mode |
|**isRunningOnSimulator** | Read-Only Variable | Bool | Return true if application is running on simulator |

|**deviceWidth** | Read-Only Variable | Bool | Return device width |
|**deviceHeight** | Read-Only Variable | Bool | Return device height |
|**isPhone** | Read-Only Variable | Bool | Return true if device is iPhone |
|**isPad** | Read-Only Variable | Bool | Return true if device is iPad |


## Date extensions

|Name | Type | Return Type | Description |
|:--- | :--- | :--- | :---: |
|**init(calendar, timeZone, era, year, month, day, hour, minute, second, nanosecond)** | Initializer | -- | Create a new Date |
|**calendar** | Read-Only Variable | Calendar | Return user’s current calendar |
|**timeZone** | Read-Only Variable | TimeZone | Returns time zone used by the system |
|**nanosecond** | Read-Only Variable | nanosecond | Nanoseconds from a date |
|**second** | Variable | Int | Seconds from a date |
|**minute** | Variable | Int | Minutes from a date |
|**hour** | Variable | Int | Hour from a date |
|**day** | Variable | Int | Day from a date |
|**weekday** | Read-Only Variable | Int | Weekday from a date |
|**weekOfMonth** | Read-Only Variable | Int | Week of month |
|**weekOfYear** | Read-Only Variable | Int | Week of year |
|**month** | Variable | Int | Month |
|**year** | Variable | Int | Year |
|**era** | Read-Only Variable | Int | Era |
|**quarter** | Read-Only Variable | Int | Quarter |
|**isInToday** | Read-Only Variable | Bool | Return true if date is in today |
|**add(component: Calendar.Component, value: Int)** | Function | -- | Add calendar components to date |
|**beginning(of component: Calendar.Component)** | Function | Date | Return beginning of given date component |
|**isInFuture** | Read-Only Variable | Bool | Return true if date is in future |
|**isInPast** | Read-Only Variable | Bool | Return true if date is in past |


## Double extensions

|Name | Type | Return Type | Description |
|:--- | :--- | :---: | :--- |
|**abs** | Read-Only Variable | Double | Return absolute value of double |
|**floor** | Read-Only Variable | Double | Return floor of double value |
|**ceil** | Read-Only Variable | Double | Return ceil of double value |
|**randomBetween(min, max)** | Static Variable | Double | Return random double value between two double values |


## Float extensions

|Name | Type | Return Type | Description |
|:--- | :--- | :---: | :--- |
|**abs** | Read-Only Variable | Float | Return absolute of float value |
|**floor** | Read-Only Variable | Float | Return floor of float value |
|**ceil** | Read-Only Variable | Float | Return ceil of float value |
|**randomBetween(min, max)** | Static Variable | Float | Return random float value between two float values |

## Int extensions

|Name | Type | Return Type | Description |
|:--- | :--- | :---: | :--- |
|**abs** | Read-Only Variable | Int | Return absolute of integer value |
|**isEven** | Read-Only Variable | Bool | Checks if integer value is even |
|**isOdd** | Read-Only Variable | Bool | Checks if integer value is odd |
|**digits** | Variable | [Int] | Return array of digits of integer value |
|**digitsCount** | Read-Only Variable | Int | Returns number of digits of integer value |
|**gcd(of n)** | Function | Int | Return greatest common divisor of integer value and n |
|**lcm(of n)** | Function | Int | Return least common multiple of integer value and n |
|**randomBetween(min, max)** | Static Function | Int | Return random integer value between two integer values |
|**romanNumeral** | Read-Only Variable | String? | Return roman numeral from an integer (I, II, IV, X,..) |

## String extensions

|Name | Type | Return Type | Description |
|:--- | :--- | :---: | :--- |
|**empty** | Variable | Bool | Return true if string is empty or contains only spaces or new lines |
|**isEmail** | Read-Only Variable | Bool | Return true if string is valid email format |
|**isHttpUrl** | Read-Only Variable | Bool | Return true if string is http URL |
|**isHttpsUrl** | Read-Only Variable | Bool | Return true is string is https URL |
|**firstCharacter** | Read-Only Variable | String? | Return first character of string |
|**lastCharacter** | Read-Only Variable | String? | Return last character of string |
|**start(with prefix: String, caseSensitive: Bool)** | Function | Bool | Return true if string starts with substring |
|**end(with suffix: String, caseSensitive: Bool)** | Function | Bool | Return true if string ends with substring |
|**count(of string: String, caseSensitive: Bool)** | Function | Int | Return count of substring in string |
|**contain(string: String)** | Function | Bool | Return true if string contains one or more instance of substring |
|**containEmoji** | Read-Only Variable | Bool | Return true if string contains one or more instance of substring |
|**split(by separator: Character)** | Function | [String] | Return an array of strings seperated by given string |
|**trimmed** | Read-Only Variable | String | Return string with no spaces or new lines in beginning and end |
|**trim()** | Function | -- | Removes spaces and new lines in beginning and end of string |
|**mostCommonCharacter** | Read-Only Variable | String | Return most common character in string |
|**camelize()** | Function | -- | Converts string format to CamelCase |
|**camelCaseString** | Read-Only Variable | String | Returns CamelCase of string |
|**lines()** | Function | [String] | SReturns array of strings seperated by new lines |
|**reverse()** | Function | -- | Reverse string |
|**reversed** | Read-Only Variable | String | Return reversed string |
|**firstIndex(of string: String)** | Variable | Int? | Return first index of substring in string |
|**replace(string: String, with: String)** | Function | String | Replace part of string with another string |
|**locale** | Read-Only Variable | Locale | Return current locale |
|**hasNumbers** | Read-Only Variable | Bool | Return true if string contains one or more numbers |
|**hasLetters** | Read-Only Variable | Bool | Return true if string contains one or more letters |
|**isAlphaNumeric** | Read-Only Variable | Bool | Return true if string contains at least one letter and one number |
|**isAlphabetic** | Read-Only Variable | Bool | Return true if string contains only letters |
|**isNumeric** | Read-Only Variable | Bool | Return true if string contains only numbers |
|**latinized** | Read-Only Variable | String | Return latinized string |
|**latinize()** | Function | -- | Latinize string |
|**toInt** | Read-Only Variable | Int? | Return Int value from string (if applicable) |
|**toInt8** | Read-Only Variable | Int8? | Return Int8 value from string (if applicable) |
|**toInt16** | Read-Only Variable | Int16? | Return Int16 value from string (if applicable) |
|**toInt32** | Read-Only Variable | Int32? | Return Int32 value from string (if applicable) |
|**toInt64** | Read-Only Variable | Int32? | Return Int64 value from string (if applicable) |
|**toFloat** | Read-Only Variable | Float? | Return Float value from string (if applicable) |
|**toFloat32** | Read-Only Variable | Float32? | Return Float32 value from string (if applicable) |
|**toFloat64** | Read-Only Variable | Float64? | Return Float64 value from string (if applicable) |
|**toFloat80** | Read-Only Variable | Float80? | Return Float80 value from string (if applicable) |
|**toDouble** | Read-Only Variable | Double? | Return Double value from string (if applicable) |
|**toBool** | Read-Only Variable | Bool? | Return Bool value from string (if applicable) |
|**random(of length: Int)** | Function | String | Return random string of given length |
|**urlEncode** | Read-Only Variable | String | Return url escaped string |
|**urlEncoded** | Function | -- | Escape a string |
|**urlDecode** | Read-Only Variable | String | Return readable string from url string |
|**urlDecoded** | Function | -- | Convert url string into readable string |



# UIColor extensions

|Name | Type | Return Type | Description |
|:--- | :--- | :---: | :--- |
|**init(red, green, blue)** | Initializer | -- | Create new UIColor from RGB values |
|**init(red, green, blue, transparency)** | Initializer | -- | Create new UIColor from RGB values with transparency |
|**init(netHex)** | Initializer | -- | Create new UIColor from hexadecimal value |
|**init(netHex, transparency)** | Initializer | -- | Create new UIColor from hexadicimal value with transparency |
|**hexString** | Read-Only Variable | String | Return hexadecimal value string |
|**random** | Static Read-Only Variable | UIColor | Return a random color |


# UIImage extensions

|Name | Type | Return Type | Description |
|:--- | :--- | :---: | :--- |
|**init(color, size)** | Initializer | -- | Create image of size from UIColor |


# UINavigationController extensions

|Name | Type | Return Type | Description |
|:--- | :--- | :---: | :--- |
|**popViewControllerWithHandler(completion)** | Functions | -- | Pop viewController with completion handler |
|**pushViewController(viewController, completion)** | Functions | -- | Push viewController with completion handler |


# UITextField extensions

|Name | Type | Return Type | Description |
|:--- | :--- | :---: | :--- |
|**isEmpty** | Read-Only Variable | Bool | Return true if text field is empty |


# UIView extensions

|Name | Type | Return Type | Description |
|:--- | :--- | :---: | :--- |
|**shake()** | Function | -- | Shake UIView |
|**cornerRadius** | Variable | CGFloat | Corner Radius; accessible from storyboard |
|**borderWidth** | Variable | CGFloat | Border Width; accessible from storyboard |
|**borderColor** | Variable | UIColor | Border Color; accessible from storyboard |
|**firstResponder** | Variable | UIView | Return current first responder in viewController |
