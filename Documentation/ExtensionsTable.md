## List Of All Extensions

- [ ] [Array extensions](#array-extensions)
- [ ] [Character extensions](#character-extensions)
- [ ] [Convenience extensions](#convenience-extensions)
- [ ] [Date extensions](#date-extensions)
- [ ] [Double extensions](#double-extensions)
- [ ] [Float extensions](#float-extensions)
- [ ] [Int extensions](#int-extensions)
- [ ] [String extensions](#string-extensions)
- [ ] [CGFloat extensions](#cgfloat-extensions)
- [ ] [CGSize extensions](#cgsize-extensions)
- [ ] [UIAlertController extensions](#uialertcontroller-extensions)
- [ ] [UIButton extensions](#uibutton-extensions)
- [ ] [UIColor extensions](#uicolor-extensions)
- [ ] [UIImage extensions](#uiimage-extensions)
- [ ] [UINavigationBar extensions](#uinavigationbar-extensions)
- [ ] [UINavigationController extensions](#uinavigationcontroller-extensions)
- [ ] [UISearchBar extensions](#uisearchbar-extensions)
- [ ] [UITableView extensions](#uitableview-extensions)
- [ ] [UITextField extensions](#uitextfield-extensions)
- [ ] [UIView extensions](#uiview-extensions)
- [ ] [UIViewController extensions](#uiviewcontroller-extensions)


## Array extensions

|Name | Type | Return Type | Description |
|:--- | :--- | :---: | :--- |
|**average** | Variable | Double | Average of all elements in array |
|**difference(Array)** | Function | -- | Return an array of all items that are in self and not in given array |
|**firstIndex(of Item)** | Function | Int? | Return first index of element in array |
|**indexes(of Item)** | Function | [Int] | Return all indexes of specified item |
|**lastIndex(of Item)** | Function | Int? | Return last index of element in array |
|**pop** | Mutating function | Element? | Remove last item from array and return it |
|**prepend(Item)** | Mutating function | -- | Prepend an element to array |
|**push(Item)** | Mutating function | -- | Append an item to array |
|**randomItem** | Variable | Element | Return random item from array |
|**removeAll(Item)** | Mutating function | -- | Remove all instances of an item from array |
|**removeDuplicates()** | Mutating function | -- | Remove duplicates from array |
|**shuffle()** | Mutating function | -- | Shuffle array |
|**shuffled** | Variable | Array | Return shuffled version of array |
|**sum** | Variable | Array | Sum of all elements in the array |
|**uniqueValues** | Variable | Array | Return unique values of array |


## Character extensions

|Name | Type | Return Type | Description |
|:--- | :--- | :---: | :--- |
|**Character * Int** | Infix operator | String | Return character repeated n times |
|**isEmoji** | Read-Only Variable | Bool | Return true if character is an emoji |
|**isNumber** | Read-Only Variable | Bool | Return true if character is number |
|**toInt** | Read-Only Variable | Int? | Return integer from character (if applicable) |
|**toString** | Read-Only Variable | String | Return string from character |


## Convenience extensions

|Name | Type | Return Type | Description |
|:--- | :--- | :---: | :--- |
|**appBuild** | Read-Only Variable | String? | Return app current build number |
|**applicationIconBadgeNumber** | Variable | Int | Application icon badge number |
|**appVersion** | Read-Only Variable | String? | Return app current version |
|**batteryLevel** | Read-Only Variable | Float | Return current battery level |
|**currentDevice** | Read-Only Variable | UIDevice | Return shared instance of current device |
|**deviceHeight** | Read-Only Variable | Bool | Return device height |
|**deviceModel** | Read-Only Variable | String | Return current device model |
|**deviceName** | Read-Only Variable | String | Return current device name |
|**deviceOrientation** | Read-Only Variable | UIDeviceOrientation | Return current orientation of device |
|**deviceWidth** | Read-Only Variable | Bool | Return device width |
|**isInDebuggingMode** | Read-Only Variable | Bool | Return true if app is running in debug mode |
|**isMultitaskingSupported** | Read-Only Variable | Bool | Return true if multitasking is supported in current device |
|**isNetworkActivityIndicatorVisible** | Variable | Bool | Network activity indicator visibility |
|**isPad** | Read-Only Variable | Bool | Return true if device is iPad |
|**isPhone** | Read-Only Variable | Bool | Return true if device is iPhone |
|**isRegisteredForRemoteNotifications** | Read-Only Variable | Bool | Return true if device is registered for remote notifications for current app |
|**isRunningOnSimulator** | Read-Only Variable | Bool | Return true if application is running on simulator |
|**isStatusBarHidden** | Variable | Bool | Status bar visibility |
|**keyWindow** | Read-Only Variable | UIView? | Return key window |
|**mostTopViewController** | Variable | String? | Most top view controller |
|**object(forKey)** | Function | AnyObject? | Get an object from UserDefaults |
|**set(value, forKey)** | Function | -- | Save an object to UserDefaults |
|**sharedApplication** | Read-Only Variable | UIApplication | Return shared instance of UIApplication |
|**statusBarStyle** | Variable | UIStatusBarStyle? | Current status bar style |
|**systemVersion** | Read-Only Variable | String? | Return system current version |
|**typeName(for object)** | Function | String | Return class name of object as string |
|**userDefaults** | Read-Only Variable | UserDefaults | Return shared instance of standard UserDefaults |


## Date extensions

|Name | Type | Return Type | Description |
|:--- | :--- | :--- | :---: |
|**add(component: Calendar.Component, value: Int)** | Function | -- | Add calendar components to date |
|**beginning(of component: Calendar.Component)** | Function | Date | Return beginning of given date component |
|**calendar** | Read-Only Variable | Calendar | Return user’s current calendar |
|**dateString(ofStyle DateFormatter.Style)** | Function | String | Return date string from date |
|**dateTimeString(ofStyle DateFormatter.Style)** | Function | String | Return date and time string from date |
|**day** | Variable | Int | Day from a date |
|**end(of Calendar.Component)** | Function | Date? | Return date at the end of given date component |
|**era** | Read-Only Variable | Int | Era |
|**hour** | Variable | Int | Hour from a date |
|**init(calendar, timeZone, era, year, month, day, hour, minute, second, nanosecond)** | Initializer | -- | Create a new Date |
|**init(iso8601String: String)** | Initializer | -- | Create date object from ISO8601 string (yyyy-MM-dd'T'HH:mm:ss.SSSZ) |
|**init(unixTimestamp: Double)** | Initializer | -- | Create new date object from UNIX timestamp |
|**isIn(current: Calendar.Component)** | Function | Bool | Return true if date component in current given calendar component |
|**isInFuture** | Read-Only Variable | Bool | Return true if date is in future |
|**isInPast** | Read-Only Variable | Bool | Return true if date is in past |
|**isInToday** | Read-Only Variable | Bool | Return true if date is in today |
|**iso8601String** | Read-Only Variable | String | Return ISO8601 string (yyyy-MM-dd'T'HH:mm:ss.SSS) from date |
|**minute** | Variable | Int | Minutes from a date |
|**month** | Variable | Int | Month |
|**nanosecond** | Read-Only Variable | nanosecond | Nanoseconds from a date |
|**quarter** | Read-Only Variable | Int | Quarter |
|**second** | Variable | Int | Seconds from a date |
|**timeString(ofStyle DateFormatter.Style)** | Function | String | Return time string from date |
|**timeZone** | Read-Only Variable | TimeZone | Return time zone used by system |
|**unixTimestamp** | Read-Only Variable | Double | Get UNIX timestamp from date |
|**weekday** | Read-Only Variable | Int | Weekday from a date |
|**weekOfMonth** | Read-Only Variable | Int | Week of month |
|**weekOfYear** | Read-Only Variable | Int | Week of year |
|**year** | Variable | Int | Year |


## Dictionary extensions

|Name | Type | Return Type | Description |
|:--- | :--- | :---: | :--- |
|**has(Key)** | Function | Bool | Return true if key exists in dictionary. |
|**jsonData(prettify: Bool)** | Function | Data? | Return JSON String from dictionary. |
|**jsonString(prettify: Bool)** | Function | String? | Return JSON String from dictionary. |


## Double extensions

|Name | Type | Return Type | Description |
|:--- | :--- | :---: | :--- |
|**abs** | Read-Only Variable | Double | Return absolute of float value |
|**ceil** | Read-Only Variable | Double | Return ceil of float value |
|**degreesToRadians** | Read-Only Variable | Double | Return radian value of degree input |
|**Double ^ Double** | Infix operator | Double | Return value of exponentiation |
|**floor** | Read-Only Variable | Double | Return floor of float value |
|**radiansToDegrees** | Read-Only Variable | Double | Return degree value of radian input |
|**randomBetween(min, max)** | Static Variable | Double | Return random float value between two float values |
|**± (Double, Double)** | Infix operator | (Double, Double) | Return tuple of plus-minus operation |
|**± Double** | Prefix operator | (Double, Double) | Return tuple of plus-minus operation |
|**√ Double** | Prefix operator | Double | Return square root of value |


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
