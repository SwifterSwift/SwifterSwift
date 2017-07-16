<p align="left">
  <img src="https://raw.githubusercontent.com/SwifterSwift/SwifterSwift/master/Assets/logo.png" title="swifterSwift">
</p>

[![Build Status](https://api.travis-ci.org/SwifterSwift/SwifterSwift.svg?branch=master)](https://travis-ci.org/SwifterSwift/SwifterSwift)
[![Cocoapods](https://img.shields.io/cocoapods/v/SwifterSwift.svg)](https://cocoapods.org/pods/SwifterSwift)
[![Carthage compatible](https://img.shields.io/badge/Carthage-Compatible-brightgreen.svg?style=flat)](https://github.com/Carthage/Carthage)
[![codecov](https://codecov.io/gh/SwifterSwift/SwifterSwift/branch/master/graph/badge.svg)](https://codecov.io/gh/SwifterSwift/SwifterSwift)
[![docs](http://swifterswift.com/docs/badge.svg)](http://swifterswift.com/docs)
[![CocoaPods](https://img.shields.io/cocoapods/dt/SwifterSwift.svg)](https://cocoapods.org/pods/SwifterSwift)
[![CocoaPods](https://img.shields.io/cocoapods/dm/SwifterSwift.svg)](https://cocoapods.org/pods/SwifterSwift)
[![Platform](https://img.shields.io/cocoapods/p/SwifterSwift.svg?style=flat)](https://github.com/SwifterSwift/swifterSwift)
[![Swift](https://img.shields.io/badge/Swift-3.2-orange.svg)](https://swift.org)
[![Xcode](https://img.shields.io/badge/Xcode-8.3-blue.svg)](https://developer.apple.com/xcode)
[![MIT](https://img.shields.io/badge/License-MIT-red.svg)](https://opensource.org/licenses/MIT)
[![Slack Channel](http://slack.swifterswift.com/badge.svg)](http://slack.swifterswift.com/)


SwifterSwift is a collection of **over 500 native Swift 3 extensions**, with handy methods, syntactic sugar, and performance improvements for wide range of primitive data types, UIKit and Cocoa classes –over 500 in 1– for iOS, macOS, tvOS and watchOS.


### [Whats New in v3?](https://github.com/SwifterSwift/SwifterSwift/blob/master/CHANGELOG.md#v300)



## Requirements:
- **iOS** 8.0+ / **tvOS** 9.0+ / **watchOS** 2.0+ / **macOS** 10.10+
- Xcode 8.0+
- Swift 3.0+



## Installation

<details>
<summary>CocoaPods</summary>
</br>

<p><a href="http://cocoapods.org">CocoaPods</a> is a dependency manager for Cocoa projects. You can install it with the following command:</p>

<pre><code class="bash language-bash">$ gem install cocoapods
</code></pre>

<p>To integrate SwifterSwift into your Xcode project using CocoaPods, specify it in your <code>Podfile</code>:</p>

<h3 id="1integrateallextensions">1. Integrate All extensions:</h3>

<pre><code class="ruby language-ruby">source 'https://github.com/CocoaPods/Specs.git'
platform :ios, '8.0'
use_frameworks!

target '&lt;Your Target Name&gt;' do
    pod 'SwifterSwift'
end
</code></pre>

<h3 id="2integratefoundationextensionsonly">2. Integrate Foundation extensions only:</h3>

<pre><code class="ruby language-ruby">source 'https://github.com/CocoaPods/Specs.git'
platform :ios, '8.0'
use_frameworks!

target '&lt;Your Target Name&gt;' do
    pod 'SwifterSwift/Foundation'
end
</code></pre>

<h3 id="3integrateuikitextensionsonly">3. Integrate UIKit extensions only:</h3>

<pre><code class="ruby language-ruby">source 'https://github.com/CocoaPods/Specs.git'
platform :ios, '8.0'
use_frameworks!

target '&lt;Your Target Name&gt;' do
    pod 'SwifterSwift/UIKit'
end
</code></pre>

<h3 id="4integratecocoaextensionsonly">4. Integrate Cocoa extensions only:</h3>

<pre><code class="ruby language-ruby">source 'https://github.com/CocoaPods/Specs.git'
platform :ios, '8.0'
use_frameworks!

target '&lt;Your Target Name&gt;' do
    pod 'SwifterSwift/Cocoa'
end
</code></pre>

<p>Then, run the following command:</p>

<pre><code class="bash language-bash">$ pod install
</code></pre>

</details>


<details>
<summary>Carthage</summary>
</br>

<p><a href="https://github.com/Carthage/Carthage">Carthage</a> is a decentralized dependency manager that builds your dependencies and provides you with binary frameworks.</p>

<p>You can install Carthage with <a href="http://brew.sh/">Homebrew</a> using the following command:</p>

<pre><code class="bash language-bash">$ brew update
$ brew install carthage
</code></pre>

<p>To integrate SwifterSwift into your Xcode project using Carthage, specify it in your <code>Cartfile</code>:</p>

<pre><code class="ogdl language-ogdl">github "SwifterSwift/SwifterSwift" ~&gt; 3.0
</code></pre>

<p>Run <code>carthage update</code> to build the framework and drag the built <code>SwifterSwift.framework</code> into your Xcode project.</p>

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
        .Package(url: "https://github.com/SwifterSwift/SwifterSwift.git", majorVersion: 3),
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
<summary>Foundation Extensions</summary>
</br>

<ul>
<li><a href="https://github.com/SwifterSwift/SwifterSwift/tree/master/Sources/Extensions/Foundation/ArrayExtensions.swift"><code>Array extensions</code></a></li>

<li><a href="https://github.com/SwifterSwift/SwifterSwift/tree/master/Sources/Extensions/Foundation/BoolExtensions.swift"><code>Bool extensions</code></a></li>

<li><a href="https://github.com/SwifterSwift/SwifterSwift/tree/master/Sources/Extensions/Foundation/CharacterExtensions.swift"><code>Character extensions</code></a></li>

<li><a href="https://github.com/SwifterSwift/SwifterSwift/tree/master/Sources/Extensions/Foundation/CollectionExtensions.swift"><code>Collection extensions</code></a></li>

<li><a href="https://github.com/SwifterSwift/SwifterSwift/tree/master/Sources/Extensions/Foundation/DataExtensions.swift"><code>Data extensions</code></a></li>

<li><a href="https://github.com/SwifterSwift/SwifterSwift/tree/master/Sources/Extensions/Foundation/DateExtensions.swift"><code>Date extensions</code></a></li>

<li><a href="https://github.com/SwifterSwift/SwifterSwift/tree/master/Sources/Extensions/Foundation/DictionaryExtensions.swift"><code>Dictionary extensions</code></a></li>

<li><a href="https://github.com/SwifterSwift/SwifterSwift/tree/master/Sources/Extensions/Foundation/DoubleExtensions.swift"><code>Double extensions</code></a></li>

<li><a href="https://github.com/SwifterSwift/SwifterSwift/tree/master/Sources/Extensions/Foundation/FloatExtensions.swift"><code>Float extensions</code></a></li>

<li><a href="https://github.com/SwifterSwift/SwifterSwift/tree/master/Sources/Extensions/Foundation/IntExtensions.swift"><code>Int extensions</code></a></li>

<li><a href="https://github.com/SwifterSwift/SwifterSwift/tree/master/Sources/Extensions/Foundation/LocaleExtensions.swift"><code>Locale extensions</code></a></li>

<li><a href="https://github.com/SwifterSwift/SwifterSwift/tree/master/Sources/Extensions/Foundation/OptionalExtensions.swift"><code>Optional extensions</code></a></li>

<li><a href="https://github.com/SwifterSwift/SwifterSwift/tree/master/Sources/Extensions/Foundation/StringExtensions.swift"><code>String extensions</code></a></li>

<li><a href="https://github.com/SwifterSwift/SwifterSwift/tree/master/Sources/Extensions/Foundation/URLExtensions.swift"><code>URL extensions</code></a></li>
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

<li><a href="https://github.com/SwifterSwift/SwifterSwift/tree/master/Sources/Extensions/UIKit/UIColorExtensions.swift"><code>UIColor extensions</code></a></li>

<li><a href="https://github.com/SwifterSwift/SwifterSwift/tree/master/Sources/Extensions/UIKit/UIImageExtensions.swift"><code>UIImage extensions</code></a></li>

<li><a href="https://github.com/SwifterSwift/SwifterSwift/tree/master/Sources/Extensions/UIKit/UIImageViewExtensions.swift"><code>UIImageView extensions</code></a></li>

<li><a href="https://github.com/SwifterSwift/SwifterSwift/tree/master/Sources/Extensions/UIKit/UILabelExtensions.swift"><code>UILabel extensions</code></a></li>

<li><a href="https://github.com/SwifterSwift/SwifterSwift/tree/master/Sources/Extensions/UIKit/UINavigationBarExtensions.swift"><code>UINavigationBar extensions</code></a></li>

<li><a href="https://github.com/SwifterSwift/SwifterSwift/tree/master/Sources/Extensions/UIKit/UINavigationControllerExtensions.swift"><code>UINavigationController extensions</code></a></li>

<li><a href="https://github.com/SwifterSwift/SwifterSwift/tree/master/Sources/Extensions/UIKit/UINavigationItemExtensions.swift"><code>UINavigationItem extensions</code></a></li>

<li><a href="https://github.com/SwifterSwift/SwifterSwift/tree/master/Sources/Extensions/UIKit/UISearchBarExtensions.swift"><code>UISearchBar extensions</code></a></li>

<li><a href="https://github.com/SwifterSwift/SwifterSwift/tree/master/Sources/Extensions/UIKit/UISegmentedControlExtensions.swift"><code>UISegmentedControl extensions</code></a></li>

<li><a href="https://github.com/SwifterSwift/SwifterSwift/tree/master/Sources/Extensions/UIKit/UISliderExtensions.swift"><code>UISlider extensions</code></a></li>

<li><a href="https://github.com/SwifterSwift/SwifterSwift/tree/master/Sources/Extensions/UIKit/UIStoryboardExtensions.swift"><code>UIStoryboard extensions</code></a></li>

<li><a href="https://github.com/SwifterSwift/SwifterSwift/tree/master/Sources/Extensions/UIKit/UISwitchExtensions.swift"><code>UISwitch extensions</code></a></li>

<li><a href="https://github.com/SwifterSwift/SwifterSwift/tree/master/Sources/Extensions/UIKit/UITabBarExtensions.swift"><code>UITabBar extensions</code></a></li>

<li><a href="https://github.com/SwifterSwift/SwifterSwift/tree/master/Sources/Extensions/UIKit/UITableViewExtensions.swift"><code>UITableView extensions</code></a></li>

<li><a href="https://github.com/SwifterSwift/SwifterSwift/tree/master/Sources/Extensions/UIKit/UITextFieldExtensions.swift"><code>UITextField extensions</code></a></li>

<li><a href="https://github.com/SwifterSwift/SwifterSwift/tree/master/Sources/Extensions/UIKit/UITextViewExtensions.swift"><code>UITextView extensions</code></a></li>

<li><a href="https://github.com/SwifterSwift/SwifterSwift/tree/master/Sources/Extensions/UIKit/UIViewExtensions.swift"><code>UIView extensions</code></a></li>

<li><a href="https://github.com/SwifterSwift/SwifterSwift/tree/master/Sources/Extensions/UIKit/UIViewControllerExtensions.swift"><code>UIViewController extensions</code></a></li>
</ul>

</details>


<details>
<summary>Cocoa Extensions</summary>
</br>

<ul>
<li><a href="https://github.com/SwifterSwift/SwifterSwift/tree/master/Sources/Extensions/Cocoa/CGColorExtensions.swift"><code>CGColor extensions</code></a></li>

<li><a href="https://github.com/SwifterSwift/SwifterSwift/tree/master/Sources/Extensions/Cocoa/CGFloatExtensions.swift"><code>CGFloat extensions</code></a></li>

<li><a href="https://github.com/SwifterSwift/SwifterSwift/tree/master/Sources/Extensions/Cocoa/CGPointExtensions.swift"><code>CGPoint extensions</code></a></li>

<li><a href="https://github.com/SwifterSwift/SwifterSwift/tree/master/Sources/Extensions/Cocoa/CGSizeExtensions.swift"><code>CGSize extensions</code></a></li>

<li><a href="https://github.com/SwifterSwift/SwifterSwift/tree/master/Sources/Extensions/Cocoa/CLLocationExtensions.swift"><code>CLLocation extensions</code></a></li>

<li><a href="https://github.com/SwifterSwift/SwifterSwift/tree/master/Sources/Extensions/Cocoa/NSAttributedStringExtensions.swift"><code>NSAttributedString extensions</code></a></li>

<li><a href="https://github.com/SwifterSwift/SwifterSwift/tree/master/Sources/Extensions/Cocoa/NSColorExtensions.swift"><code>NSColor extensions</code></a></li>

<li><a href="https://github.com/SwifterSwift/SwifterSwift/tree/master/Sources/Extensions/Cocoa/NSViewExtensions.swift"><code>NSView extensions</code></a></li>
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

SwifterSwift is a library of **over 500 properties and methods**, designed to extend Swift's functionality and productivity, staying faithful to the original API design guidelines of Swift 3.

Check [Examples.md](https://github.com/SwifterSwift/SwifterSwift/tree/master/Examples/Examples.md) for some cool examples!


## Documentation

A complete documentation for all extensions with examples is available at [swifterswift.com/docs](http://swifterswift.com/docs)



## Get involved:

Your feedback is always appreciated and welcomed.
Please refer to [contributing guidelines](https://github.com/SwifterSwift/SwifterSwift/tree/master/CONTRIBUTING.md) before participating.



## Slack Channel: [![Slack](http://slack.swifterswift.com/badge.svg)](http://slack.swifterswift.com/)

It is always nice to talk with other people using SwifterSwift and exchange experiences, [Join Channel](http://slack.swifterswift.com/)



## Thanks:

Special thanks to:

- [Steven Deutsch](https://github.com/SD10) and [Luciano Almeida](https://github.com/LucianoPAlmeida) for their latest contributions to extensions, docs and tests.
- [Paweł Urbanek](https://github.com/pawurb) for adding tvOS, watchOS and macOS initial support and helping with extensions.
- [Mert Akengin](https://github.com/PvtMert) and [Bashar Ghadanfar](https://www.behance.net/lionbytes) for designing [project website](http://swiftierswift.com) and logo.
- [Abdul Rahman Dabbour](https://github.com/thedabbour) for helping document the project.
