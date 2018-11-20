<p align="left">
  <img src="https://cdn.rawgit.com/SwifterSwift/SwifterSwift/master/Assets/logo.svg" title="swifterSwift">
</p>

[![Build Status](https://api.travis-ci.org/SwifterSwift/SwifterSwift.svg?branch=master)](https://travis-ci.org/SwifterSwift/SwifterSwift)
[![Platforms](https://img.shields.io/cocoapods/p/SwifterSwift.svg?style=flat)](https://github.com/SwifterSwift/swifterSwift)
[![Cocoapods](https://img.shields.io/cocoapods/v/SwifterSwift.svg)](https://cocoapods.org/pods/SwifterSwift)
[![Carthage compatible](https://img.shields.io/badge/Carthage-Compatible-brightgreen.svg?style=flat)](https://github.com/Carthage/Carthage)
[![codecov](https://codecov.io/gh/SwifterSwift/SwifterSwift/branch/master/graph/badge.svg)](https://codecov.io/gh/SwifterSwift/SwifterSwift)
[![docs](http://swifterswift.com/docs/badge.svg)](http://swifterswift.com/docs)
[![CocoaPods](https://img.shields.io/cocoapods/dt/SwifterSwift.svg)](https://cocoapods.org/pods/SwifterSwift)
[![CocoaPods](https://img.shields.io/cocoapods/dm/SwifterSwift.svg)](https://cocoapods.org/pods/SwifterSwift)
[![Swift](https://img.shields.io/badge/Swift-4.2-orange.svg)](https://swift.org)
[![Xcode](https://img.shields.io/badge/Xcode-10.0-blue.svg)](https://developer.apple.com/xcode)
[![MIT](https://img.shields.io/badge/License-MIT-red.svg)](https://opensource.org/licenses/MIT)
[![Slack Channel](https://slackin-ppvrggbpgn.now.sh/badge.svg)](https://slackin-ppvrggbpgn.now.sh/)


SwifterSwift is a collection of **over 500 native Swift extensions**, with handy methods, syntactic sugar, and performance improvements for wide range of primitive data types, UIKit and Cocoa classes –over 500 in 1– for iOS, macOS, tvOS, watchOS and Linux.


### [Whats New in v4.6.0?](https://github.com/SwifterSwift/SwifterSwift/blob/master/CHANGELOG.md#v460)

## Requirements:
- **iOS** 8.0+ / **tvOS** 9.0+ / **watchOS** 2.0+ / **macOS** 10.10+ / **Ubuntu** 14.04+
- Swift 4.2+



## Looking for Swift 3
- To use with **Swift 3 / Xcode 8.x** please ensure you are using [**`v3.1.1`**](https://github.com/SwifterSwift/SwifterSwift/releases/tag/3.1.1).
- To use with **Swift 3.2 / Xcode 9.x** please ensure you are using [**`v3.2.0`**](https://github.com/SwifterSwift/SwifterSwift/releases/tag/3.2.0).



## Installation

<details>
<summary>CocoaPods</summary>
</br>
<p>To integrate SwifterSwift into your Xcode project using <a href="http://cocoapods.org">CocoaPods</a>, specify it in your <code>Podfile</code>:</p>

<h4>- Integrate All extensions (recommended):</h4>
<pre><code class="ruby language-ruby">pod 'SwifterSwift'</code></pre>

<h4>- Integrate SwiftStdlib extensions only:</h4>
<pre><code class="ruby language-ruby">pod 'SwifterSwift/SwiftStdlib'</code></pre>

<h4>- Integrate Foundation extensions only:</h4>
<pre><code class="ruby language-ruby">pod 'SwifterSwift/Foundation'</code></pre>

<h4>- Integrate AppKit extensions only:</h4>
<pre><code class="ruby language-ruby">pod 'SwifterSwift/AppKit'</code></pre>

<h4>- Integrate MapKit extensions only:</h4>
<pre><code class="ruby language-ruby">pod 'SwifterSwift/MapKit'</code></pre>

<h4>- Integrate CoreGraphics extensions only:</h4>
<pre><code class="ruby language-ruby">pod 'SwifterSwift/CoreGraphics'</code></pre>

<h4>- Integrate CoreLocation extensions only:</h4>
<pre><code class="ruby language-ruby">pod 'SwifterSwift/CoreLocation'</code></pre>

<h4>- Integrate SpriteKit extensions only:</h4>
<pre><code class="ruby language-ruby">pod 'SwifterSwift/SpriteKit'</code></pre>
</details>


<details>
<summary>Carthage</summary>
</br>
<p>To integrate SwifterSwift into your Xcode project using <a href="https://github.com/Carthage/Carthage">Carthage</a>, specify it in your <code>Cartfile</code>:</p>

<pre><code class="ogdl language-ogdl">github "SwifterSwift/SwifterSwift" ~&gt; 4.0
</code></pre>
</details>


<details>
<summary>Swift Package Manager</summary>
</br>
<p>You can use <a href="https://swift.org/package-manager">The Swift Package Manager</a> to install <code>SwifterSwift</code> by adding the proper description to your <code>Package.swift</code> file:</p>

<pre><code class="swift language-swift">import PackageDescription

let package = Package(
    name: "YOUR_PROJECT_NAME",
    targets: [],
    dependencies: [
        .package(url: "https://github.com/SwifterSwift/SwifterSwift.git", from: "4.0.0")
    ]
)
</code></pre>

<p>Note that the <a href="https://swift.org/package-manager">Swift Package Manager</a> is still in early design and development, for more information checkout its <a href="https://github.com/apple/swift-package-manager">GitHub Page</a></p>
</details>


<details>
<summary>Manually</summary>
</br>
<p>Add the <a href="https://github.com/SwifterSwift/SwifterSwift/tree/master/Sources/Extensions">extensions</a> folder to your Xcode project to use all extensions, or a specific extension.</p>
</details>



## List of All Extensions

<details>
<summary>SwiftStdlib Extensions</summary>
</br>
<ul>
<li><a href="https://github.com/SwifterSwift/SwifterSwift/tree/master/Sources/Extensions/SwiftStdlib/ArrayExtensions.swift"><code>Array extensions</code></a></li>
<li><a href="https://github.com/SwifterSwift/SwifterSwift/tree/master/Sources/Extensions/SwiftStdlib/BoolExtensions.swift"><code>Bool extensions</code></a></li>
<li><a href="https://github.com/SwifterSwift/SwifterSwift/tree/master/Sources/Extensions/SwiftStdlib/CharacterExtensions.swift"><code>Character extensions</code></a></li>
<li><a href="https://github.com/SwifterSwift/SwifterSwift/tree/master/Sources/Extensions/SwiftStdlib/CollectionExtensions.swift"><code>Collection extensions</code></a></li>
<li><a href="https://github.com/SwifterSwift/SwifterSwift/tree/master/Sources/Extensions/SwiftStdlib/DictionaryExtensions.swift"><code>Dictionary extensions</code></a></li>
<li><a href="https://github.com/SwifterSwift/SwifterSwift/tree/master/Sources/Extensions/SwiftStdlib/DoubleExtensions.swift"><code>Double extensions</code></a></li>
<li><a href="https://github.com/SwifterSwift/SwifterSwift/tree/master/Sources/Extensions/SwiftStdlib/FloatExtensions.swift"><code>Float extensions</code></a></li>
<li><a href="https://github.com/SwifterSwift/SwifterSwift/tree/master/Sources/Extensions/SwiftStdlib/FloatingPointExtensions.swift"><code>FloatingPoint extensions</code></a></li>
<li><a href="https://github.com/SwifterSwift/SwifterSwift/tree/master/Sources/Extensions/SwiftStdlib/IntExtensions.swift"><code>Int extensions</code></a></li>
<li><a href="https://github.com/SwifterSwift/SwifterSwift/tree/master/Sources/Extensions/SwiftStdlib/OptionalExtensions.swift"><code>Optional extensions</code></a></li>
<li><a href="https://github.com/SwifterSwift/SwifterSwift/blob/master/Sources/Extensions/SwiftStdlib/SequenceExtensions.swift"><code>Sequence extensions</code></a></li>
<li><a href="https://github.com/SwifterSwift/SwifterSwift/tree/master/Sources/Extensions/SwiftStdlib/SignedIntegerExtensions.swift"><code>SignedInteger extensions</code></a></li>
<li><a href="https://github.com/SwifterSwift/SwifterSwift/tree/master/Sources/Extensions/SwiftStdlib/SignedNumericExtensions.swift"><code>SignedNumeric extensions</code></a></li>
<li><a href="https://github.com/SwifterSwift/SwifterSwift/tree/master/Sources/Extensions/SwiftStdlib/StringExtensions.swift"><code>String extensions</code></a></li>
<li><a href="https://github.com/SwifterSwift/SwifterSwift/blob/master/Sources/Extensions/SwiftStdlib/StringProtocolExtensions.swift"><code>StringProtocol extensions</code></a></li>
</ul>
</details>


<details>
<summary>Foundation Extensions</summary>
</br>
<ul>
<li><a href="https://github.com/SwifterSwift/SwifterSwift/tree/master/Sources/Extensions/Foundation/CalendarExtensions.swift"><code>Calendar extensions</code></a></li>
<li><a href="https://github.com/SwifterSwift/SwifterSwift/tree/master/Sources/Extensions/Foundation/DataExtensions.swift"><code>Data extensions</code></a></li>
<li><a href="https://github.com/SwifterSwift/SwifterSwift/tree/master/Sources/Extensions/Foundation/DateExtensions.swift"><code>Date extensions</code></a></li>
<li><a href="https://github.com/SwifterSwift/SwifterSwift/blob/master/Sources/Extensions/Foundation/FileManagerExtensions.swift"><code>FileManager extensions</code></a></li>
<li><a href="https://github.com/SwifterSwift/SwifterSwift/tree/master/Sources/Extensions/Foundation/LocaleExtensions.swift"><code>Locale extensions</code></a></li>
<li><a href="https://github.com/SwifterSwift/SwifterSwift/tree/master/Sources/Extensions/Foundation/NSAttributedStringExtensions.swift"><code>NSAttributedString extensions</code></a></li>
<li><a href="https://github.com/SwifterSwift/SwifterSwift/tree/master/Sources/Extensions/Foundation/NSPredicateExtensions.swift"><code>NSPredicate extensions</code></a></li>
<li><a href="https://github.com/SwifterSwift/SwifterSwift/tree/master/Sources/Extensions/Foundation/URLExtensions.swift"><code>URL extensions</code></a></li>
<li><a href="https://github.com/SwifterSwift/SwifterSwift/tree/master/Sources/Extensions/Foundation/URLRequestExtensions.swift"><code>URLRequest extensions</code></a></li>
<li><a href="https://github.com/SwifterSwift/SwifterSwift/tree/master/Sources/Extensions/Foundation/UserDefaultsExtensions.swift"><code>UserDefaults extensions</code></a></li>
</ul>
</details>


<details>
<summary>UIKit Extensions</summary>
</br>
<ul>
<li><a href="https://github.com/SwifterSwift/SwifterSwift/tree/master/Sources/Extensions/UIKit/UIAlertControllerExtensions.swift"><code>UIAlertController extensions</code></a></li>
<li><a href="https://github.com/SwifterSwift/SwifterSwift/tree/master/Sources/Extensions/UIKit/UIBarButtonItemExtensions.swift"><code>UIBarButtonItem extensions</code></a></li>
<li><a href="https://github.com/SwifterSwift/SwifterSwift/tree/master/Sources/Extensions/UIKit/UIButtonExtensions.swift"><code>UIButton extensions</code></a></li>
<li><a href="https://github.com/SwifterSwift/SwifterSwift/tree/master/Sources/Extensions/UIKit/UICollectionViewExtensions.swift"><code>UICollectionView extensions</code></a></li>
<li><a href="https://github.com/SwifterSwift/SwifterSwift/tree/master/Sources/Extensions/UIKit/UIDatePickerExtensions.swift"><code>UIDatePicker extensions</code></a></li>
<li><a href="https://github.com/SwifterSwift/SwifterSwift/tree/master/Sources/Extensions/UIKit/UIFontExtensions.swift"><code>UIFont extensions</code></a></li>
<li><a href="https://github.com/SwifterSwift/SwifterSwift/tree/master/Sources/Extensions/Shared/ColorExtensions.swift"><code>UIColor extensions</code></a></li>
<li><a href="https://github.com/SwifterSwift/SwifterSwift/tree/master/Sources/Extensions/UIKit/UIImageExtensions.swift"><code>UIImage extensions</code></a></li>
<li><a href="https://github.com/SwifterSwift/SwifterSwift/tree/master/Sources/Extensions/UIKit/UIImageViewExtensions.swift"><code>UIImageView extensions</code></a></li>
<li><a href="https://github.com/SwifterSwift/SwifterSwift/tree/master/Sources/Extensions/UIKit/UILabelExtensions.swift"><code>UILabel extensions</code></a></li>
<li><a href="https://github.com/SwifterSwift/SwifterSwift/tree/master/Sources/Extensions/UIKit/UINavigationBarExtensions.swift"><code>UINavigationBar extensions</code></a></li>
<li><a href="https://github.com/SwifterSwift/SwifterSwift/tree/master/Sources/Extensions/UIKit/UINavigationControllerExtensions.swift"><code>UINavigationController extensions</code></a></li>
<li><a href="https://github.com/SwifterSwift/SwifterSwift/tree/master/Sources/Extensions/UIKit/UINavigationItemExtensions.swift"><code>UINavigationItem extensions</code></a></li>
<li><a href="https://github.com/SwifterSwift/SwifterSwift/tree/master/Sources/Extensions/UIKit/UISearchBarExtensions.swift"><code>UISearchBar extensions</code></a></li>
<li><a href="https://github.com/SwifterSwift/SwifterSwift/tree/master/Sources/Extensions/UIKit/UISegmentedControlExtensions.swift"><code>UISegmentedControl extensions</code></a></li>
<li><a href="https://github.com/SwifterSwift/SwifterSwift/tree/master/Sources/Extensions/UIKit/UISliderExtensions.swift"><code>UISlider extensions</code></a></li>
<li><a href="https://github.com/SwifterSwift/SwifterSwift/blob/master/Sources/Extensions/UIKit/UIStackViewExtensions.swift"><code>UIStackView extensions</code></a></li>
<li><a href="https://github.com/SwifterSwift/SwifterSwift/tree/master/Sources/Extensions/UIKit/UIStoryboardExtensions.swift"><code>UIStoryboard extensions</code></a></li>
<li><a href="https://github.com/SwifterSwift/SwifterSwift/tree/master/Sources/Extensions/UIKit/UISwitchExtensions.swift"><code>UISwitch extensions</code></a></li>
<li><a href="https://github.com/SwifterSwift/SwifterSwift/tree/master/Sources/Extensions/UIKit/UITabBarExtensions.swift"><code>UITabBar extensions</code></a></li>
<li><a href="https://github.com/SwifterSwift/SwifterSwift/tree/master/Sources/Extensions/UIKit/UITableViewExtensions.swift"><code>UITableView extensions</code></a></li>
<li><a href="https://github.com/SwifterSwift/SwifterSwift/tree/master/Sources/Extensions/UIKit/UITextFieldExtensions.swift"><code>UITextField extensions</code></a></li>
<li><a href="https://github.com/SwifterSwift/SwifterSwift/tree/master/Sources/Extensions/UIKit/UITextViewExtensions.swift"><code>UITextView extensions</code></a></li>
<li><a href="https://github.com/SwifterSwift/SwifterSwift/tree/master/Sources/Extensions/UIKit/UIViewControllerExtensions.swift"><code>UIViewController extensions</code></a></li>
<li><a href="https://github.com/SwifterSwift/SwifterSwift/tree/master/Sources/Extensions/UIKit/UIViewExtensions.swift"><code>UIView extensions</code></a></li>
<li><a href="https://github.com/SwifterSwift/SwifterSwift/tree/master/Sources/Extensions/UIKit/UIWindowExtensions.swift"><code>UIWindow extensions</code></a></li>
</ul>
</details>


<details>
<summary>AppKit Extensions</summary>
</br>
<ul>
<li><a href="https://github.com/SwifterSwift/SwifterSwift/tree/master/Sources/Extensions/Shared/ColorExtensions.swift"><code>NSColor extensions</code></a></li>
<li><a href="https://github.com/SwifterSwift/SwifterSwift/tree/master/Sources/Extensions/AppKit/NSViewExtensions.swift"><code>NSView extensions</code></a></li>
<li><a href="https://github.com/SwifterSwift/SwifterSwift/tree/master/Sources/Extensions/AppKit/NSImageExtensions.swift"><code>NSImage extensions</code></a></li>
</ul>
</details>

<details>
<summary>CoreGraphics Extensions</summary>
</br>
<ul>
<li><a href="https://github.com/SwifterSwift/SwifterSwift/tree/master/Sources/Extensions/CoreGraphics/CGColorExtensions.swift"><code>CGColor extensions</code></a></li>
<li><a href="https://github.com/SwifterSwift/SwifterSwift/tree/master/Sources/Extensions/CoreGraphics/CGFloatExtensions.swift"><code>CGFloat extensions</code></a></li>
<li><a href="https://github.com/SwifterSwift/SwifterSwift/tree/master/Sources/Extensions/CoreGraphics/CGPointExtensions.swift"><code>CGPoint extensions</code></a></li>
<li><a href="https://github.com/SwifterSwift/SwifterSwift/tree/master/Sources/Extensions/CoreGraphics/CGSizeExtensions.swift"><code>CGSize extensions</code></a></li>
</ul>
</details>

<details>
<summary>CoreLocation Extensions</summary>
</br>
<ul>
<li><a href="https://github.com/SwifterSwift/SwifterSwift/tree/master/Sources/Extensions/CoreLocation/CLLocationExtensions.swift"><code>CLLocation extensions</code></a></li>
</ul>
</details>

<details>
<summary>MapKit Extensions</summary>
</br>
<ul>
<li><a href="https://github.com/SwifterSwift/SwifterSwift/blob/master/Sources/Extensions/MapKit/MKPolylineExtensions.swift"><code>MKPolylineExtensions</code></a></li>
</ul>
</details>

<details>
<summary>SpriteKit Extensions</summary>
</br>
<ul>
<li><a href="https://github.com/SwifterSwift/SwifterSwift/blob/master/Sources/Extensions/SpriteKit/SKNodeExtensions.swift"><code>SKNodeExtensions</code></a></li>
</ul>
</details>


<details>
<summary>Misc. Extensions</summary>
</br>
<ul>
<li><a href="https://github.com/SwifterSwift/SwifterSwift/tree/master/Sources/Extensions/SwifterSwift.swift"><code>SwifterSwift</code></a></li>
</ul>
</details>



## How cool is this?

SwifterSwift is a library of **over 500 properties and methods**, designed to extend Swift's functionality and productivity, staying faithful to the original Swift API design guidelines.

Check Examples.playground from the project for some cool examples!



## Documentation

Documentation for all extensions, with examples, is available at [swifterswift.com/docs](http://swifterswift.com/docs)



## Get involved:

We want your feedback.
Please refer to [contributing guidelines](https://github.com/SwifterSwift/SwifterSwift/tree/master/CONTRIBUTING.md) before participating.



## Slack Channel: [![Slack](https://slackin-ppvrggbpgn.now.sh/badge.svg)](https://slackin-ppvrggbpgn.now.sh/)

It is always nice to talk with other people using SwifterSwift and exchange experiences, so come [join our Slack channel](https://slackin-ppvrggbpgn.now.sh/).



## Thanks:

Special thanks to:

- [Steven Deutsch](https://github.com/SD10) and [Luciano Almeida](https://github.com/LucianoPAlmeida) for their latest contributions to extensions, docs and tests.
- [Paweł Urbanek](https://github.com/pawurb) for adding tvOS, watchOS, and macOS initial support and helping with extensions.
- [Mert Akengin](https://github.com/pvtmert) and [Bashar Ghadanfar](https://www.behance.net/lionbytes) for designing [project website](http://swifterswift.com) and logo.
- [Abdul Rahman Dabbour](https://github.com/ardabbour) for helping document the project.
- Many thanks to all other [contributors](https://github.com/SwifterSwift/SwifterSwift/graphs/contributors) of this project.



## License

SwifterSwift is released under the MIT license. See [LICENSE](https://github.com/SwifterSwift/SwifterSwift/blob/master/LICENSE) for more information.
