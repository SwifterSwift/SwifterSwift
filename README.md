<p align="left">
  <img src="https://github.com/SwifterSwift/SwifterSwift/blob/master/logo.png?raw=true" title="swifterSwift">
</p>

[![Build Status](https://api.travis-ci.org/SwifterSwift/SwifterSwift.svg?branch=master)](https://travis-ci.org/SwifterSwift/SwifterSwift)
[![Cocoapods](https://img.shields.io/cocoapods/v/SwifterSwift.svg)](https://cocoapods.org/pods/SwifterSwift)
[![Carthage compatible](https://img.shields.io/badge/Carthage-Compatible-brightgreen.svg?style=flat)](https://github.com/Carthage/Carthage)
[![codecov](https://codecov.io/gh/SwifterSwift/SwifterSwift/branch/master/graph/badge.svg)](https://codecov.io/gh/SwifterSwift/SwifterSwift)
[![CocoaPods](https://img.shields.io/cocoapods/dm/SwifterSwift.svg)](https://cocoapods.org/pods/SwifterSwift)
[![Platform](https://img.shields.io/cocoapods/p/SwifterSwift.svg?style=flat)](https://github.com/SwifterSwift/swifterSwift)
[![Swift](https://img.shields.io/badge/Swift-3.0-orange.svg)](https://swift.org)
[![Xcode](https://img.shields.io/badge/Xcode-8.0-blue.svg)](https://developer.apple.com/xcode)
[![MIT](https://img.shields.io/badge/License-MIT-red.svg)](https://opensource.org/licenses/MIT)
[![Join the chat at https://gitter.im/swifterswift/Lobby](https://badges.gitter.im/swifterswift/Lobby.svg)](https://gitter.im/swifterswift/Lobby?utm_source=badge&utm_medium=badge&utm_campaign=pr-badge&utm_content=badge)

SwifterSwift is a collection of **over 500 native Swift 3 extensions**, with handy methods, syntactic sugar, and performance improvements for wide range of primitive data types, UIKit and Cocoa classes –over 500 in 1– for iOS, macOS, tvOS and watchOS.


## [Whats New in v1.6?](https://github.com/SwifterSwift/SwifterSwift/wiki/whats-new#v16)
v1.6 is the biggest update since v1.3! With over 100 new extensions, improved Cocoa support, new tests and many minor bug fixes.


# Requirements:
- **iOS** 8.0+ / **tvOS** 9.0+ / **watchOS** 3+ / **macOS** 10.10+
- Xcode 8.1+
- Swift 3.0+


# Installation

### CocoaPods

[CocoaPods](http://cocoapods.org) is a dependency manager for Cocoa projects. You can install it with the following command:

```bash
$ gem install cocoapods
```

To integrate SwifterSwift into your Xcode project using CocoaPods, specify it in your `Podfile`:

```ruby
source 'https://github.com/CocoaPods/Specs.git'
platform :ios, '8.0'
use_frameworks!

target '<Your Target Name>' do
    pod 'SwifterSwift'
end
```

Then, run the following command:

```bash
$ pod install
```


### Carthage

[Carthage](https://github.com/Carthage/Carthage) is a decentralized dependency manager that builds your dependencies and provides you with binary frameworks.

You can install Carthage with [Homebrew](http://brew.sh/) using the following command:

```bash
$ brew update
$ brew install carthage
```

To integrate SwifterSwift into your Xcode project using Carthage, specify it in your `Cartfile`:

```ogdl
github "SwifterSwift/SwifterSwift" ~> 1.5
```

Run `carthage update` to build the framework and drag the built `SwifterSwift.framework` into your Xcode project.


### Swift Package Manager

You can use [The Swift Package Manager](https://swift.org/package-manager) to install `SwifterSwift` by adding the proper description to your `Package.swift` file:

```swift
import PackageDescription

let package = Package(
    name: "YOUR_PROJECT_NAME",
    targets: [],
    dependencies: [
        .Package(url: "https://github.com/SwifterSwift/SwifterSwift.git", versions: Version(1,4,0)..<Version(2, .max, .max)),
    ]
)
```

Note that the [Swift Package Manager](https://swift.org/package-manager) is still in early design and development, for more information checkout its [GitHub Page](https://github.com/apple/swift-package-manager)


### Manually

Add the [extensions](Source/Extensions) folder to your Xcode project to use all extensions, or a specific extension.


--

# Read the Full Documentation
Full documentation with code examples is available in the [Docs repo](https://github.com/SwifterSwift/SwifterSwiftDocs)

--

# List of Extensions

- [`Array extensions`](https://github.com/SwifterSwift/SwifterSwiftDocs/blob/master/Docs/ArrayExtensions.md)
- [`Bool extensions`](https://github.com/SwifterSwift/SwifterSwiftDocs/blob/master/Docs/BoolExtensions.md)
- [`Character extensions`](https://github.com/SwifterSwift/SwifterSwiftDocs/blob/master/Docs/CharacterExtensions.md)
- [`Collection extensions`](https://github.com/SwifterSwift/SwifterSwiftDocs/blob/master/Docs/CollectionExtensions.md)
- [`Data extensions`](https://github.com/SwifterSwift/SwifterSwiftDocs/blob/master/Docs/DataExtensions.md)
- [`Date extensions`](https://github.com/SwifterSwift/SwifterSwiftDocs/blob/master/Docs/DateExtensions.md)
- [`Dictionary extensions`](https://github.com/SwifterSwift/SwifterSwiftDocs/blob/master/Docs/DictionaryExtensions.md)
- [`Double extensions`](https://github.com/SwifterSwift/SwifterSwiftDocs/blob/master/Docs/DoubleExtensions.md)
- [`Float extensions`](https://github.com/SwifterSwift/SwifterSwiftDocs/blob/master/Docs/FloatExtensions.md)
- [`Int extensions`](https://github.com/SwifterSwift/SwifterSwiftDocs/blob/master/Docs/IntExtensions.md)
- [`String extensions`](https://github.com/SwifterSwift/SwifterSwiftDocs/blob/master/Docs/StringExtensions.md)
- [`URL extensions`](https://github.com/SwifterSwift/SwifterSwiftDocs/blob/master/Docs/URLExtensions.md)
- [`SwifterSwift`](https://github.com/SwifterSwift/SwifterSwiftDocs/blob/master/Docs/SwifterSwift.md)


# List of UIKit Extensions

- [`UIAlertController extensions`](https://github.com/SwifterSwift/SwifterSwiftDocs/blob/master/Docs/UIKit/UIAlertControllerExtensions.md)
- [`UIBarButtonItem extensions`](https://github.com/SwifterSwift/SwifterSwiftDocs/blob/master/Docs/UIKit/UIBarButtonItemExtensions.md)
- [`UIButton extensions`](https://github.com/SwifterSwift/SwifterSwiftDocs/blob/master/Docs/UIKit/UIButton)
- [`UICollectionView extensions`](https://github.com/SwifterSwift/SwifterSwiftDocs/blob/master/Docs/UIKit/UICollectionViewExtensions.md)
- [`UIColor extensions`](https://github.com/SwifterSwift/SwifterSwiftDocs/blob/master/Docs/UIKit/UIColorExtensions.md)
- [`UIImage extensions`](https://github.com/SwifterSwift/SwifterSwiftDocs/blob/master/Docs/UIKit/UIImageExtensions.md)
- [`UIImageView extensions`](https://github.com/SwifterSwift/SwifterSwiftDocs/blob/master/Docs/UIKit/UIImageViewExtensions.md)
- [`UILabel extensions`](https://github.com/SwifterSwift/SwifterSwiftDocs/blob/master/Docs/UIKit/UILabelExtensions.md)
- [`UINavigationBar extensions`](https://github.com/SwifterSwift/SwifterSwiftDocs/blob/master/Docs/UIKit/UINavigationBarExtensions.md)
- [`UINavigationController extensions`](https://github.com/SwifterSwift/SwifterSwiftDocs/blob/master/Docs/UIKit/UINavigationControllerExtensions.md)
- [`UINavigationItem extensions`](https://github.com/SwifterSwift/SwifterSwiftDocs/blob/master/Docs/UIKit/UINavigationItemExtensions.md)
- [`UISearchBar extensions`](https://github.com/SwifterSwift/SwifterSwiftDocs/blob/master/Docs/UIKit/UISearchBarExtensions.md)
- [`UISegmentedControl extensions`](https://github.com/SwifterSwift/SwifterSwiftDocs/blob/master/Docs/UIKit/UISegmentedControlExtensions.md)
- [`UISlider extensions`](https://github.com/SwifterSwift/SwifterSwiftDocs/blob/master/Docs/UIKit/UISliderExtensions.md)
- [`UISwitch extensions`](https://github.com/SwifterSwift/SwifterSwiftDocs/blob/master/Docs/UIKit/UISwitchExtensions.md)
- [`UITabBar extensions`](https://github.com/SwifterSwift/SwifterSwiftDocs/blob/master/Docs/UIKit/UITabBarExtensions.md)
- [`UITableView extensions`](https://github.com/SwifterSwift/SwifterSwiftDocs/blob/master/Docs/UIKit/UITableViewExtensions.md)
- [`UITextField extensions`](https://github.com/SwifterSwift/SwifterSwiftDocs/blob/master/Docs/UIKit/UITextFieldExtensions.md)
- [`UITextView extensions`](https://github.com/SwifterSwift/SwifterSwiftDocs/blob/master/Docs/UIKit/UITextViewExtensions.md)
- [`UIView extensions`](https://github.com/SwifterSwift/SwifterSwiftDocs/blob/master/Docs/UIKit/UIViewExtensions.md)
- [`UIViewController extensions`](https://github.com/SwifterSwift/SwifterSwiftDocs/blob/master/Docs/UIKit/UIViewControllerExtensions.md)


# List of Cocoa Extensions

- [`CGColor extensions`](https://github.com/SwifterSwift/SwifterSwiftDocs/blob/master/Docs/Cocoa/CGColorExtensions.md)
- [`CGFloat extensions`](https://github.com/SwifterSwift/SwifterSwiftDocs/blob/master/Docs/Cocoa/CGFloatExtensions.md)
- [`CGPoint extensions`](https://github.com/SwifterSwift/SwifterSwiftDocs/blob/master/Docs/Cocoa/CGPointExtensions.md)
- [`CGSize extensions`](https://github.com/SwifterSwift/SwifterSwiftDocs/blob/master/Docs/Cocoa/CGSizeExtensions.md)
- [`NSAttributedString extensions`](https://github.com/SwifterSwift/SwifterSwiftDocs/blob/Docs/Cocoa/UIKit/NSAttributedStringExtensions.md)
- [`NSColor extensions`](https://github.com/SwifterSwift/SwifterSwiftDocs/blob/master/Docs/Cocoa/NSColorExtensions.md)

--


# How cool is this?

`SwifterSwift` is a library of **over 500 properties and methods**, designed to extend Swift's functionality and productivity, staying faithful to the original API design guidelines of Swift 3.

Here are some examples:

### Array Extensions:

```swift
// Remove duplicates from an array
[1, 2, 3, 1, 3].removeDuplicates() -> [1, 2, 3]

// Return all indexes of specified item
["h", "e", "l", "l", "o"].indexes(of: "l") -> [2, 3]

// Shuffle an array
["h", "e", "l", "l", "o"].shuffled = ["e", "l", "o", "l", "h"]

// Return random item from an array
[1, 2, 3, 4, 5].randomItem -> 3

// and many others!
```
[Check All Array Extensions!](https://github.com/SwifterSwift/SwifterSwiftDocs/blob/master/Docs/ArrayExtensions.md)

--

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
let date = Date(year: 2016, month: 8, day: 15) // other components set to current
let date = Date(hour: 9, minute: 18, second: 1) // other components set to current

// Represent date as a string with ease
Date().dateString(ofStyle: .medium) -> "Aug 26, 2016"
Date().timeString(ofStyle: .short) -> "12:55 AM"
Date().dateTimeString() -> "Aug 26, 2016, 12:55:24 AM"

// Get day name or month name from a date
Date().dayName(ofStyle: .full) -> "Sunday"
Date().monthName(ofStyle: .threeLetters) -> "Dec"

// and many others!
```
[Check All Date Extensions!](https://github.com/SwifterSwift/SwifterSwiftDocs/blob/master/Docs/DateExtensions.md)

--

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
"Hello"[2] = "l"

// Slice strings
let s = "Hello world"
s.slicing(from: 6, length: 5) // -> "world"
s.slicing(from: 6, to: 11) // -> "world"
s.slicing(at: 6) // -> "world"

// Convert string to numbers
"12.12".toDouble -> 12.12

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
[Check All String Extensions!](https://github.com/SwifterSwift/SwifterSwiftDocs/blob/master/Docs/StringExtensions.md)

--

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
[Check All Dictionary Extensions!](https://github.com/SwifterSwift/SwifterSwiftDocs/blob/master/Docs/DictionaryExtensions.md)

--


### Number Types Extensions:

```swift
// Return square root of a number
√ 9 = 3

// Return square power of a number
5 ** 2 = 25

// Return a number plus or minus another number
5 ± 2 = (3, 7)

// Return random number in range
Int.randomBetween(min: 1, max: 10) = 6

// Return roman numeral for a number
134.romanNumeral = "CXXXIV"

// and many others!
```

[Check All Extensions!](https://github.com/SwifterSwift/SwifterSwiftDocs/tree/master/Docs)

--

## UIKit Extensions

SwifterSwift has many great extensions for UIKit also:

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

// Return short hexadecimal value string
UIColor(hex: #00ffff) -> "#0FF"

// Use Google Material design colors with ease
let indigo = UIColor.material.indigo

// Use CSS colors with ease:
let beige = UIColor.css.beige

// Return brand colors from more than 30 social brands
let facebookColor = UIColor.social.facebook

// and many others!
```
[Check UIColor Extensions!](https://github.com/SwifterSwift/SwifterSwiftDocs/blob/master/Docs/UIKit/UIColorExtensions.md)

--


### UIView Extensions

```swift

// Set borderColor, borderWidth, cornerRadius, shadowColor, and many other properties from code or storyboard
view.cornerRadius = 30

// Set some or all corners radiuses of view.
view.roundCorners([.bottomLeft, .topRight], radius: 30)


// Add shadow to view
view.addShadow(ofColor .black, radius: 3, opacity: 0.5)

```
<p align="left">
  <img src="https://raw.githubusercontent.com/SwifterSwift/SwifterSwift/master/Screenshots/view_storyboard.png" title="UIButton properties from storyboard" width='250px'>
</p>

```swift
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
[Check UIView Extensions!](https://github.com/SwifterSwift/SwifterSwiftDocs/blob/master/Docs/UIKit/UIViewExtensions.md)

--


### UIAlertController Extensions

```swift
// Create a new alert controller from string or Error
let alert = UIAlertController(title: "Couldn't sign in", message: "Invalid username or password!")
let alert = UIAlertController(title: "Error", error: Error)

// show alert with ease
alert.show()

// and many others!
```
[Check UIAlertController Extensions!](https://github.com/SwifterSwift/SwifterSwiftDocs/blob/master/Docs/UIKit/UIAlertControllerExtensions.md)

--

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
<p align="left">
  <img src="https://raw.githubusercontent.com/SwifterSwift/SwifterSwift/master/Screenshots/button_storyboard.png" title="UIButton properties from storyboard" width='250px'>
</p>

[Check UIButton Extensions!](https://github.com/SwifterSwift/SwifterSwiftDocs/blob/master/Docs/UIKit/UIButtonExtensions.md)

--


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
image.kilobytesSize = 114

// and many others!
```
[Check UIImage Extensions!](https://github.com/SwifterSwift/SwifterSwiftDocs/blob/master/Docs/UIKit/UIImageExtensions.md)

--


### UIImageView Extensions

```swift
// Download an image from URL in background
imageView.download(from url, contentMode: .scaleAspectFit, placeHolder: UIImage?)

// Blur image view
imageView.blur(withStyle: .light)

// and many others!
```
[Check UIImageView Extensions!](https://github.com/SwifterSwift/SwifterSwiftDocs/blob/master/Docs/UIKit/UIImageViewExtensions.md)

--

### UINavigationBar Extensions

```swift
// Change navigation bar font and color
navbar.setTitleFont(UIFont, with color: UIColor.black)

// and many others!
```
[Check UINavigationBar Extensions!](https://github.com/SwifterSwift/SwifterSwiftDocs/blob/master/Docs/UIKit/UINavigationBarExtensions.md)

--


### UINavigationController Extensions

```swift
// Pop ViewController with completion handler.
navController.popViewController(completion: (()->Void)?)

// Push ViewController with completion handler.
navController.pushViewController(UIViewController, completion: (()->Void)?)

// and many others!
```
[Check UINavigationController Extensions!](https://github.com/SwifterSwift/SwifterSwiftDocs/blob/master/Docs/UIKit/UINavigationControllerExtensions.md)

--


### UITableView Extensions

```swift
// Return index path for last row in section.
tableView.indexPathForLastRow(in section: 2)

// Scroll to bottom or top of TableView.
tableView.scrollToBottom(animated: true)
tableView.scrollToTop(animated: true)

// and many others!
```

[Check All UIKit Extensions!](https://github.com/SwifterSwift/SwifterSwiftDocs/tree/master/Docs/UIKit)

--


## Cocoa Extensions

SwifterSwift has many great extensions for Cocoa too:


### CGPoint Extensions

```swift
// Get distance from another CGPoint.
point1.distance(from point2) = 12.45

Multiply a CGPoint with a scalar
result = 5 * point

// and many others!
```
[Check All Cocoa Extensions!](https://github.com/SwifterSwift/SwifterSwiftDocs/tree/master/Docs/Cocoa)

--

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
[Check SwifterSwift Extensions!](https://github.com/SwifterSwift/SwifterSwiftDocs/blob/master/Docs/SwifterSwift.md)

--

# Get involved:

Your feedback is always appreciated and welcomed.
Please refer to contributing guidelines before participating.

- [Contributing guidelines for extensions](https://github.com/SwifterSwift/SwifterSwift/blob/master/CONTRIBUTING.md)
- [Contributing guidelines for documentations](https://github.com/SwifterSwift/SwifterSwiftDocs/blob/master/CONTRIBUTING.md)

--

# Thanks:

Special thanks to:

* [Paweł Urbanek](https://github.com/pawurb) for adding tvOS & watchOS initial support and helping with extensions.

* [Mert Akengin](https://github.com/PvtMert) for creating [project website](http://swiftierswift.com).

* [Bashar Ghadanfar](https://www.behance.net/lionbytes) for designing the project logo.

* [Abdul Rahman Dabbour](https://github.com/thedabbour) for helping document the project.
