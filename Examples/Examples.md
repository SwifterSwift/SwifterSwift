# SwifterSwift Examples

SwifterSwift is a library of **over 500 properties and methods**, designed to extend Swift's functionality and productivity, staying faithful to the original API design guidelines of Swift 3.

Here are some examples:

### Array Extensions:

```swift
// Remove duplicates from an array
[1, 2, 3, 1, 3].removeDuplicates() -> [1, 2, 3]

// Return all indices of specified item
["h", "e", "l", "l", "o"].indices(of: "l") -> [2, 3]

// Shuffle an array
["h", "e", "l", "l", "o"].shuffled() -> ["e", "l", "o", "l", "h"]

// Return random item from an array
[1, 2, 3, 4, 5].randomItem -> 3

// and many others!
```
[Check All Array Extensions!](http://swifterswift.com/docs/Extensions/Array)

---

### Date Extensions:

```swift
// Get and set components from date with ease
date.hour = 14

// Check if date is in today
Date().isInToday -> true

// Add 1 month to current date
Date().add(.month, value: 1)

// Return date at the beginning of current day
Date().beginning(of: .day)

// Return date at the end of current month
Date().end(of: .month)

// Check if date is in current calendar unit
Date().isInCurrent(.month) -> true

// Return iso8601 string for date
Date().iso8601String -> "2016-08-23T21:26:15.287Z"

// Create date from iso8601 string
let date = Date(iso8601String: "2016-08-23T21:26:15.287Z")

// Create date from DateComponents
let date = Date(year: 2016, month: 8, day: 15) // other components are set to current by default.
let date = Date(hour: 9, minute: 18, second: 1) // other components are set to current by default.

// Represent date as a string with ease
Date().dateString(ofStyle: .medium) -> "Aug 26, 2016"
Date().timeString(ofStyle: .short) -> "12:55 AM"
Date().dateTimeString() -> "Aug 26, 2016, 12:55:24 AM"

// Get day name or month name from a date
Date().dayName(ofStyle: .full) -> "Sunday"
Date().monthName(ofStyle: .threeLetters) -> "Dec"

// and many others!
```
[Check All Date Extensions!](http://swifterswift.com/docs/Extensions/Date)

---

### String Extensions:

```swift
// Return count of substring in string
"hello world".count(of "o", caseSensitive: false) -> 2

// Return an array of strings separated by given string
"hello world".split(by: " ") -> ["hello", "world"]

// Return string with no spaces or new lines in beginning and end
"\n Hello   ".trimmed -> "Hello"

// Return most common character in string
"swifterSwift is making swift more swifty".mostCommonCharacter -> "i"

// Returns CamelCase of string
"Some variable nAme".camelCased -> "someVariableName"

// Check if string is in valid email format
"someone@somewebsite.com".isEmail -> true

// Check if string contains at least one letter and one number
"123abc".isAlphaNumeric -> true

// Reverse string
"123abc".reverse() -> "cba321"

// Return latinized string
"Hèllö Wórld!".latinize() -> "Hello World!"

// Create random string of length
String.random(ofLength: 10) -> "AhEju28kNl"

// Check if string contains one or more instance of substring
"Hello World!".contain("o", caseSensitive: false) -> true

// Check if string contains one or more emojis
"string👨‍with😍emojis✊🏿".containEmoji -> true

// Subscript strings easily
"Hello"[2] -> "l"

// Slice strings
let s = "Hello world"
s.slicing(from: 6, length: 5) -> "world"
s.slicing(from: 6, to: 11) -> "world"
s.slicing(at: 6) -> "world"

// Convert string to numbers
"12.12".double -> 12.12

// Encode and decode URLs
"it's easy to encode strings".urlEncoded -> "it's%20easy%20to%20encode%20strings"
"it's%20easy%20to%20encode%20strings".urlDecoded -> "it's easy to encode strings"

// Encode and decode base64
"Hello World!".base64Encoded -> "SGVsbG8gV29ybGQh"
"SGVsbG8gV29ybGQh".base64Decoded = "Hello World!"

// Truncate strings with a trailing
"This is a very long sentence".truncated(toLength: 14, trailing: = "...") -> "This is a very..."

// Repeat a string n times
"s" * 5 -> "sssss"

// NSString has never been easier
let boldString = "this is string".bold.colored(with: .red)

// and many others!
```
[Check All String Extensions!](http://swifterswift.com/docs/Extensions/String)

---

### Dictionary Extensions:

```swift
let dict = ["id": 1, "Product-Name": "SwifterSwift"]

// Check if key exists in dictionary.
dict.has(key: "id") -> true

// Lowercase all keys in dictionary.
dict.lowercaseAllKeys() -> ["id": 1, "product-name": "SwifterSwift"]

// Create JSON Data and string from a dictionary
let json = dict.jsonString(prettify: true)

// and many others!
```
[Check All Dictionary Extensions!](http://swifterswift.com/docs/Extensions/Dictionary)

---


### Number Types Extensions:

```swift
// Return square root of a number
√ 9 -> 3

// Return square power of a number
5 ** 2 -> 25

// Return a number plus or minus another number
5 ± 2 -> (3, 7)

// Return random number in range
Int.randomBetween(min: 1, max: 10) -> 6

// Return roman numeral for a number
134.romanNumeral -> "CXXXIV"

// and many others!
```

[Check All Extensions!](http://swifterswift.com/docs)

---

### UIColor Extensions:

```swift
// Create new UIColor for RGB values
let color = UIColor(red: 121, green: 220, blue: 164)

// Create new UIColor for a hex string (including strings starting with #, 0x or in short css hex format)
let color = UIColor(hexString: "#00F")

// Create new UIColor for a hexadecimal value
let color = UIColor(hex: 0x45C91B)

// Blend two colors with ease
UIColor.blend(UIColor.red, intensity1: 0.5, with: UIColor.green, intensity2: 0.3)

// Return hexadecimal value string
UIColor.red.hexString -> "#FF0000"

// Use Google Material design colors with ease
let indigo = UIColor.material.indigo

// Use CSS colors with ease:
let beige = UIColor.css.beige

// Return brand colors from more than 30 social brands
let facebookColor = UIColor.social.facebook

// and many others!
```
[Check UIColor Extensions!](http://swifterswift.com/docs/Extensions/UIColor)

---


### UIView Extensions

```swift

// Set borderColor, borderWidth, cornerRadius, shadowColor, and many other properties from code or storyboard
view.cornerRadius = 30

// Set some or all corners radiuses of view.
view.roundCorners([.bottomLeft, .topRight], radius: 30)


// Add shadow to view
view.addShadow(ofColor .black, radius: 3, opacity: 0.5)

// Animate view with completion
view.fadeIn(duration: 1, completion:((Bool) -> Void)?)
view.fadeOut(duration: 1, completion:((Bool) -> Void)?)
view.rotate(byAngle 90, ofType type: .degrees, animated: true, duration: 1, completion: { print("done") })
view.rotate(toAngle -3, ofType type: .radians, animated: false, duration: 1, completion: nil)
view.scale(byOffset: 4, animated: true, duration:1)
view.shake(direction: .horizontal, duration: 1, animationType: .easeOut)

// save screenshot of a view
let image = view.screenShot

// and many others!
```
[Check UIView Extensions!](http://swifterswift.com/docs/Extensions/UIView)

---


### UIAlertController Extensions

```swift
// Create a new alert controller from string or Error
let alert = UIAlertController(title: "Couldn't sign in", message: "Invalid username or password!")
let alert = UIAlertController(title: "Error", error: Error)

// show alert with ease
alert.show()

// and many others!
```
[Check UIAlertController Extensions!](http://swifterswift.com/docs/Extensions/UIAlertController)

---

### UIButton Extensions

```swift

// Set title, title color and image for all states at once!
button.setTitleForAllStates("Login")
button.setTitleColorForAllStates(UIColor.blue)
button.setImageForAllStates(UIImage(named: "login"))

// or set each of them from code or storyboard
button.titleForHighlighted = "Login"

// and many others!
```

[Check UIButton Extensions!](http://swifterswift.com/docs/Extensions/UIButton)

---


### UIImage Extensions

```swift
// Crop images
let croppedImage = image.cropped(to CGRect)

// Create UIImage from color
let image = UIImage(color: UIColor, size: CGSize)

// scale to fit width or height
let scaledImage = image.scaled(toHeight: CGFloat)
let scaledImage = image.scaled(toWidth: CGFloat)

// Compress images
let compressedImage = image.compressd(quality: 0.3)

// get image size
image.kilobytesSize -> 114

// and many others!
```
[Check UIImage Extensions!](http://swifterswift.com/docs/Extensions/UIImage)

---


### UIImageView Extensions

```swift
// Download an image from URL in background
imageView.download(from url, contentMode: .scaleAspectFit, placeHolder: UIImage?)

// Blur image view
imageView.blur(withStyle: .light)

// and many others!
```
[Check UIImageView Extensions!](http://swifterswift.com/docs/Extensions/UIImageView)

---

### UINavigationBar Extensions

```swift
// Change navigation bar font and color
navbar.setTitleFont(UIFont.systemFont(ofSize: 10), with color: UIColor.black)

// and many others!
```
[Check UINavigationBar Extensions!](http://swifterswift.com/docs/Extensions/UINavigationBar)

---


### UINavigationController Extensions

```swift
// Pop ViewController with completion handler.
navController.popViewController(completion: (()->Void)?)

// Push ViewController with completion handler.
navController.pushViewController(UIViewController, completion: (()->Void)?)

// and many others!
```
[Check UINavigationController Extensions!](http://swifterswift.com/docs/Extensions/UINavigationController)

---


### UITableView Extensions

```swift
// Return index path for last row in section.
tableView.indexPathForLastRow(in section: 2)

// Scroll to bottom or top of TableView.
tableView.scrollToBottom(animated: true)
tableView.scrollToTop(animated: true)

// and many others!
```

---

### CGPoint Extensions

```swift
// Get distance from another CGPoint.
point1.distance(from: point2) -> 12.45

// Multiply a CGPoint with a scalar
result = 5 * point

// and many others!
```

---

## Misc Extensions

```swift
// Check if app is running in debugging mode
SwifterSwift.isInDebuggingMode

// Check if app is running on simulator
SwifterSwift.isRunningOnSimulator

// Detect screenshots
SwifterSwift.didTakeScreenShot {
	print("User did take a screenshot!")
}

// and many others!
```
