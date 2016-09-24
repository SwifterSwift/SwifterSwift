## List Of All Extensions

- [x] [Array extensions](#array-extensions)
- [x] [Character extensions](#character-extensions)
- [x] [Convenience extensions](#convenience-extensions)
- [x] [Date extensions](#date-extensions)
- [x] [Dictionary extensions](#dictionary-extensions)
- [x] [Double extensions](#double-extensions)
- [x] [Float extensions](#float-extensions)
- [x] [Int extensions](#int-extensions)
- [x] [String extensions](#string-extensions)
- [x] [CGFloat extensions](#cgfloat-extensions)
- [x] [CGSize extensions](#cgsize-extensions)
- [ ] [UIAlertController extensions](#uialertcontroller-extensions)
- [ ] [UIButton extensions](#uibutton-extensions)
- [ ] [UIColor extensions](#uicolor-extensions)
- [ ] [UIImage extensions](#uiimage-extensions)
- [ ] [UIImageView extensions](#uiimageview-extensions)
- [ ] [UINavigationBar extensions](#uinavigationbar-extensions)
- [ ] [UINavigationController extensions](#uinavigationcontroller-extensions)
- [ ] [UISearchBar extensions](#uisearchbar-extensions)
- [ ] [UILabel extensions](#uilabel-extensions)
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
|**Character * Int** | Infix operator | String | Return Character repeated n times |
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
|**nearestFiveMinutes** | Read-Only Variable | Date | Return nearest five minutes to date |
|**nearestTenMinutes** | Read-Only Variable | Date | Return nearest ten minutes to date |
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
|**has(Key)** | Function | Bool | Return true if key exists in dictionary |
|**jsonData(prettify: Bool)** | Function | Data? | Return JSON String from dictionary |
|**jsonString(prettify: Bool)** | Function | String? | Return JSON String from dictionary |


## Double extensions

|Name | Type | Return Type | Description |
|:--- | :--- | :---: | :--- |
|**abs** | Read-Only Variable | Double | Return absolute of double value |
|**ceil** | Read-Only Variable | Double | Return ceil of double value |
|**degreesToRadians** | Read-Only Variable | Double | Return radian value of degree input |
|**Double ** Double** | Infix operator | Double | Return value of exponentiation |
|**floor** | Read-Only Variable | Double | Return floor of double value |
|**radiansToDegrees** | Read-Only Variable | Double | Return degree value of radian input |
|**randomBetween(min, max)** | Static Variable | Double | Return random double value between two double values |
|**± (Double, Double)** | Infix operator | (Double, Double) | Return tuple of plus-minus operation |
|**± Double** | Prefix operator | (Double, Double) | Return tuple of plus-minus operation |
|**√ Double** | Prefix operator | Double | Return square root of value |


## Float extensions

|Name | Type | Return Type | Description |
|:--- | :--- | :---: | :--- |
|**abs** | Read-Only Variable | Float | Return absolute of float value |
|**ceil** | Read-Only Variable | Float | Return ceil of float value |
|**degreesToRadians** | Read-Only Variable | Float | Return radian value of degree input |
|**Float ** Float** | Infix operator | Float | Return value of exponentiation |
|**floor** | Read-Only Variable | Float | Return floor of float value |
|**radiansToDegrees** | Read-Only Variable | Float | Return degree value of radian input |
|**randomBetween(min, max)** | Static Variable | Float | Return random float value between two float values |
|**± (Float, Float)** | Infix operator | (Float, Float) | Return tuple of plus-minus operation |
|**± Float** | Prefix operator | (Float, Float) | Return tuple of plus-minus operation |
|**√ Float** | Prefix operator | Float | Return square root of value |


## Int extensions

|Name | Type | Return Type | Description |
|:--- | :--- | :---: | :--- |
|**abs** | Read-Only Variable | Int | Return absolute of integer value |
|**degreesToRadians** | Read-Only Variable | Double | Return radian value of degree input |
|**digits** | Variable | [Int] | Return array of digits of integer value |
|**digitsCount** | Read-Only Variable | Int | Returns number of digits of integer value |
|**gcd(of n)** | Function | Int | Return greatest common divisor of integer value and n |
|**Int ** Int** | Infix operator | Double | Return value of exponentiation |
|**isEven** | Read-Only Variable | Bool | Checks if integer value is even |
|**isOdd** | Read-Only Variable | Bool | Checks if integer value is odd |
|**lcm(of n)** | Function | Int | Return least common multiple of integer value and n |
|**radiansToDegrees** | Read-Only Variable | Double | Return degree value of radian input |
|**randomBetween(min, max)** | Static Function | Int | Return random integer value between two integer values |
|**romanNumeral** | Read-Only Variable | String? | Return roman numeral from an integer (I, II, IV, X,..) |
|**timeString** | Read-Only Variable | String | Return string of format (XXh XXm) from seconds Int |
|**± (Int, Int)** | Infix operator | (Int, Int) | Return tuple of plus-minus operation |
|**± Int** | Prefix operator | (Int, Int) | Return tuple of plus-minus operation |
|**√ Int** | Prefix operator | Double | Return square root of value |


## String extensions

|Name | Type | Return Type | Description |
|:--- | :--- | :---: | :--- |
|**base64Decoded** | Read-Only Variable | String? | Return string decoded from base64 |
|**base64Encoded** | Read-Only Variable | String? | Return string encoded in base64 |
|**camelCased** | Read-Only Variable | String | Returns CamelCase of string |
|**camelize()** | Function | -- | Converts string format to CamelCase |
|**contain(String, caseSensitive: Bool)** | Function | Bool | Return true if string contains one or more instance of substring |
|**containEmoji** | Read-Only Variable | Bool | Return true if string contains one or more emojis |
|**count(of String, caseSensitive: Bool)** | Function | Int | Return count of substring in string |
|**end(with String, caseSensitive: Bool)** | Function | Bool | Return true if string ends with substring |
|**firstCharacter** | Read-Only Variable | String? | Return first character of string |
|**firstIndex(of string: String)** | Variable | Int? | Return first index of substring in string |
|**hasLetters** | Read-Only Variable | Bool | Return true if string contains one or more letters |
|**hasNumbers** | Read-Only Variable | Bool | Return true if string contains one or more numbers |
|**isAlphabetic** | Read-Only Variable | Bool | Return true if string contains only letters |
|**isAlphaNumeric** | Read-Only Variable | Bool | Return true if string contains at least one letter and one number |
|**isEmail** | Read-Only Variable | Bool | Return true if string is valid email format |
|**isHttpsUrl** | Read-Only Variable | Bool | Return true is string is https URL |
|**isHttpUrl** | Read-Only Variable | Bool | Return true if string is http URL |
|**isNumeric** | Read-Only Variable | Bool | Return true if string contains only numbers |
|**lastCharacter** | Read-Only Variable | String? | Return last character of string |
|**latinize()** | Function | -- | Latinize string |
|**latinized** | Read-Only Variable | String | Return latinized string |
|**lines()** | Function | [String] | Returns array of strings separated by new lines |
|**locale** | Read-Only Variable | Locale | Return current locale |
|**mostCommonCharacter** | Read-Only Variable | String | Return most common character in string |
|**random(of length: Int)** | Function | String | Return random string of given length |
|**replace(String, with: String)** | Function | String | Replace part of string with another string |
|**reverse()** | Function | -- | Reverse string |
|**reversed** | Read-Only Variable | String | Return reversed string |
|**split(by separator: Character)** | Function | [String] | Return an array of strings separated by given string |
|**start(with prefix: String, caseSensitive: Bool)** | Function | Bool | Return true if string starts with substring |
|**String * Int** | Infix operator | String | Return string repeated n times |
|**toBool** | Read-Only Variable | Bool? | Return Bool value from string (if applicable) |
|**toDate** | Read-Only Variable | Date? | Return date object from "yyyy-MM-dd" formatted string |
|**toDateTime** | Read-Only Variable | Date? | Return date object from "yyyy-MM-dd HH:mm:ss" formatted string |
|**toDouble** | Read-Only Variable | Double? | Return Double value from string (if applicable) |
|**toFloat** | Read-Only Variable | Float? | Return Float value from string (if applicable) |
|**toFloat32** | Read-Only Variable | Float32? | Return Float32 value from string (if applicable) |
|**toFloat64** | Read-Only Variable | Float64? | Return Float64 value from string (if applicable) |
|**toInt** | Read-Only Variable | Int? | Return Int value from string (if applicable) |
|**toInt16** | Read-Only Variable | Int16? | Return Int16 value from string (if applicable) |
|**toInt32** | Read-Only Variable | Int32? | Return Int32 value from string (if applicable) |
|**toInt64** | Read-Only Variable | Int32? | Return Int64 value from string (if applicable) |
|**toInt8** | Read-Only Variable | Int8? | Return Int8 value from string (if applicable) |
|**trim()** | Function | -- | Removes spaces and new lines in beginning and end of string |
|**trimmed** | Read-Only Variable | String | Return string with no spaces or new lines in beginning and end |
|**truncate(to length: Int, trailing: String)** | Mutating function | -- | Return truncated string (limited to a given number of characters) |
|**truncated(to length: Int, trailing: String)** | Function | String | Return truncated string (limited to a given number of characters) |
|**unicodeArray** | Read-Only Variable | [Int] | Return an array with unicodes for all characters in a string |
|**urlDecoded** | Read-Only Variable | String | Return readable string from url string |
|**urlDecode** | Function | -- | Convert url string into readable string |
|**urlEncoded** | Read-Only Variable | String | Return url escaped string |
|**urlEncode** | Function | -- | Escape a string |
|**withoutSpacesAndNewLines** | Read-Only Variable | String | Return string without spaces and new lines |


## CGFloat extensions

|Name | Type | Return Type | Description |
|:--- | :--- | :---: | :--- |
|**abs** | Read-Only Variable | CGFloat | Return absolute of float value |
|**ceil** | Read-Only Variable | CGFloat | Return ceil of float value |
|**degreesToRadians** | Read-Only Variable | CGFloat | Return radian value of degree input |
|**CGFloat ** CGFloat** | Infix operator | CGFloat | Return value of exponentiation |
|**floor** | Read-Only Variable | CGFloat | Return floor of float value |
|**radiansToDegrees** | Read-Only Variable | CGFloat | Return degree value of radian input |
|**randomBetween(min, max)** | Static Variable | CGFloat | Return random float value between two float values |
|**± (CGFloat, CGFloat)** | Infix operator | (CGFloat, CGFloat) | Return tuple of plus-minus operation |
|**± CGFloat** | Prefix operator | (CGFloat, CGFloat) | Return tuple of plus-minus operation |
|**√ CGFloat** | Prefix operator | CGFloat | Return square root of value |


## CGSize extensions

|Name | Type | Return Type | Description |
|:--- | :--- | :---: | :--- |
|**aspectFit(to boundingSize: CGSize)** | Function | CGSize | Aspect fit CGSize |


## UIAlertController extensions

|Name | Type | Return Type | Description |
|:--- | :--- | :---: | :--- |
|**init(title: String, message: String?, defaultActionButtonTitle: String, tintColor: UIColor?)** | Initializer | -- | Create new alert view controller with default OK action |
|**init(title: String, error: Error, defaultActionButtonTitle: String, tintColor: UIColor?)** | Initializer | -- | Create new error alert view controller from Error with default OK action |
|**show()** | Function | -- | Present alert view controller in the current view controller |


## UIButton extensions

|Name | Type | Return Type | Description |
|:--- | :--- | :---: | :--- |
|**imageForAllStates(image: UIImage)** | Function | -- | Set title for all states |
|**imageForDisabled** | IBInspectable variable | UIImage? | Image of disabled state for button; also inspectable from Storyboard |
|**imageForHighlighted** | IBInspectable variable | UIImage? | Image of highlighted state for button; also inspectable from Storyboard |
|**imageForNormal** | IBInspectable variable | UIImage? | Image of normal state for button; also inspectable from Storyboard |
|**imageForSelected** | IBInspectable variable | UIImage? | Image of selected state for button; also inspectable from Storyboard |
|**titleColorForAllStates(color: UIColor)** | Function | -- | Set title color for all states |
|**titleColorForDisabled** | IBInspectable variable | UIImage? | Title color of disabled state for button; also inspectable from Storyboard |
|**titleColorForHighlighted** | IBInspectable variable | UIImage? | Title color of highlighted state for button; also inspectable from Storyboard |
|**titleColorForNormal** | IBInspectable variable | UIImage? | Title color of normal state for button; also inspectable from Storyboard |
|**titleColorForSelected** | IBInspectable variable | UIImage? | Title color of selected state for button; also inspectable from Storyboard |
|**titleForAllStates(title: String)** | Function | -- | Set title for all states |
|**titleForDisabled** | IBInspectable variable | String? | Title of disabled state for button; also inspectable from Storyboard |
|**titleForHighlighted** | IBInspectable variable | String? | Title of highlighted state for button; also inspectable from Storyboard |
|**titleForNormal** | IBInspectable variable | String? | Title of normal state for button; also inspectable from Storyboard |
|**titleForSelected** | IBInspectable variable | String? | Title of selected state for button; also inspectable from Storyboard |


# UIColor extensions

|Name | Type | Return Type | Description |
|:--- | :--- | :---: | :--- |
|**hexString** | Read-Only Variable | String | Return hexadecimal value string |
|**init(netHex)** | Initializer | -- | Create new UIColor from hexadecimal value |
|**init(netHex, transparency)** | Initializer | -- | Create new UIColor from hexadicimal value with transparency |
|**init(red, green, blue)** | Initializer | -- | Create new UIColor from RGB values |
|**init(red, green, blue, transparency)** | Initializer | -- | Create new UIColor from RGB values with transparency |
|**random** | Static Read-Only Variable | UIColor | Return a random color |
|**socialColors** | Struct | -- | Brand identity color of popular social media platform |


# UIImage extensions

|Name | Type | Return Type | Description |
|:--- | :--- | :---: | :--- |
|**cropped(to: CGRect)** | Function | UIImage | Create image of size from UIColor |
|**filled(withColor color: UIColor)** | Function | UIImage | Return image filled with color |
|**init(UIColor, CGSize)** | Initializer | -- | Crop image to CGRect |
|**scaledToHeight(height: CGFloat, with UIImageOrientation?)** | Function | UIImage? | Scale image to width with respect to aspect ratio |
|**scaledToWidth(width: CGFloat, with UIImageOrientation?)** | Function | UIImage? | Scale image to width with respect to aspect ratio |

# UIImageView extensions

|Name | Type | Return Type | Description |
|:--- | :--- | :---: | :--- |
|**blur(withStyle: UIBlurEffectStyle)** | Function | -- | Make image view blurry |
|**blurred(withStyle: UIBlurEffectStyle)** | Function | UIImageView | Return a blurred version of an image view |
|**download(from url: String, contentMode: UIViewContentMode, placeHolder: UIImage?)** | Function | UIImage? | Download image from url and set it in an imageView |


# UINavigationBar extensions

|Name | Type | Return Type | Description |
|:--- | :--- | :---: | :--- |
|**makeTransparent(withTint: UIColor)** | Function | -- | Make navigation bar transparent |
|**setTitleFont(font: UIFont, with color: UIColor)** | Function | -- | Set Navigation Bar title, title color and font |


# UINavigationController extensions

|Name | Type | Return Type | Description |
|:--- | :--- | :---: | :--- |
|**makeTransparent(withTint: UIColor)** | Function | -- | Make navigation controller's navigation bar transparent |
|**popViewControllerWithHandler(completion)** | Function | -- | Pop viewController with completion handler |
|**pushViewController(viewController, completion)** | Function | -- | Push viewController with completion handler |


## UISearchBar extensions

|Name | Type | Return Type | Description |
|:--- | :--- | :---: | :--- |
|**cancelButton** | Read-Only variable | UIButton? | Cancel button in search bar |


## UILabel extensions

|Name | Type | Return Type | Description |
|:--- | :--- | :---: | :--- |
|**requiredHeight** | Read-Only variable | CGFloat | Return required height for a label |


## UITableView extensions

|Name | Type | Return Type | Description |
|:--- | :--- | :---: | :--- |
|**indexPathForLastRow(in section: Int)** | Function | IndexPath? | Return index path for last row in section |
|**indexPathForLastRow** | Read-Only variable | IndexPath? | Return last section in table |
|**lastSection** | Read-Only variable | Int | Return last section in table |
|**removeTableFooterView** | Function | -- | Remove Table FooterView |
|**removeTableHeaderView** | Function | -- | Remove Table HeaderView |
|**scrollToBottom(animated: Bool)** | Function | -- | Scroll to bottom of TableView |
|**scrollToTop(animated: Bool)** | Function | -- | Scroll to top of TableView |
|**totalRows** | Read-Only variable | Int | Return number of all rows in all sections of table |


# UITextField extensions

|Name | Type | Return Type | Description |
|:--- | :--- | :---: | :--- |
|**isEmpty** | Read-Only Variable | Bool | Return true if text field is empty |
|**trimmedText** | Read-Only Variable | String? | Return text with no spaces or new lines in beginning and end |

# UIViewController extensions

|Name | Type | Return Type | Description |
|:--- | :--- | :---: | :--- |
|**addNotificationObserver(Notification.Name, Selector)** | Function | -- | Assign as listener to notification |
|**isVisible** | Read-Only Variable | Bool | Return true if ViewController is onscreen and not hidden |
|**navigationBar** | Read-Only Variable | UINavigationBar? | Return navigationBar in a ViewController |
|**removeNotificationObserver(Notification.Name)** | Function | -- | Unassign as listener to notification |
|**removeNotificationsObserver()** | Function | -- | Unassign as listener from all notifications |


# UIView extensions

|Name | Type | Return Type | Description |
|:--- | :--- | :---: | :--- |
|**addShadow(ofColor color: UIColor, radius: CGFloat, offset: CGSize, opacity: Float)** | Function | -- | Add shadow to view |
|**add(subViews: [UIView])** | Function | -- | Add array of subviews to view |
|**borderColor** | IBInspectable variable | UIColor? | Border color of view; also inspectable from Storyboard |
|**borderWidth** | IBInspectable variable | CGFloat | Border width of view; also inspectable from Storyboard |
|**cornerRadius** | IBInspectable variable | CGFloat | Corner radius of view; also inspectable from Storyboard |
|**fadeIn(duration, completion)** | Function | -- | Fade in view |
|**fadeOut(duration, completion)** | Function | -- | Fade out view |
|**firstResponder** | Read-Only variable | UIView? | Return current first responder in viewController |
|**height** | Variable | CGFloat | Height of view |
|**isRightToLeft** | Read-Only variable | Bool | Return true if view is in RTL format |
|**isVisible** | Read-Only Variable | Bool | Return true if view is visible in screen currently and not hidden |
|**loadFromNibNamed(String, Bundle?)** | Static Function | UIView? | Add array of subviews to view |
|**removeSubViews()** | Function | -- | Remove all subviews in view |
|**removeGestureRecognizers()** | Function | -- | Remove all gesture recognizers from view |
|**rotate(byAngle, ofType, animated: Bool, duration, completion)** | Function | -- | Rotate view by angle on relative axis |
|**rotate(toAngle, ofType, animated: Bool, duration, completion)** | Function | -- | Rotate view to angle on fixed axis |
|**scale(by offset, duration, completion)** | Function | -- | Scale view by offset |
|**screenShot** | Read-Only variable | UIImage? | Take screenshot of view |
|**shadowColor** | IBInspectable variable | UIColor? | Shadow color of view; also inspectable from Storyboard |
|**shadowOffset** | IBInspectable variable | CGSize | Shadow offset of view; also inspectable from Storyboard |
|**shadowOpacity** | IBInspectable variable | Float | Shadow opacity of view; also inspectable from Storyboard |
|**shadowRadius** | IBInspectable variable | CGFloat | Shadow radius of view; also inspectable from Storyboard |
|**shake(direction, duration, animationType, completion)** | Function | -- | Shake view |
|**size** | Variable | CGSize | Size of view |
|**width** | Variable | CGFloat | Width of view |
