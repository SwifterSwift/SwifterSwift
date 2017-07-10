<p align="left">
  <img src="https://github.com/SwifterSwift/SwifterSwift/blob/master/logo.png?raw=true" title="swifterSwift">
</p>

[![Build Status](https://api.travis-ci.org/SwifterSwift/SwifterSwift.svg?branch=master)](https://travis-ci.org/SwifterSwift/SwifterSwift)
[![Cocoapods](https://img.shields.io/cocoapods/v/SwifterSwift.svg)](https://cocoapods.org/pods/SwifterSwift)
[![Carthage compatible](https://img.shields.io/badge/Carthage-Compatible-brightgreen.svg?style=flat)](https://github.com/Carthage/Carthage)
[![codecov](https://codecov.io/gh/SwifterSwift/SwifterSwift/branch/master/graph/badge.svg)](https://codecov.io/gh/SwifterSwift/SwifterSwift)
[![CocoaPods](https://img.shields.io/cocoapods/dt/SwifterSwift.svg)](https://cocoapods.org/pods/SwifterSwift)
[![CocoaPods](https://img.shields.io/cocoapods/dm/SwifterSwift.svg)](https://cocoapods.org/pods/SwifterSwift)
[![Platform](https://img.shields.io/cocoapods/p/SwifterSwift.svg?style=flat)](https://github.com/SwifterSwift/swifterSwift)
[![Swift](https://img.shields.io/badge/Swift-3.2-orange.svg)](https://swift.org)
[![Xcode](https://img.shields.io/badge/Xcode-8.3-blue.svg)](https://developer.apple.com/xcode)
[![MIT](https://img.shields.io/badge/License-MIT-red.svg)](https://opensource.org/licenses/MIT)


SwifterSwift is a collection of **over 500 native Swift 3 extensions**, with handy methods, syntactic sugar, and performance improvements for wide range of primitive data types, UIKit and Cocoa classes –over 500 in 1– for iOS, macOS, tvOS and watchOS.


## [Whats New in v3?](https://github.com/SwifterSwift/SwifterSwift/wiki/whats-new#v3


# Requirements:
- **iOS** 8.0+ / **tvOS** 9.0+ / **watchOS** 2.0+ / **macOS** 10.10+
- Xcode 8.0+
- Swift 3.0+


# Installation

### CocoaPods

To integrate SwifterSwift into your Xcode project using [CocoaPods](http://cocoapods.org), specify it in your `Podfile`:

```ruby
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

To integrate SwifterSwift into your Xcode project using [Carthage](https://github.com/Carthage/Carthage), specify it in your `Cartfile`:

```ogdl
github "SwifterSwift/SwifterSwift" ~> 3
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
        .Package(url: "https://github.com/SwifterSwift/SwifterSwift.git", majorVersion: 3),
    ]
)
```


### Manually

Add the [extensions](Sources/Extensions) folder to your Xcode project to use all extensions, or a specific extension.


---


# [Foundation Extensions](Sources/Extensions/Foundation)

- [`Array extensions`](Sources/Extensions/Foundation/ArrayExtensions.swift)
- [`Bool extensions`](Sources/Extensions/Foundation/BoolExtensions.swift)
- [`Character extensions`](Sources/Extensions/Foundation/CharacterExtensions.swift)
- [`Collection extensions`](Sources/Extensions/Foundation/CollectionExtensions.swift)
- [`Data extensions`](Sources/Extensions/Foundation/DataExtensions.swift)
- [`Date extensions`](Sources/Extensions/Foundation/DateExtensions.swift)
- [`Dictionary extensions`](Sources/Extensions/Foundation/DictionaryExtensions.swift)
- [`Double extensions`](Sources/Extensions/Foundation/DoubleExtensions.swift)
- [`Float extensions`](Sources/Extensions/Foundation/FloatExtensions.swift)
- [`Int extensions`](Sources/Extensions/Foundation/IntExtensions.swift)
- [`Locale extensions`](Sources/Extensions/Foundation/LocaleExtensions.swift)
- [`Optional extensions`](Sources/Extensions/Foundation/OptionalExtensions.swift)
- [`String extensions`](Sources/Extensions/Foundation/StringExtensions.swift)
- [`URL extensions`](Sources/Extensions/Foundation/URLExtensions.swift)


# [UIKit Extensions](Sources/Extensions/UIKit)

- [`UIAlertController extensions`](Sources/Extensions/UIKit/UIAlertControllerExtensions.swift)
- [`UIBarButtonItem extensions`](Sources/Extensions/UIKit/UIBarButtonItemExtensions.swift)
- [`UIButton extensions`](Sources/Extensions/UIKit/UIButtonExtensions.swift)
- [`UICollectionView extensions`](Sources/Extensions/UIKit/UICollectionViewExtensions.swift)
- [`UIColor extensions`](Sources/Extensions/UIKit/UIColorExtensions.swift)
- [`UIImage extensions`](Sources/Extensions/UIKit/UIImageExtensions.swift)
- [`UIImageView extensions`](Sources/Extensions/UIKit/UIImageViewExtensions.swift)
- [`UILabel extensions`](Sources/Extensions/UIKit/UILabelExtensions.swift)
- [`UINavigationBar extensions`](Sources/Extensions/UIKit/UINavigationBarExtensions.swift)
- [`UINavigationController extensions`](Sources/Extensions/UIKit/UINavigationControllerExtensions.swift)
- [`UINavigationItem extensions`](Sources/Extensions/UIKit/UINavigationItemExtensions.swift)
- [`UISearchBar extensions`](Sources/Extensions/UIKit/UISearchBarExtensions.swift)
- [`UISegmentedControl extensions`](Sources/Extensions/UIKit/UISegmentedControlExtensions.swift)
- [`UISlider extensions`](Sources/Extensions/UIKit/UISliderExtensions.swift)
- [`UIStoryboard extensions`](Sources/Extensions/UIKit/UIStoryboardExtensions.swift)
- [`UISwitch extensions`](Sources/Extensions/UIKit/UISwitchExtensions.swift)
- [`UITabBar extensions`](Sources/Extensions/UIKit/UITabBarExtensions.swift)
- [`UITableView extensions`](Sources/Extensions/UIKit/UITableViewExtensions.swift)
- [`UITextField extensions`](Sources/Extensions/UIKit/UITextFieldExtensions.swift)
- [`UITextView extensions`](Sources/Extensions/UIKit/UITextViewExtensions.swift)
- [`UIView extensions`](Sources/Extensions/UIKit/UIViewExtensions.swift)
- [`UIViewController extensions`](Sources/Extensions/UIKit/UIViewControllerExtensions.swift)


# [Cocoa Extensions](Sources/Extensions/Cocoa)

- [`CGColor extensions`](Sources/Extensions/Cocoa/CGColorExtensions.swift)
- [`CGFloat extensions`](Sources/Extensions/Cocoa/CGFloatExtensions.swift)
- [`CGPoint extensions`](Sources/Extensions/Cocoa/CGPointExtensions.swift)
- [`CGSize extensions`](Sources/Extensions/Cocoa/CGSizeExtensions.swift)
- [`CLLocation extensions`](Sources/Extensions/Cocoa/CLLocationExtensions.swift)
- [`NSAttributedString extensions`](Sources/Extensions/Cocoa/NSAttributedStringExtensions.swift)
- [`NSColor extensions`](Sources/Extensions/Cocoa/NSColorExtensions.swift)
- [`NSView extensions`](Sources/Extensions/Cocoa/NSViewExtensions.swift)

---

# [Misc. Extensions](Sources/Extensions/SwifterSwift.swift)

- [`SwifterSwift`](Sources/Extensions/SwifterSwift.swift)

---


# How cool is this?

`SwifterSwift` is a library of **over 500 properties and methods**, designed to extend Swift's functionality and productivity, staying faithful to the original API design guidelines of Swift 3.

Check [Examples.playground](Examples.playground) for some examples!

---


# Get involved:

Your feedback is always appreciated and welcomed.
Please refer to [contributing guidelines](CONTRIBUTING.md) before participating.

---


# Thanks:

Special thanks to:

- [Paweł Urbanek](https://github.com/pawurb) for adding tvOS, watchOS and macOS initial support and helping with extensions.
- [Steven Deutsch](https://github.com/SD10) for his latest contributions to extensions, docs and tests.
- [Mert Akengin](https://github.com/PvtMert) and [Bashar Ghadanfar](https://www.behance.net/lionbytes) for designing [project website](http://swiftierswift.com) and logo.
- [Abdul Rahman Dabbour](https://github.com/thedabbour) for helping document the project.
