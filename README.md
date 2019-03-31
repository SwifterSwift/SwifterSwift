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
[![Swift](https://img.shields.io/badge/Swift-5.0-orange.svg)](https://swift.org)
[![Xcode](https://img.shields.io/badge/Xcode-10.2-blue.svg)](https://developer.apple.com/xcode)
[![MIT](https://img.shields.io/badge/License-MIT-red.svg)](https://opensource.org/licenses/MIT)
[![Slack Channel](https://slackin-ppvrggbpgn.now.sh/badge.svg)](https://slackin-ppvrggbpgn.now.sh/)

SwifterSwift is a collection of **over 500 native Swift extensions**, with handy methods, syntactic sugar, and performance improvements for wide range of primitive data types, UIKit and Cocoa classes –over 500 in 1– for iOS, macOS, tvOS, watchOS and Linux.

### [Whats New in v5?](https://github.com/SwifterSwift/SwifterSwift/blob/master/CHANGELOG.md#v500)

## Requirements

- **iOS** 8.0+ / **tvOS** 9.0+ / **watchOS** 2.0+ / **macOS** 10.10+ / **Ubuntu** 14.04+
- Swift 5.0+

## Looking to use SwifterSwift for older versions of Swift

SwifterSwift is Swift v5.0 compatible starting from v5

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

<h4>- Integrate Dispatch extensions only:</h4>
<pre><code class="ruby language-ruby">pod 'SwifterSwift/Dispatch'</code></pre>
</details>

<details>
<summary>Carthage</summary>
</br>
<p>To integrate SwifterSwift into your Xcode project using <a href="https://github.com/Carthage/Carthage">Carthage</a>, specify it in your <code>Cartfile</code>:</p>

<pre><code class="ogdl language-ogdl">github "SwifterSwift/SwifterSwift" ~&gt; 5.0
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
        .package(url: "https://github.com/SwifterSwift/SwifterSwift.git", from: "5.0.0")
    ]
)
</code></pre>
</details>


<details>
<summary>Manually</summary>
</br>
<p>Add the <a href="https://github.com/SwifterSwift/SwifterSwift/tree/master/Sources/SwifterSwift">SwifterSwift</a> folder to your Xcode project to use all extensions, or a specific extension.</p>
</details>

## List of All Extensions

<details>
<summary>SwiftStdlib Extensions</summary>
</br>
<ul>
<li><a href="https://github.com/SwifterSwift/SwifterSwift/tree/master/Sources/SwifterSwift/SwiftStdlib/ArrayExtensions.swift"><code>Array extensions</code></a></li>
<li><a href="https://github.com/SwifterSwift/SwifterSwift/tree/master/Sources/SwifterSwift/SwiftStdlib/BidirectionalCollectionExtensions.swift"><code>BidirectionalCollection extensions</code></a></li>
<li><a href="https://github.com/SwifterSwift/SwifterSwift/tree/master/Sources/SwifterSwift/SwiftStdlib/BinaryFloatingPointExtensions.swift"><code>BinaryFloatingPoint extensions</code></a></li>
<li><a href="https://github.com/SwifterSwift/SwifterSwift/tree/master/Sources/SwifterSwift/SwiftStdlib/BoolExtensions.swift"><code>Bool extensions</code></a></li>
<li><a href="https://github.com/SwifterSwift/SwifterSwift/tree/master/Sources/SwifterSwift/SwiftStdlib/CharacterExtensions.swift"><code>Character extensions</code></a></li>
<li><a href="https://github.com/SwifterSwift/SwifterSwift/tree/master/Sources/SwifterSwift/SwiftStdlib/CollectionExtensions.swift"><code>Collection extensions</code></a></li>
<li><a href="https://github.com/SwifterSwift/SwifterSwift/tree/master/Sources/SwifterSwift/SwiftStdlib/ComparableExtensions.swift"><code>Comparable extensions</code></a></li>
<li><a href="https://github.com/SwifterSwift/SwifterSwift/tree/master/Sources/SwifterSwift/SwiftStdlib/DictionaryExtensions.swift"><code>Dictionary extensions</code></a></li>
<li><a href="https://github.com/SwifterSwift/SwifterSwift/tree/master/Sources/SwifterSwift/SwiftStdlib/DoubleExtensions.swift"><code>Double extensions</code></a></li>
<li><a href="https://github.com/SwifterSwift/SwifterSwift/tree/master/Sources/SwifterSwift/SwiftStdlib/FloatExtensions.swift"><code>Float extensions</code></a></li>
<li><a href="https://github.com/SwifterSwift/SwifterSwift/tree/master/Sources/SwifterSwift/SwiftStdlib/FloatingPointExtensions.swift"><code>FloatingPoint extensions</code></a></li>
<li><a href="https://github.com/SwifterSwift/SwifterSwift/tree/master/Sources/SwifterSwift/SwiftStdlib/IntExtensions.swift"><code>Int extensions</code></a></li>
<li><a href="https://github.com/SwifterSwift/SwifterSwift/tree/master/Sources/SwifterSwift/SwiftStdlib/OptionalExtensions.swift"><code>Optional extensions</code></a></li>
<li><a href="https://github.com/SwifterSwift/SwifterSwift/tree/master/Sources/SwifterSwift/SwiftStdlib/OptionalExtensions.swift"><code>Optional extensions</code></a></li>
<li><a href="https://github.com/SwifterSwift/SwifterSwift/blob/master/Sources/SwifterSwift/SwiftStdlib/RandomAccessCollectionExtensions.swift"><code>RandomAccessCollection extensions</code></a></li>
<li><a href="https://github.com/SwifterSwift/SwifterSwift/blob/master/Sources/SwifterSwift/SwiftStdlib/RangeReplaceableCollectionExtensions.swift"><code>RangeReplaceableCollection extensions</code></a></li>
<li><a href="https://github.com/SwifterSwift/SwifterSwift/tree/master/Sources/SwifterSwift/SwiftStdlib/SequenceExtensions.swift"><code>Sequence extensions</code></a></li>
<li><a href="https://github.com/SwifterSwift/SwifterSwift/tree/master/Sources/SwifterSwift/SwiftStdlib/SignedIntegerExtensions.swift"><code>SignedInteger extensions</code></a></li>
<li><a href="https://github.com/SwifterSwift/SwifterSwift/tree/master/Sources/SwifterSwift/SwiftStdlib/SignedNumericExtensions.swift"><code>SignedNumeric extensions</code></a></li>
<li><a href="https://github.com/SwifterSwift/SwifterSwift/tree/master/Sources/SwifterSwift/SwiftStdlib/StringExtensions.swift"><code>String extensions</code></a></li>
<li><a href="https://github.com/SwifterSwift/SwifterSwift/blob/master/Sources/SwifterSwift/SwiftStdlib/StringProtocolExtensions.swift"><code>StringProtocol extensions</code></a></li>
</ul>
</details>


<details>
<summary>Foundation Extensions</summary>
</br>
<ul>
<li><a href="https://github.com/SwifterSwift/SwifterSwift/tree/master/Sources/SwifterSwift/Foundation/CalendarExtensions.swift"><code>Calendar extensions</code></a></li>
<li><a href="https://github.com/SwifterSwift/SwifterSwift/tree/master/Sources/SwifterSwift/Foundation/DataExtensions.swift"><code>Data extensions</code></a></li>
<li><a href="https://github.com/SwifterSwift/SwifterSwift/tree/master/Sources/SwifterSwift/Foundation/DateExtensions.swift"><code>Date extensions</code></a></li>
<li><a href="https://github.com/SwifterSwift/SwifterSwift/blob/master/Sources/SwifterSwift/Foundation/FileManagerExtensions.swift"><code>FileManager extensions</code></a></li>
<li><a href="https://github.com/SwifterSwift/SwifterSwift/tree/master/Sources/SwifterSwift/Foundation/LocaleExtensions.swift"><code>Locale extensions</code></a></li>
<li><a href="https://github.com/SwifterSwift/SwifterSwift/tree/master/Sources/SwifterSwift/Foundation/NSAttributedStringExtensions.swift"><code>NSAttributedString extensions</code></a></li>
<li><a href="https://github.com/SwifterSwift/SwifterSwift/tree/master/Sources/SwifterSwift/Foundation/NSPredicateExtensions.swift"><code>NSPredicate extensions</code></a></li>
<li><a href="https://github.com/SwifterSwift/SwifterSwift/tree/master/Sources/SwifterSwift/Foundation/URLExtensions.swift"><code>URL extensions</code></a></li>
<li><a href="https://github.com/SwifterSwift/SwifterSwift/tree/master/Sources/SwifterSwift/Foundation/URLRequestExtensions.swift"><code>URLRequest extensions</code></a></li>
<li><a href="https://github.com/SwifterSwift/SwifterSwift/tree/master/Sources/SwifterSwift/Foundation/UserDefaultsExtensions.swift"><code>UserDefaults extensions</code></a></li>
</ul>
</details>


<details>
<summary>UIKit Extensions</summary>
</br>
<ul>
<li><a href="https://github.com/SwifterSwift/SwifterSwift/tree/master/Sources/SwifterSwift/UIKit/UIActivityExtensions.swift"><code>UIActivity extensions</code></a></li>
<li><a href="https://github.com/SwifterSwift/SwifterSwift/tree/master/Sources/SwifterSwift/UIKit/UIAlertControllerExtensions.swift"><code>UIAlertController extensions</code></a></li>
<li><a href="https://github.com/SwifterSwift/SwifterSwift/tree/master/Sources/SwifterSwift/UIKit/UIApplicationExtensions.swift"><code>UIApplication extensions</code></a></li>
<li><a href="https://github.com/SwifterSwift/SwifterSwift/tree/master/Sources/SwifterSwift/UIKit/UIBarButtonItemExtensions.swift"><code>UIBarButtonItem extensions</code></a></li>
<li><a href="https://github.com/SwifterSwift/SwifterSwift/tree/master/Sources/SwifterSwift/UIKit/UIButtonExtensions.swift"><code>UIButton extensions</code></a></li>
<li><a href="https://github.com/SwifterSwift/SwifterSwift/tree/master/Sources/SwifterSwift/UIKit/UICollectionViewExtensions.swift"><code>UICollectionView extensions</code></a></li>
<li><a href="https://github.com/SwifterSwift/SwifterSwift/tree/master/Sources/SwifterSwift/Shared/ColorExtensions.swift"><code>UIColor extensions</code></a></li>
<li><a href="https://github.com/SwifterSwift/SwifterSwift/tree/master/Sources/SwifterSwift/UIKit/UIDatePickerExtensions.swift"><code>UIDatePicker extensions</code></a></li>
<li><a href="https://github.com/SwifterSwift/SwifterSwift/tree/master/Sources/SwifterSwift/UIKit/UIEdgeInsetsExtensions.swift"><code>UIEdgeInsets extensions</code></a></li>
<li><a href="https://github.com/SwifterSwift/SwifterSwift/tree/master/Sources/SwifterSwift/UIKit/UIFontExtensions.swift"><code>UIFont extensions</code></a></li>
<li><a href="https://github.com/SwifterSwift/SwifterSwift/tree/master/Sources/SwifterSwift/UIKit/UIGestureRecognizer.swift"><code>UIGestureRecognizer extensions</code></a></li>
<li><a href="https://github.com/SwifterSwift/SwifterSwift/tree/master/Sources/SwifterSwift/UIKit/UIImageExtensions.swift"><code>UIImage extensions</code></a></li>
<li><a href="https://github.com/SwifterSwift/SwifterSwift/tree/master/Sources/SwifterSwift/UIKit/UIImageViewExtensions.swift"><code>UIImageView extensions</code></a></li>
<li><a href="https://github.com/SwifterSwift/SwifterSwift/tree/master/Sources/SwifterSwift/UIKit/UILabelExtensions.swift"><code>UILabel extensions</code></a></li>
<li><a href="https://github.com/SwifterSwift/SwifterSwift/tree/master/Sources/SwifterSwift/UIKit/UILayoutPriorityExtensions.swift"><code>UILayoutPriority extensions</code></a></li>
<li><a href="https://github.com/SwifterSwift/SwifterSwift/tree/master/Sources/SwifterSwift/UIKit/UINavigationBarExtensions.swift"><code>UINavigationBar extensions</code></a></li>
<li><a href="https://github.com/SwifterSwift/SwifterSwift/tree/master/Sources/SwifterSwift/UIKit/UINavigationControllerExtensions.swift"><code>UINavigationController extensions</code></a></li>
<li><a href="https://github.com/SwifterSwift/SwifterSwift/tree/master/Sources/SwifterSwift/UIKit/UINavigationItemExtensions.swift"><code>UINavigationItem extensions</code></a></li>
<li><a href="https://github.com/SwifterSwift/SwifterSwift/tree/master/Sources/SwifterSwift/UIKit/UIRefreshControlExtensions.swift"><code>UIRefreshControl extensions</code></a></li>
<li><a href="https://github.com/SwifterSwift/SwifterSwift/tree/master/Sources/SwifterSwift/UIKit/UIScrollViewExtensions.swift"><code>UIScrollView extensions</code></a></li>
<li><a href="https://github.com/SwifterSwift/SwifterSwift/tree/master/Sources/SwifterSwift/UIKit/UISearchBarExtensions.swift"><code>UISearchBar extensions</code></a></li>
<li><a href="https://github.com/SwifterSwift/SwifterSwift/tree/master/Sources/SwifterSwift/UIKit/UISegmentedControlExtensions.swift"><code>UISegmentedControl extensions</code></a></li>
<li><a href="https://github.com/SwifterSwift/SwifterSwift/tree/master/Sources/SwifterSwift/UIKit/UISliderExtensions.swift"><code>UISlider extensions</code></a></li>
<li><a href="https://github.com/SwifterSwift/SwifterSwift/blob/master/Sources/SwifterSwift/UIKit/UIStackViewExtensions.swift"><code>UIStackView extensions</code></a></li>
<li><a href="https://github.com/SwifterSwift/SwifterSwift/tree/master/Sources/SwifterSwift/UIKit/UIStoryboardExtensions.swift"><code>UIStoryboard extensions</code></a></li>
<li><a href="https://github.com/SwifterSwift/SwifterSwift/tree/master/Sources/SwifterSwift/UIKit/UISwitchExtensions.swift"><code>UISwitch extensions</code></a></li>
<li><a href="https://github.com/SwifterSwift/SwifterSwift/tree/master/Sources/SwifterSwift/UIKit/UITabBarExtensions.swift"><code>UITabBar extensions</code></a></li>
<li><a href="https://github.com/SwifterSwift/SwifterSwift/tree/master/Sources/SwifterSwift/UIKit/UITableViewExtensions.swift"><code>UITableView extensions</code></a></li>
<li><a href="https://github.com/SwifterSwift/SwifterSwift/tree/master/Sources/SwifterSwift/UIKit/UITextFieldExtensions.swift"><code>UITextField extensions</code></a></li>
<li><a href="https://github.com/SwifterSwift/SwifterSwift/tree/master/Sources/SwifterSwift/UIKit/UITextViewExtensions.swift"><code>UITextView extensions</code></a></li>
<li><a href="https://github.com/SwifterSwift/SwifterSwift/tree/master/Sources/SwifterSwift/UIKit/UIViewControllerExtensions.swift"><code>UIViewController extensions</code></a></li>
<li><a href="https://github.com/SwifterSwift/SwifterSwift/tree/master/Sources/SwifterSwift/UIKit/UIViewExtensions.swift"><code>UIView extensions</code></a></li>
<li><a href="https://github.com/SwifterSwift/SwifterSwift/tree/master/Sources/SwifterSwift/UIKit/UIWindowExtensions.swift"><code>UIWindow extensions</code></a></li>
</ul>
</details>


<details>
<summary>AppKit Extensions</summary>
</br>
<ul>
<li><a href="https://github.com/SwifterSwift/SwifterSwift/tree/master/Sources/SwifterSwift/Shared/ColorExtensions.swift"><code>NSColor extensions</code></a></li>
<li><a href="https://github.com/SwifterSwift/SwifterSwift/tree/master/Sources/SwifterSwift/AppKit/NSViewExtensions.swift"><code>NSView extensions</code></a></li>
<li><a href="https://github.com/SwifterSwift/SwifterSwift/tree/master/Sources/SwifterSwift/AppKit/NSImageExtensions.swift"><code>NSImage extensions</code></a></li>
</ul>
</details>

<details>
<summary>CoreGraphics Extensions</summary>
</br>
<ul>
<li><a href="https://github.com/SwifterSwift/SwifterSwift/tree/master/Sources/SwifterSwift/CoreGraphics/CGColorExtensions.swift"><code>CGColor extensions</code></a></li>
<li><a href="https://github.com/SwifterSwift/SwifterSwift/tree/master/Sources/SwifterSwift/CoreGraphics/CGFloatExtensions.swift"><code>CGFloat extensions</code></a></li>
<li><a href="https://github.com/SwifterSwift/SwifterSwift/tree/master/Sources/SwifterSwift/CoreGraphics/CGPointExtensions.swift"><code>CGPoint extensions</code></a></li>
<li><a href="https://github.com/SwifterSwift/SwifterSwift/tree/master/Sources/SwifterSwift/CoreGraphics/CGSizeExtensions.swift"><code>CGSize extensions</code></a></li>
<li><a href="https://github.com/SwifterSwift/SwifterSwift/tree/master/Sources/SwifterSwift/CoreGraphics/CGVectorExtensions.swift"><code>CGVector extensions</code></a></li>
</ul>
</details>

<details>
<summary>CoreLocation Extensions</summary>
</br>
<ul>
<li><a href="https://github.com/SwifterSwift/SwifterSwift/tree/master/Sources/SwifterSwift/CoreLocation/CLLocationExtensions.swift"><code>CLLocation extensions</code></a></li>
</ul>
</details>

<details>
<summary>MapKit Extensions</summary>
</br>
<ul>
<li><a href="https://github.com/SwifterSwift/SwifterSwift/blob/master/Sources/SwifterSwift/MapKit/MKMapViewExtensions.swift"><code>MKMapView extensions</code></a></li>
<li><a href="https://github.com/SwifterSwift/SwifterSwift/blob/master/Sources/SwifterSwift/MapKit/MKPolylineExtensions.swift"><code>MKPolyline extensions</code></a></li>
</ul>
</details>

<details>
<summary>SpriteKit Extensions</summary>
</br>
<ul>
<li><a href="https://github.com/SwifterSwift/SwifterSwift/blob/master/Sources/SwifterSwift/SpriteKit/SKNodeExtensions.swift"><code>SKNode extensions</code></a></li>
</ul>
</details>

<details>
<summary>Dispatch Extensions</summary>
</br>
<ul>
<li><a href="https://github.com/SwifterSwift/SwifterSwift/blob/master/Sources/SwifterSwift/Dispatch/DispatchQueueExtensions.swift"><code>DispatchQueue extensions</code></a></li>
</ul>
</details>

## How cool is this?

SwifterSwift is a library of **over 500 properties and methods**, designed to extend Swift's functionality and productivity, staying faithful to the original Swift API design guidelines.

Check Examples.playground from the project for some cool examples!

## Documentation

Documentation for all extensions, with examples, is available at [swifterswift.com/docs](http://swifterswift.com/docs)

## Get involved

We want your feedback.
Please refer to [contributing guidelines](https://github.com/SwifterSwift/SwifterSwift/tree/master/CONTRIBUTING.md) before participating.

## Slack Channel: [![Slack](https://slackin-ppvrggbpgn.now.sh/badge.svg)](https://slackin-ppvrggbpgn.now.sh/)

It is always nice to talk with other people using SwifterSwift and exchange experiences, so come [join our Slack channel](https://slackin-ppvrggbpgn.now.sh/).

## Thanks

Special thanks to:

- [Steven Deutsch](https://github.com/SD10) and [Luciano Almeida](https://github.com/LucianoPAlmeida) for their latest contributions to extensions, docs and tests.
- [Paweł Urbanek](https://github.com/pawurb) for adding tvOS, watchOS, and macOS initial support and helping with extensions.
- [Mert Akengin](https://github.com/pvtmert) and [Bashar Ghadanfar](https://www.behance.net/lionbytes) for designing [project website](http://swifterswift.com) and logo.
- [Abdul Rahman Dabbour](https://github.com/ardabbour) for helping document the project.
- Many thanks to all other [contributors](https://github.com/SwifterSwift/SwifterSwift/graphs/contributors) of this project.

## License

SwifterSwift is released under the MIT license. See [LICENSE](https://github.com/SwifterSwift/SwifterSwift/blob/master/LICENSE) for more information.
