<p align="left">
  <img src="https://cdn.rawgit.com/SwifterSwift/SwifterSwift/master/Assets/logo.svg" title="swifterSwift">
</p>

[![Build Status](https://github.com/SwifterSwift/SwifterSwift/workflows/SwifterSwift/badge.svg?branch=master)](https://github.com/SwifterSwift/SwifterSwift/actions)
[![Platforms](https://img.shields.io/badge/platforms-iOS%20%7C%20tvOS%20%7C%20macOS%20%7C%20watchOS%20%7C%20Linux-lightgrey.svg)](https://github.com/SwifterSwift/swifterSwift)
[![Cocoapods](https://img.shields.io/cocoapods/v/SwifterSwift.svg)](https://cocoapods.org/pods/SwifterSwift)
[![Carthage compatible](https://img.shields.io/badge/Carthage-Compatible-brightgreen.svg?style=flat)](https://github.com/Carthage/Carthage)
[![SPM compatible](https://img.shields.io/badge/SPM-Compatible-brightgreen.svg?style=flat)](https://swift.org/package-manager/)
[![Accio supported](https://img.shields.io/badge/Accio-supported-0A7CF5.svg?style=flat)](https://github.com/JamitLabs/Accio)
[![codecov](https://codecov.io/gh/SwifterSwift/SwifterSwift/branch/master/graph/badge.svg)](https://codecov.io/gh/SwifterSwift/SwifterSwift)
[![docs](http://swifterswift.com/docs/badge.svg)](http://swifterswift.com/docs)
[![Swift](https://img.shields.io/badge/Swift-5.6-orange.svg)](https://swift.org)
[![Xcode](https://img.shields.io/badge/Xcode-12.4-blue.svg)](https://developer.apple.com/xcode)
[![MIT](https://img.shields.io/badge/License-MIT-red.svg)](https://opensource.org/licenses/MIT)
[![Slack Channel](https://img.shields.io/badge/Slack-SwifterSwift-green.svg)](https://join.slack.com/t/swifterswift/shared_invite/zt-s6dl4g2e-R5V5baIawGpdUz2heShjiQ)

SwifterSwift 是 **500 多个原生 Swift 扩展的集合**，为 iOS、macOS、tvOS、watchOS 和 Linux 提供了（超过 500 个）适用于各种原生数据类型、UIKit 和 Cocoa 类的便捷方法、语法糖和性能改进。

### [v6.0 有什么新功能?](https://github.com/SwifterSwift/SwifterSwift/blob/master/CHANGELOG.md#v600)

## 要求

- **iOS** 12.0+ / **tvOS** 12.0+ / **watchOS** 4.0+ / **macOS** 10.13+ / **Ubuntu** 14.04+
- Swift 5.6+

## 希望将 SwifterSwift 用于旧版本的 Swift

SwifterSwift 从 v5 开始兼容 Swift v5.0+

- 要与 **Swift 3 / Xcode 8.x** 一起使用，请确保您使用的是 [**`v3.1.1`**](https://github.com/SwifterSwift/SwifterSwift/releases/tag/3.1.1)。
- 要与 Swift 3.2 / Xcode 9.x 一起使用，请确保您使用的是 [**`v3.2.0`**](https://github.com/SwifterSwift/SwifterSwift/releases/tag/3.2.0)。

## 安装

<details>
<summary>CocoaPods</summary>
</br>
<p>要使用 <a href="http://cocoapods.org">CocoaPods</a> 将 SwifterSwift 集成到您的 Xcode 项目，请在您的 <code>Podfile</code> 中设置:</p>
<h4>- 集成所有扩展（推荐）:</h4>
<pre><code class="ruby language-ruby">pod 'SwifterSwift'</code></pre>
<h4>- 仅集成 SwiftStdlib 扩展:</h4>
<pre><code class="ruby language-ruby">pod 'SwifterSwift/SwiftStdlib'</code></pre>
<h4>- 仅集成 Foundation 扩展:</h4>
<pre><code class="ruby language-ruby">pod 'SwifterSwift/Foundation'</code></pre>
<h4>- 仅集成 UIKit 扩展:</h4>
<pre><code class="ruby language-ruby">pod 'SwifterSwift/UIKit'</code></pre>
<h4>- 仅集成 AppKit 扩展:</h4>
<pre><code class="ruby language-ruby">pod 'SwifterSwift/AppKit'</code></pre>
<h4>- 仅集成 MapKit 扩展:</h4>
<pre><code class="ruby language-ruby">pod 'SwifterSwift/MapKit'</code></pre>
<h4>- 仅集成 CoreGraphics 扩展:</h4>
<pre><code class="ruby language-ruby">pod 'SwifterSwift/CoreGraphics'</code></pre>
<h4>- 仅集成 CoreLocation 扩展:</h4>
<pre><code class="ruby language-ruby">pod 'SwifterSwift/CoreLocation'</code></pre>
<h4>- 仅集成 SpriteKit 扩展:</h4>
<pre><code class="ruby language-ruby">pod 'SwifterSwift/SpriteKit'</code></pre>
<h4>- 仅集成 SceneKit 扩展:</h4>
<pre><code class="ruby language-ruby">pod 'SwifterSwift/SceneKit'</code></pre>
<h4>- 仅集成 StoreKit 扩展:</h4>
<pre><code class="ruby language-ruby">pod 'SwifterSwift/StoreKit'</code></pre>
<h4>- 仅集成 Dispatch 扩展:</h4>
<pre><code class="ruby language-ruby">pod 'SwifterSwift/Dispatch'</code></pre>
<h4>- 仅集成 WebKit 扩展:</h4>
<pre><code class="ruby language-ruby">pod 'SwifterSwift/WebKit'</code></pre>
<h4>- 仅集成 HealthKit 扩展:</h4>
<pre><code class="ruby language-ruby">pod 'SwifterSwift/HealthKit'</code></pre>
</details>

<details>
<summary>Carthage</summary>
</br>
<p>要使用 <a href="https://github.com/Carthage/Carthage">Carthage</a> 将 SwifterSwift 集成到您的 Xcode 项目中，请在您的 <code>Cartfile</code> 中设置:</p>
<pre><code class="ogdl language-ogdl">github "SwifterSwift/SwifterSwift" ~&gt; 6.0
</code></pre>
</details>

<details>
<summary>Swift Package Manager</summary>
</br>
<p>你可以使用 <a href="https://swift.org/package-manager">The Swift Package Manager</a> 来安装 SwifterSwift，请在你的 <code>Package.swift</code> 文件中添加正确的描述:</p>
<pre><code class="swift language-swift">import PackageDescription
let package = Package(
    name: "YOUR_PROJECT_NAME",
    targets: [],
    dependencies: [
        .package(url: "https://github.com/SwifterSwift/SwifterSwift.git", from: "6.0.0")
    ]
)
</code></pre>
<p>接下来，将 <code>SwifterSwift</code> 添加到您的 targets 依赖项中，如下所示:</p>
<pre><code class="swift language-swift">.target(
    name: "YOUR_TARGET_NAME",
    dependencies: [
        "SwifterSwift",
    ]
),</code></pre>
<p>然后运行 <code>swift package update</code>。</p>
<p>请注意，<a href="https://swift.org/package-manager">Swift Package Manager</a> 不支持为 iOS/tvOS/macOS/watchOS 应用程序编译 - 请参阅下一节中的 Accio。
</details>

<details>
<summary>Accio</summary>
<p><a href="https://github.com/JamitLabs/Accio">Accio</a> 是一个基于 SwiftPM 的依赖管理器，可以为 iOS/macOS/tvOS/watchOS 构建框架。因此，集成步骤与上述完全相同。一旦你的 <code>Package.swift</code> 文件被配置，你需要运行 <code>accio update</code> 而不是 <code>swift package update</code>。</p>
</details>

<details>
<summary>手动</summary>
</br>
<p>将 <a href="https://github.com/SwifterSwift/SwifterSwift/tree/master/Sources/SwifterSwift">SwifterSwift</a> 文件夹添加到您的 Xcode 项目以使用所有扩展或特定扩展。</p>
<p>对于您的 test targets，您还可以添加 <a href="https://github.com/SwifterSwift/SwifterSwift/tree/master/Tests/XCTest">XCTest</a> 文件夹。</p>
</details>

## 所有扩展列表

<details>
<summary>SwiftStdlib 扩展</summary>
</br>
<ul>
<li><a href="https://github.com/SwifterSwift/SwifterSwift/tree/master/Sources/SwifterSwift/SwiftStdlib/ArrayExtensions.swift"><code>Array extensions</code></a></li>
<li><a href="https://github.com/SwifterSwift/SwifterSwift/tree/master/Sources/SwifterSwift/SwiftStdlib/BidirectionalCollectionExtensions.swift"><code>BidirectionalCollection extensions</code></a></li>
<li><a href="https://github.com/SwifterSwift/SwifterSwift/tree/master/Sources/SwifterSwift/SwiftStdlib/BinaryFloatingPointExtensions.swift"><code>BinaryFloatingPoint extensions</code></a></li>
<li><a href="https://github.com/SwifterSwift/SwifterSwift/tree/master/Sources/SwifterSwift/SwiftStdlib/BoolExtensions.swift"><code>Bool extensions</code></a></li>
<li><a href="https://github.com/SwifterSwift/SwifterSwift/tree/master/Sources/SwifterSwift/SwiftStdlib/CharacterExtensions.swift"><code>Character extensions</code></a></li>
<li><a href="https://github.com/SwifterSwift/SwifterSwift/tree/master/Sources/SwifterSwift/SwiftStdlib/CollectionExtensions.swift"><code>Collection extensions</code></a></li>
<li><a href="https://github.com/SwifterSwift/SwifterSwift/tree/master/Sources/SwifterSwift/SwiftStdlib/ComparableExtensions.swift"><code>Comparable extensions</code></a></li>
<li><a href="https://github.com/SwifterSwift/SwifterSwift/tree/master/Sources/SwifterSwift/SwiftStdlib/DecodableExtensions.swift"><code>DecodableExtensions extensions</code></a></li>
<li><a href="https://github.com/SwifterSwift/SwifterSwift/tree/master/Sources/SwifterSwift/SwiftStdlib/DefaultStringInterpolationExtensions.swift"><code>DefaultStringInterpolationExtensions extensions</code></a></li>
<li><a href="https://github.com/SwifterSwift/SwifterSwift/tree/master/Sources/SwifterSwift/SwiftStdlib/DictionaryExtensions.swift"><code>Dictionary extensions</code></a></li>
<li><a href="https://github.com/SwifterSwift/SwifterSwift/tree/master/Sources/SwifterSwift/SwiftStdlib/DoubleExtensions.swift"><code>Double extensions</code></a></li>
<li><a href="https://github.com/SwifterSwift/SwifterSwift/tree/master/Sources/SwifterSwift/SwiftStdlib/FloatExtensions.swift"><code>Float extensions</code></a></li>
<li><a href="https://github.com/SwifterSwift/SwifterSwift/tree/master/Sources/SwifterSwift/SwiftStdlib/FloatingPointExtensions.swift"><code>FloatingPoint extensions</code></a></li>
<li><a href="https://github.com/SwifterSwift/SwifterSwift/tree/master/Sources/SwifterSwift/SwiftStdlib/IntExtensions.swift"><code>Int extensions</code></a></li>
<li><a href="https://github.com/SwifterSwift/SwifterSwift/tree/master/Sources/SwifterSwift/SwiftStdlib/OptionalExtensions.swift"><code>Optional extensions</code></a></li>
<li><a href="https://github.com/SwifterSwift/SwifterSwift/blob/master/Sources/SwifterSwift/SwiftStdlib/RangeReplaceableCollectionExtensions.swift"><code>RangeReplaceableCollection extensions</code></a></li>
<li><a href="https://github.com/SwifterSwift/SwifterSwift/tree/master/Sources/SwifterSwift/SwiftStdlib/SequenceExtensions.swift"><code>Sequence extensions</code></a></li>
<li><a href="https://github.com/SwifterSwift/SwifterSwift/tree/master/Sources/SwifterSwift/SwiftStdlib/SignedIntegerExtensions.swift"><code>SignedInteger extensions</code></a></li>
<li><a href="https://github.com/SwifterSwift/SwifterSwift/tree/master/Sources/SwifterSwift/SwiftStdlib/SignedNumericExtensions.swift"><code>SignedNumeric extensions</code></a></li>
<li><a href="https://github.com/SwifterSwift/SwifterSwift/tree/master/Sources/SwifterSwift/SwiftStdlib/StringExtensions.swift"><code>String extensions</code></a></li>
<li><a href="https://github.com/SwifterSwift/SwifterSwift/blob/master/Sources/SwifterSwift/SwiftStdlib/StringProtocolExtensions.swift"><code>StringProtocol extensions</code></a></li>
</ul>
</details>

<details>
<summary>Foundation 扩展</summary>
</br>
<ul>
<li><a href="https://github.com/SwifterSwift/SwifterSwift/tree/master/Sources/SwifterSwift/Foundation/CalendarExtensions.swift"><code>Calendar extensions</code></a></li>
<li><a href="https://github.com/SwifterSwift/SwifterSwift/tree/master/Sources/SwifterSwift/Foundation/DataExtensions.swift"><code>Data extensions</code></a></li>
<li><a href="https://github.com/SwifterSwift/SwifterSwift/tree/master/Sources/SwifterSwift/Foundation/DateExtensions.swift"><code>Date extensions</code></a></li>
<li><a href="https://github.com/SwifterSwift/SwifterSwift/blob/master/Sources/SwifterSwift/Foundation/FileManagerExtensions.swift"><code>FileManager extensions</code></a></li>
<li><a href="https://github.com/SwifterSwift/SwifterSwift/tree/master/Sources/SwifterSwift/Foundation/LocaleExtensions.swift"><code>Locale extensions</code></a></li>
<li><a href="https://github.com/SwifterSwift/SwifterSwift/tree/master/Sources/SwifterSwift/Foundation/MeasurementExtensions.swift"><code>Measurement extensions</code></a></li>
<li><a href="https://github.com/SwifterSwift/SwifterSwift/tree/master/Sources/SwifterSwift/Foundation/NSAttributedStringExtensions.swift"><code>NSAttributedString extensions</code></a></li>
<li><a href="https://github.com/SwifterSwift/SwifterSwift/tree/master/Sources/SwifterSwift/Foundation/NSPredicateExtensions.swift"><code>NSPredicate extensions</code></a></li>
<li><a href="https://github.com/SwifterSwift/SwifterSwift/tree/master/Sources/SwifterSwift/Foundation/URLExtensions.swift"><code>URL extensions</code></a></li>
<li><a href="https://github.com/SwifterSwift/SwifterSwift/tree/master/Sources/SwifterSwift/Foundation/URLRequestExtensions.swift"><code>URLRequest extensions</code></a></li>
<li><a href="https://github.com/SwifterSwift/SwifterSwift/tree/master/Sources/SwifterSwift/Foundation/URLSessionExtensions.swift"><code>URLSession extensions</code></a></li>
<li><a href="https://github.com/SwifterSwift/SwifterSwift/tree/master/Sources/SwifterSwift/Foundation/UserDefaultsExtensions.swift"><code>UserDefaults extensions</code></a></li>
</ul>
</details>

<details>
<summary>UIKit 扩展</summary>
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
<li><a href="https://github.com/SwifterSwift/SwifterSwift/tree/master/Sources/SwifterSwift/Shared/EdgeInsetsExtensions.swift"><code>UIEdgeInsets extensions</code></a></li>
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
<summary>AppKit 扩展</summary>
</br>
<ul>
<li><a href="https://github.com/SwifterSwift/SwifterSwift/tree/master/Sources/SwifterSwift/Shared/NSColorExtensions.swift"><code>NSColor extensions</code></a></li>
<li><a href="https://github.com/SwifterSwift/SwifterSwift/tree/master/Sources/SwifterSwift/AppKit/NSImageExtensions.swift"><code>NSImage extensions</code></a></li>
<li><a href="https://github.com/SwifterSwift/SwifterSwift/tree/master/Sources/SwifterSwift/AppKit/NSStackViewExtensions.swift"><code>NSStackView extensions</code></a></li>
<li><a href="https://github.com/SwifterSwift/SwifterSwift/tree/master/Sources/SwifterSwift/AppKit/NSViewExtensions.swift"><code>NSView extensions</code></a></li>
</ul>
</details>

<details>
<summary>CoreGraphics 扩展</summary>
</br>
<ul>
<li><a href="https://github.com/SwifterSwift/SwifterSwift/tree/master/Sources/SwifterSwift/CoreGraphics/CGColorExtensions.swift"><code>CGColor extensions</code></a></li>
<li><a href="https://github.com/SwifterSwift/SwifterSwift/tree/master/Sources/SwifterSwift/CoreGraphics/CGFloatExtensions.swift"><code>CGFloat extensions</code></a></li>
<li><a href="https://github.com/SwifterSwift/SwifterSwift/tree/master/Sources/SwifterSwift/CoreGraphics/CGPointExtensions.swift"><code>CGPoint extensions</code></a></li>
<li><a href="https://github.com/SwifterSwift/SwifterSwift/tree/master/Sources/SwifterSwift/CoreGraphics/CGSizeExtensions.swift"><code>CGSize extensions</code></a></li>
<li><a href="https://github.com/SwifterSwift/SwifterSwift/tree/master/Sources/SwifterSwift/CoreGraphics/CGRectExtensions.swift"><code>CGRect extensions</code></a></li>
<li><a href="https://github.com/SwifterSwift/SwifterSwift/tree/master/Sources/SwifterSwift/CoreGraphics/CGVectorExtensions.swift"><code>CGVector extensions</code></a></li>
</ul>
</details>

<details>
<summary>CoreLocation 扩展</summary>
</br>
<ul>
<li><a href="https://github.com/SwifterSwift/SwifterSwift/tree/master/Sources/SwifterSwift/CoreLocation/CLLocationExtensions.swift"><code>CLLocation extensions</code></a></li>
<li><a href="https://github.com/SwifterSwift/SwifterSwift/tree/master/Sources/SwifterSwift/CoreLocation/CLVisitExtensions.swift"><code>CLVisit extensions</code></a></li>
</ul>
</details>

<details>
<summary>CoreAnimation 扩展</summary>
</br>
<ul>
<li><a href="https://github.com/SwifterSwift/SwifterSwift/tree/master/Sources/SwifterSwift/CoreAnimation/CAGradientLayerExtensions.swift"><code>CAGradientLayer extensions</code></a></li>
</ul>
</details>

<details>
<summary>MapKit 扩展</summary>
</br>
<ul>
<li><a href="https://github.com/SwifterSwift/SwifterSwift/blob/master/Sources/SwifterSwift/MapKit/MKMapViewExtensions.swift"><code>MKMapView extensions</code></a></li>
<li><a href="https://github.com/SwifterSwift/SwifterSwift/blob/master/Sources/SwifterSwift/MapKit/MKPolylineExtensions.swift"><code>MKPolyline extensions</code></a></li>
</ul>
</details>

<details>
<summary>SpriteKit 扩展</summary>
</br>
<ul>
<li><a href="https://github.com/SwifterSwift/SwifterSwift/blob/master/Sources/SwifterSwift/SpriteKit/SKNodeExtensions.swift"><code>SKNode extensions</code></a></li>
</ul>
</details>

<details>
<summary>SceneKit 扩展</summary>
</br>
<ul>
<li><a href="https://github.com/SwifterSwift/SwifterSwift/blob/master/Sources/SwifterSwift/SceneKit/SCNBoxExtensions.swift"><code>SCNBox extensions</code></a></li>
<li><a href="https://github.com/SwifterSwift/SwifterSwift/blob/master/Sources/SwifterSwift/SceneKit/SCNCone.swift"><code>SCNCone extensions</code></a></li>
<li><a href="https://github.com/SwifterSwift/SwifterSwift/blob/master/Sources/SwifterSwift/SceneKit/SCNCapsule.swift"><code>SCNCapsule extensions</code></a></li>
<li><a href="https://github.com/SwifterSwift/SwifterSwift/blob/master/Sources/SwifterSwift/SceneKit/SCNCylinderExtensions.swift"><code>SCNCylinder extensions</code></a></li>
<li><a href="https://github.com/SwifterSwift/SwifterSwift/blob/master/Sources/SwifterSwift/SceneKit/SCNGeometryExtensions.swift"><code>SCNGeometry extensions</code></a></li>
<li><a href="https://github.com/SwifterSwift/SwifterSwift/blob/master/Sources/SwifterSwift/SceneKit/SCNMaterialExtensions.swift"><code>SCNMaterial extensions</code></a></li>
<li><a href="https://github.com/SwifterSwift/SwifterSwift/blob/master/Sources/SwifterSwift/SceneKit/SCNPlaneExtensions.swift"><code>SCNPlane extensions</code></a></li>
<li><a href="https://github.com/SwifterSwift/SwifterSwift/blob/master/Sources/SwifterSwift/SceneKit/SCNShape.swift"><code>SCNShape extensions</code></a></li>
<li><a href="https://github.com/SwifterSwift/SwifterSwift/blob/master/Sources/SwifterSwift/SceneKit/SCNSphereExtensions.swift"><code>SCNSphere extensions</code></a></li>
<li><a href="https://github.com/SwifterSwift/SwifterSwift/blob/master/Sources/SwifterSwift/SceneKit/SCNVector3Extensions.swift"><code>SCNVector3 extensions</code></a></li>
</ul>
</details>

<details>
<summary>StoreKit 扩展</summary>
</br>
<ul>
<li><a href="https://github.com/SwifterSwift/SwifterSwift/blob/master/Sources/SwifterSwift/StoreKit/SKProductExtensions.swift"><code>SKProduct extensions</code></a></li>
</ul>
</details>

<details>
<summary>Dispatch 扩展</summary>
</br>
<ul>
<li><a href="https://github.com/SwifterSwift/SwifterSwift/blob/master/Sources/SwifterSwift/Dispatch/DispatchQueueExtensions.swift"><code>DispatchQueue extensions</code></a></li>
</ul>
</details>

<details>
<summary>WebKit 扩展</summary>
</br>
<ul>
<li><a href="https://github.com/SwifterSwift/SwifterSwift/blob/master/Sources/SwifterSwift/WebKit/WKWebViewExtensions.swift"><code>WKWebView extensions</code></a></li>
</ul>
</details>

<details>
<summary>HealthKit 扩展</summary>
</br>
<ul>
<li><a href="https://github.com/SwifterSwift/SwifterSwift/blob/master/Sources/SwifterSwift/HealthKit/HKActivitySummaryExtensions.swift"><code>HKActivitySummary extensions</code></a></li>
</ul>
</details>

<details>
<summary>XCTest 扩展</summary>
</br>
<ul>
<li><a href="https://github.com/SwifterSwift/SwifterSwift/blob/master/Tests/XCTest/XCTestExtensions.swift"><code>XCTest extensions</code></a></li>
</ul>
</details>

<details>
<summary>Combine 扩展</summary>
</br>
<ul>
<li><a href="https://github.com/SwifterSwift/SwifterSwift/blob/master/Sources/SwifterSwift/Combine/FutureExtensions.swift"><code>Future extensions</code></a></li>
</ul>
</details>

## 这有多酷？

SwifterSwift 是一个包含 **500 多个属性和方法**的库，旨在扩展 Swift 的功能和生产力，并忠实于原生的 Swift API 设计指南。

查看项目中的 Examples.playground 以获取一些很酷的示例！

## 文档

所有扩展的文档和示例都在 [swifterswift.com/docs](http://swifterswift.com/docs)

## 参与其中

我们希望得到您的反馈。参与前请参阅 [contributing guidelines](https://github.com/SwifterSwift/SwifterSwift/tree/master/CONTRIBUTING.md)。

## Slack 频道: [![Slack](https://img.shields.io/badge/Slack-SwifterSwift-green.svg)](https://swifterswift.slack.com)

使用 SwifterSwift 与其他人交谈并交流经验总是很愉快，所以[加入我们的 Slack 频道](https://swifterswift.slack.com)吧。

## 鸣谢

特别感谢：

- [Steven Deutsch](https://github.com/SD10), [Luciano Almeida](https://github.com/LucianoPAlmeida) 和 [Guy Kogus](https://github.com/guykogus) 对扩展、文档和测试的最新贡献。
- [Paweł Urbanek](https://github.com/pawurb) 添加了 tvOS、watchOS 和 macOS 的初始化支持和帮助扩展。
- [Mert Akengin](https://github.com/pvtmert) 和 [Bashar Ghadanfar](https://www.behance.net/lionbytes) 设计了 [project website](http://swifterswift.com) 和 logo.
- 非常感谢这个项目的所有其他[贡献者](https://github.com/SwifterSwift/SwifterSwift/graphs/contributors)。

## License 协议

SwifterSwift 在 MIT 许可协议下发布的。有关更多信息，请参阅 [LICENSE](https://github.com/SwifterSwift/SwifterSwift/blob/master/LICENSE)。
