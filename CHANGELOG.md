# CHANGELOG
The changelog for **SwifterSwift**. Also see the [releases](https://github.com/SwifterSwift/SwifterSwift/releases) on GitHub.

# Upcoming release

### Added
- **SKNode**:
  - Added `descendants` method to get an array of all descendants of an SKNode. [#490](https://github.com/SwifterSwift/SwifterSwift/pull/490) by [oliviabrown9](https://github.com/oliviabrown9).
- **Comparable**:
  - Added `isBetween(min:max:)` and `clamped(min:max:)` to confirm a value is between bounds or limit it between bounds. [#466](https://github.com/SwifterSwift/SwifterSwift/pull/466) by [freak4pc](https://github.com/freak4pc).
- **UIScrollView**:
  - Added `snapshot` method to get a full snapshot of a rendered scroll view. [#457](https://github.com/SwifterSwift/SwifterSwift/pull/457) by [aliamcami](https://github.com/aliamcami).
- **UIGestureRecognizer**:
  - Added `removeFromView()` method to remove recognizer from the view the recognizer is attached to. [#456](https://github.com/SwifterSwift/SwifterSwift/pull/456) by [mmdock](https://github.com/mmdock)
- **Character**:
  - Added `randomAlphanumeric()` method to generate a random alphanumeric Character. [#462](https://github.com/SwifterSwift/SwifterSwift/pull/462) by [oliviabrown9](https://github.com/oliviabrown9)
- **UITextView**:
  - Added `wrapToContent()` method which will remove insets, offsets, paddings which lies within UITextView's `bounds` and `contenSize`. [#458](https://github.com/SwifterSwift/SwifterSwift/pull/458) by [ratulSharker](https://github.com/ratulSharker)
- **URL**
  - Added `deletingAllPathComponents()` and `deleteAllPathComponents()` to delete all path components from a URL. [#441](https://github.com/SwifterSwift/SwifterSwift/pull/441) by [setoelkahfi](https://github.com/setoelkahfi).
  - Added `queryValue(for:)` to get the value of a query key from a URL. [#467](https://github.com/SwifterSwift/SwifterSwift/pull/467) by [jdisho](https://github.com/jdisho).
- **UITableView**:
  - Added `isValidIndexPath(_:)` method to check whether given IndexPath is valid within UITableView. [#441](https://github.com/SwifterSwift/SwifterSwift/pull/441) by [setoelkahfi](https://github.com/setoelkahfi).
  - Added `safeScrollToRow(at:at:animated:)` method to safely scroll UITableView to the given IndexPath. [#445](https://github.com/SwifterSwift/SwifterSwift/pull/445) by [setoelkahfi](https://github.com/setoelkahfi).
- **Optional**:
  - Added `isNilOrEmpty` property to check whether an optional is nil or empty collection.
- **UIWindow**:
  - Added `switchRootViewController` method to switch root view controller with animation. [#494](https://github.com/SwifterSwift/SwifterSwift/pull/494) by [omaralbeik](https://github.com/omaralbeik).
- **Sequence**
  - Added `containsDuplicates()` to check whether a sequence contains duplicates. [#496](https://github.com/SwifterSwift/SwifterSwift/pull/496) by [@vyax](https://github.com/vyax).
  - Added `single(where:)` to get the only element of a sequence that matches a given condition. [#483](https://github.com/SwifterSwift/SwifterSwift/pull/483) by [andlang](https://github.com/andlang).
- **UIStackView**:
  - Added `addArrangedSubviews(_ views: )` to add an array of views to the end of the arrangedSubviews array. [#501](https://github.com/SwifterSwift/SwifterSwift/pull/501) by [omaralbeik](https://github.com/omaralbeik).
  - Added `removeArrangedSubviews` to remove all views in stack’s array of arranged subviews. [#501](https://github.com/SwifterSwift/SwifterSwift/pull/501) by [omaralbeik](https://github.com/omaralbeik).
- **UIEdgeInsets**
  - Added `horizontal` and `vertical` properties. Also `init(inset:)` and `init(horizontal: vertical:)` initializers for convenience. [#500](https://github.com/SwifterSwift/SwifterSwift/pull/500) by [LucianoPAlmeida](https://github.com/LucianoPAlmeida).

### Changed
- **UITableView**:
  - `dequeueReusableCell(withClass:for)`, `dequeueReusableCell(withClass)` now return `UITableViewCell` object, `fatalError(...)` if not found. [#439](https://github.com/SwifterSwift/SwifterSwift/pull/439) by [jdisho](https://github.com/jdisho)
  - `dequeueReusableHeaderFooterView(withClass)`now returns `UITableViewHeaderFooterView` object, `fatalError(...)` if not found. [#439](https://github.com/SwifterSwift/SwifterSwift/pull/439) by [jdisho](https://github.com/jdisho)
- **UICollectionView**:
  - `dequeueReusableCell(withClass:for)` now returns `UICollectionViewCell` object, `fatalError(...)` if not found. [#439](https://github.com/SwifterSwift/SwifterSwift/pull/439) by [jdisho](https://github.com/jdisho)
  - `dequeueReusableSupplementaryView(ofKind:withClass:for)`now returns `UICollectionReusableView` object, `fatalError(...)` if not found. [#439](https://github.com/SwifterSwift/SwifterSwift/pull/439) by [jdisho](https://github.com/jdisho)
- **UIView**:
  - **Breaking Change** `firstResponder` UIView extension is now a function and supports recursive find in the view hierarchy. [#447](https://github.com/SwifterSwift/SwifterSwift/pull/447) by [LucianoPAlmeida](https://github.com/LucianoPAlmeida).
- **UIImage**:
  - `scaled(toWidth:, opaque:, with orientation:)` and `scaled(toHeight:, opaque:, with orientation:)` now have an optional parameter for opaqueness. [#446](https://github.com/SwifterSwift/SwifterSwift/pull/446) by [vyax](https://github.com/vyax)
- **Array/Collection/Sequence**
  - The conformance of `sum()`, `last(where:)`, `reject(where:)`, `count(where:)`, `forEachReversed()`, `forEach(where:, body:)`, `accumulate(initial:, next:)`, `filtered(_:, map:)` and `contains(_:)` has been changed from Array to Sequence [#470](https://github.com/SwifterSwift/SwifterSwift/pull/470) by [vyax](https://github.com/vyax)
  - The conformance of `average()`, `firstIndex(where:)`, `lastIndex(where:)`, `indices(where:)`, `forEach(slice:, body:)`, `group(by:)`, `firstIndex(of:)` and `lastIndex(of:)` has been changed from Array to Collection [#470](https://github.com/SwifterSwift/SwifterSwift/pull/470) by [vyax](https://github.com/vyax)
- **Dictionary**
  - The `removeAll(keys:)` changed its paramenter keys to a generic `Sequence` instead of an `Array`. [#482](https://github.com/SwifterSwift/SwifterSwift/pull/482) by [LucianoPAlmeida](https://github.com/LucianoPAlmeida).

### Deprecated
- **Array**
  - `groupByKey(keyForValue:)`. [#454](https://github.com/SwifterSwift/SwifterSwift/pull/454) by [@calebkleveter](https://github.com/calebkleveter)

>### Removed

### Fixed
- **UIImage**:
  - `scaled(toWidth:, with orientation:)` and `scaled(toHeight:, with orientation:)` were ignoring an image's scale. [#446](https://github.com/SwifterSwift/SwifterSwift/pull/446) by [vyax](https://github.com/vyax)

>### Security

---

# [v4.3.0](https://github.com/SwifterSwift/SwifterSwift/releases/tag/4.3.0)

### Added
- **Swift 4.1 / Xcode 9.3**
  - Added Swift 4.1 support.
- **Linux Support**:
  - Updated all swift files to use Swift's 4.1 [`# if canImport(module)`](https://github.com/apple/swift-evolution/blob/master/proposals/0075-import-test.md) statement, which brings the project one step closer to first-class Linux support.
- **Sequence**
  - `all()` method moved from ArrayExtensions to SequenceExtensions. [#424](https://github.com/SwifterSwift/SwifterSwift/pull/424) by [n0an](https://github.com/n0an).
  - `none()` method moved from ArrayExtensions to SequenceExtensions. [#424](https://github.com/SwifterSwift/SwifterSwift/pull/424) by [n0an](https://github.com/n0an).
  - Added `any()` method to return if any element of sequence elements conforms to given condition. [#424](https://github.com/SwifterSwift/SwifterSwift/pull/424) by [n0an](https://github.com/n0an).
- **SignedInteger**
  - added `ordinalString(locale:)` method to return string ordinal representation of number in specified locale language. [#434](https://github.com/SwifterSwift/SwifterSwift/pull/434) by [n0an](https://github.com/n0an).
- **SignedNumeric**
  - added `spelledOutString(locale:)` method to return string representation of number spelled in specified locale language. [#434](https://github.com/SwifterSwift/SwifterSwift/pull/434) by [n0an](https://github.com/n0an).
- **String**
  - added computed property `isSpelledCorrectly` to check if the given string has typos or not. [#430](https://github.com/SwifterSwift/SwifterSwift/pull/430) by [n0an](https://github.com/n0an).
  - added `removingPrefix(_ prefix:)` method to remove given prefix from the string. [#430](https://github.com/SwifterSwift/SwifterSwift/pull/430) by [n0an](https://github.com/n0an).
  - added `removingSuffix(_ suffix:)` method to remove given suffix from the string. [#430](https://github.com/SwifterSwift/SwifterSwift/pull/430) by [n0an](https://github.com/n0an).
- **SwiftLint**:
  - reduced the number of disabled rules in _.swiftlint.yml_, please add `disable` and `enable` statements from now on when needed in code.
  - added SwiftLint to test targets to insure code style consistency across the project.

### Changed
- **SignedNumeric**:
  - `asLocaleCurrency` now returns an optional string.
- **Array**:
  - `rotate` method now returns a `discardableResult`.
  - `shuffle` method now returns a `discardableResult`.
  - `sort<T: Comparable>(by:, ascending:)` method now returns a `discardableResult`.
  - `keep` method now returns a `discardableResult`.

### Deprecated
- **UIStoryboard**:
  - `mainStoryboard` property has been renamed to `main`.
- **Array**:
  - deprecated `pop` method in favor of Swift’s `popLast`.
  - deprecated `push` method in favor of Swift’s `append`.
  - deprecated `swap` method in favor of Swift’s `swapAt`.
  - deprecated `item(at index: Int)` method in favor of `subscript(safe:)`.
  - `duplicatesRemoved` method has been renamed to `withoutDuplicates`.
- **Bool**:
  - deprecated `toggled` property, use `!self` instead.
  - deprecated `toggle` method, use `self = !self` instead.

### Fixed
- **String**
   - Fixed UIView extension `addShadow`  was not showing the shadow on view bug. [#420](https://github.com/SwifterSwift/SwifterSwift/pull/420) by [LucianoPAlmeida](https://github.com/LucianoPAlmeida).

---

# [v4.2.0](https://github.com/SwifterSwift/SwifterSwift/releases/tag/4.2.0)

### Added
- **MKPolyline**
  - Added `.coordinates` property, to return an array of coordinates for the provided polyline. [#416](https://github.com/SwifterSwift/SwifterSwift/pull/416) by [@freak4pc](https://github.com/freak4pc).
  - Added `init(coordinates:)` initializer, to initialize a `MKPolyline` with a provided array of coordinates. [#416](https://github.com/SwifterSwift/SwifterSwift/pull/416) by [@freak4pc](https://github.com/freak4pc).
- **Optional**
  - Added `.unwrapped(or:)` method, to get the value wrapped by an optional or throw a custom error. [#413](https://github.com/SwifterSwift/SwifterSwift/pull/413) by [@calebkleveter](https://github.com/calebkleveter).
- **UIButton**
  - added `centerTextAndImage(spacing:)` to Center align title text and image on UIButton. [#365](https://github.com/SwifterSwift/SwifterSwift/pull/365) by [@imjog](https://github.com/imjog).
- **Array**
  - added `divided(by:)` to separate an array into 2 arrays based on a predicate. [#367](https://github.com/SwifterSwift/SwifterSwift/pull/367) by [@neoneye](https://github.com/neoneye).
- **Int**
  - added `roundToNearest(n:)` to round an integer to the closest multiple of a given n. [#381](https://github.com/SwifterSwift/SwifterSwift/pull/381) by [@vyax](https://github.com/vyax).
- **FileManager**
  - added `jsonFromFile(atPath path:, readingOptions:)` to open a JSON file and serialize its content to a [String, Any]? instance with a provided path. [#390](https://github.com/SwifterSwift/SwifterSwift/pull/390) by [jason-ingenuity](https://github.com/jason-ingenuity).
  - added `jsonFromFile(withFilename filename:, at bundleClass:, readingOptions:)` to open a JSON file and serialize its content to a [String, Any]? instance given a filename. [#390](https://github.com/SwifterSwift/SwifterSwift/pull/390) by [jason-ingenuity](https://github.com/jason-ingenuity).
- **Int**
  - added a more performant and memory efficient `digits` property to return array of integers. [#393](https://github.com/SwifterSwift/SwifterSwift/pull/393) by [FrankKair](https://github.com/FrankKair).
- **StringProtocol**
  - added `commonSuffix(with:, options:)` to get the longest common suffix of the receiver and a given string. [#379](https://github.com/SwifterSwift/SwifterSwift/pull/379) by [@vyax](https://github.com/vyax).
- **UICollectionView**
  - added `register(nibWithCellClass:, at bundleClass:)` method to be able to register a cell with custom nib just by its class name. [#386](https://github.com/SwifterSwift/SwifterSwift/pull/386) by [jason-ingenuity](https://github.com/jason-ingenuity).
- **UIFont**
  - added `bold` and `italic` to UIFont. [#382](https://github.com/SwifterSwift/SwifterSwift/pull/382) by [@vyax](https://github.com/vyax).
- **UIImage**
  - added `withRoundedCorners(radius:)` to round the corners of an image. The parameter radius is optional, the resulting image will be round if it is unspecified. [#380](https://github.com/SwifterSwift/SwifterSwift/pull/380) by [@vyax](https://github.com/vyax).
- **UITableView**
  - added `register(nibWithCellClass:, at bundleClass:)` method to be able to register a cell with custom nib just by its class name. [#386](https://github.com/SwifterSwift/SwifterSwift/pull/386) by [jason-ingenuity](https://github.com/jason-ingenuity).
- **URL**
  - added `queryParmeters` property to get the query parameters from a URL as a dictionary. [#370](https://github.com/SwifterSwift/SwifterSwift/pull/370) by [nathanbacon](https://github.com/nathanbacon).
  - added `thumbnail(fromTime:)` to generate a thumbnail image from a given url. [410](https://github.com/SwifterSwift/SwifterSwift/pull/410) by [BennX](https://github.com/BennX).
- **UserDefaults**
  - added `object(type: with key: usingDecoder decoder:)` method to be able to retrieve Codable objects from UserDefaults. [#388](https://github.com/SwifterSwift/SwifterSwift/pull/388) by [jason-ingenuity](https://github.com/jason-ingenuity).
  - added `set(codable: forKey key: usingEncoder encoder:)` method to be able to store Codable objects from UserDefaults. [#388](https://github.com/SwifterSwift/SwifterSwift/pull/388) by [jason-ingenuity](https://github.com/jason-ingenuity).
- **String**
  - added computed property `isWhitespace` to check if the given string is blank or not.[#363](https://github.com/SwifterSwift/SwifterSwift/pull/363) by [rkp1026](https://github.com/rkp1026).
  - added `isDigits` to check if string only contains digits. [#396](https://github.com/SwifterSwift/SwifterSwift/pull/396) by [seifeet](https://github.com/seifeet).
  - added `toSlug()` to return a slug version of a given string. [397#](https://github.com/SwifterSwift/SwifterSwift/pull/397) by [FrankKair](https://github.com/FrankKair)
- New **UIStackView**
  - added `init(arrangedSubviews:, axis:, spacing:, alignment:, distribution:)` to directly initialize a `UIStackView` with an array of `UIViews`. [#409](https://github.com/SwifterSwift/SwifterSwift/pull/409) by [BennX](https://github.com/BennX)

### Fixed
- **String**
  - Fixed `isNumeric` to check if string is a valid Swift number and added isDigits to check if string only contains digits. [#396](https://github.com/SwifterSwift/SwifterSwift/pull/396) by [seifeet](https://github.com/seifeet).
- **Collection**
  - Fixed `randomItem` crash with empty array. [#405](https://github.com/SwifterSwift/SwifterSwift/pull/405) by [LucianoPAlmeida](https://github.com/LucianoPAlmeida).

---

# [v4.1.1](https://github.com/SwifterSwift/SwifterSwift/releases/tag/4.1.1)

### Added
- **NSPredicate**
  - Added operator `!` to return a new predicate formed by NOT-ing a given predicate.
  - Added operator `+` to return a new predicate formed by AND-ing two given predicates.
  - Added operator `|` to return a new predicate formed by OR-ing a two given predicates.
  - Added operator `-` to return a new predicate formed by removing the argument from the second predicate. [#345](https://github.com/SwifterSwift/SwifterSwift/pull/345) by [yycking](https://github.com/yycking).
- **NSAttributedString**
  - Added `attributes` property to get the attributes that apply to a simple NSAttributedString. [#333](https://github.com/SwifterSwift/SwifterSwift/issues/333) by [nathanbacon](https://github.com/nathanbacon).
  - Added `applying(attributes: , toRangesMatching: )`  function to return an attributed string with attributes applied to substrings matching the passed regex pattern by [nathanbacon](https://github.com/nathanbacon).
  - Added `applying(attributes: , toOccurrencesOf: )`  function to return an attributed string with attributes applied to substrings matching the passed string by [nathanbacon](https://github.com/nathanbacon).
- **Array**
  - Added `sort(by: KeyPath)` and `sorted(by: KeyPath)` to sort arrays based on Swift 4 keyPath. [#343](https://github.com/SwifterSwift/SwifterSwift/pull/343) by [LucianoPAlmeida](https://github.com/LucianoPAlmeida).
- **String**
  - Added `loremIpsum(ofLength: )` static function to return a lorem ipsum string. [#318](https://github.com/SwifterSwift/SwifterSwift/issues/318) by [omaralbeik](https://github.com/omaralbeik).
- **UIDatePicker**
  - Added `textColor` to get and set the text color of a UIDatePicker. [#328](https://github.com/SwifterSwift/SwifterSwift/issues/328) by [omaralbeik](https://github.com/omaralbeik).
- **NSImage**
  - Added `write(to url: URL, fileType type: _, compressionFactor: _)` to write NSImage to url. [#320](https://github.com/SwifterSwift/SwifterSwift/pulls/320) by [omaralbeik](https://github.com/omaralbeik).
- **Date**
  - Added `random(from: Date, upTo: Date) -> Date` method that return radom date in in the specified range [#336](https://github.com/SwifterSwift/SwifterSwift/pull/336) by [akuzminskyi](https://github.com/akuzminskyi).
  - Added `string(withFormat format: String)` method to get a string from a date with the given format.
  - Added `init?(integerLiteral value: Int)` initializer to create date object from Int literal. [#342](https://github.com/SwifterSwift/SwifterSwift/pull/342) by [n0an](https://github.com/n0an).
- **UIViewController**
  - Added  `showAlert(title: String?, message: String?, buttonTitles: [String]?, highlightedButtonIndex: Int?, completion: ((Int) -> ())?)`  for conveniently displaying an alert from any view controller [#364](https://github.com/SwifterSwift/SwifterSwift/pull/364) by [rkp1026](https://github.com/rkp1026)
### Changed

- **Array**
  - **Breaking Change** `indexes(of:)` has been renamed to `indices(of:)`. [#355](https://github.com/SwifterSwift/SwifterSwift/pull/355) by [Najdan](https://github.com/Najdan)
  - `shuffle` and `shuffled` are no more constrained to Equatable. [#327](https://github.com/SwifterSwift/SwifterSwift/pull/327) by [LucianoPAlmeida](https://github.com/LucianoPAlmeida).


### Fixed

- **Int**
  - Fixed where the base in `isPrime()` was not correct. [#323](https://github.com/SwifterSwift/SwifterSwift/pull/323) by [Asura19](https://github.com/Asura19).
- **UINavigationBar**
  - Fixed a bug where makeTransparent was keeping the background color. [#344](https://github.com/SwifterSwift/SwifterSwift/issues/344) by [omaralbeik](https://github.com/omaralbeik).
- **Continuous Integration**
  - Fixed swiftlint warning in `NSImageExtensions`.

---

# v4.1.0

### API Breaking
- **String**
  - `length` is deprecated, use native `count` instead.
  - `slicing(i:)` is deprecated, use `string[safe: i]` instead.
  - `slicing(from: to:)` is deprecated, use `string[safe: start..<end]`.
  - `firstIndex(of:)` is deprecated, use the natives `index(of: Character)` or `range(of: StringProtocol)` instead.
  - `splitted(by:)` is deprecated,  use the native `split(separator: )` instead.
  - `reversed() -> String` is deprecated, use the Swift 4 new `reversed() -> ReversedCollection<String>`. [#305](https://github.com/SwifterSwift/SwifterSwift/pull/305) by [LucianoPAlmeida](https://github.com/LucianoPAlmeida).
- **Date**
  - `weekday` is now a _get-only_ property.
  - `isInThisWeek` has been renamed to `isInCurrentWeek`.
  - `isInThisMonth` has been renamed to `isInCurrentMonth`.
  - `isInThisYear` has been renamed to `isInCurrentYear`.
  - `isInWeekday` has been renamed to `isWorkday`. [#313](https://github.com/SwifterSwift/SwifterSwift/pull/313) by [kaphacius](https://github.com/kaphacius).

### Enhancements
- New **String** extensions
  - added `padStart(length: with:)` and `padEnd(length: with:)` to pad the string to a length on the start or end.
  - added `paddingStart(length: with:)` and `paddingEnd(length: with:)` to return a padding string to a length on the start or end. [#300](https://github.com/SwifterSwift/SwifterSwift/pull/300) by [LucianoPAlmeida](https://github.com/LucianoPAlmeida)
- New **NSImage** extensions
  - added `scaled(toMaxSize:)` to scale image to maximum size with respect to aspect ratio [#291](https://github.com/SwifterSwift/SwifterSwift/pull/291) by [buddax2](https://github.com/buddax2).
- New **Date** extensions
  - added `isWithin(_ value: , _ component: , of date:)` method to check if date is within a number of date components of another date. [295](https://github.com/SwifterSwift/SwifterSwift/pull/295) by [kaphacius](https://github.com/kaphacius).
- New **Optional** extensions
  - added optional assignment operator `??=` [#296](https://github.com/SwifterSwift/SwifterSwift/pull/296) by [buddax2](https://github.com/buddax2).
- New **Calendar** extensions
  - added `numberOfDaysInMonth` to get number of days in the month for a specified date. [#311](https://github.com/SwifterSwift/SwifterSwift/pull/311) by [chaithanyaprathyush](https://github.com/chaithanyaprathyush).
- New **Color** tests
  - added tests for `cgFloatComponents`. [#297](https://github.com/SwifterSwift/SwifterSwift/pull/297) by [stupergenius](https://github.com/stupergenius).
  - added `lighten(by percentage:)` and `darken(by percentage:)` methods to change the hue of a color. [#325](https://github.com/SwifterSwift/SwifterSwift/pull/325) by [oettingerj](https://github.com/oettingerj).
- New **CGColor** tests
  - added tests for `uiColor` and `nsColor`. [#281](https://github.com/SwifterSwift/SwifterSwift/pull/281) by [c1phr](https://github.com/c1phr)
- New **Date** tests
  - added new tests for `isBetween` method. [#289](https://github.com/SwifterSwift/SwifterSwift/pull/289) by [kaphacius](https://github.com/kaphacius).
- Updated Travis image to Xcode 9.1. [#314](https://github.com/SwifterSwift/SwifterSwift/pull/314) by [kaphacius](https://github.com/kaphacius)
- Removed cross references from extensions. [#297](https://github.com/SwifterSwift/SwifterSwift/pull/297) by [stupergenius](https://github.com/stupergenius).
- Updated copyright headers to _Copyright © 2017 SwifterSwift_ everywhere. [#308](https://github.com/SwifterSwift/SwifterSwift/pull/308) by [camdeardorff](https://github.com/camdeardorff).

### Bugfixes
- **Date**
  - complete rewrite for most extensions. [#309](https://github.com/SwifterSwift/SwifterSwift/pull/309) by [omaralbeik](https:github.com/omaralbeik)
  - fixed a bug in `year` where setting year was resetting all smaller components to zero.
  - fixed a bug in `month` where setting month was resetting all smaller components to zero.
  - fixed a bug in `day` where setting day was resetting all smaller components to zero.
  - fixed a bug in `hour` where setting hour was resetting all smaller components to zero.
  - fixed a bug in `minute` where setting minute was resetting all smaller components to zero.
  - fixed a bug in `second` where setting second was resetting all smaller components to zero.
  - added validation to setters for properties above.
  - fixed the above bugs in `changing` method as well.
  - fixed a bug where `quarter` was returning 1 always.
  - Added more tests to edge cases.


# v4.0.1

### API Breaking
N/A

### Enhancements
- **Color**
  - Refactored duplicated code from `UIColorExtensions` and `NSColorExtensions` into `ColorExtensions`. thanks to [SD10](https://github.com/SD10).
  - Refactored duplicated tests from `UIColorExtensionsTests` and `NSColorExtensionsTests` into `ColorExtensionsTests`. [#260](https://github.com/SwifterSwift/SwifterSwift/pull/260) by [LeLuckyVint](https://github.com/LeLuckyVint).
  - Add `cgFloatComponents` to get RGB components for a Color represented as CGFloat numbers (between 0 and 1)
  - `blend` now support NSColor as well.
  - Corrected some typos in README. [#263](https://github.com/SwifterSwift/SwifterSwift/pull/263) by [nick3399](https://github.com/nick3399).
- New **String** extensions
  - Add `localized(comment:)` to returns a localized string, with an optional comment for translators. [#269](https://github.com/SwifterSwift/SwifterSwift/pull/269) by [Vyax](https://github.com/Vyax).
- New **NSPredicate** extensions
  - Add `not` to returns a new predicate formed by NOT-ing the predicate.
  - Add `and(_ predicate: NSPredicate)` to returns a new predicate formed by AND-ing the argument to the predicate.
  - Add `or(_ predicate: NSPredicate)` to returns a new predicate formed by OR-ing the argument to the predicate.
    [#273](https://github.com/SwifterSwift/SwifterSwift/pull/273) by [Vyax](https://github.com/Vyax).
- New **UILabel** extensions
  - Add `convenience init(text: String?)` to initialize a UILabel with text. [#271](https://github.com/SwifterSwift/SwifterSwift/pull/271) by [Vyax](https://github.com/Vyax).
- New **Bool** extensions
  - Add `random` to returns a random boolean value. [#272](https://github.com/SwifterSwift/SwifterSwift/pull/272) by [Vyax](https://github.com/Vyax).
- **Continuous Integration**
  - Add macOS tests to travis-ci.
  - Add calls to `swiftlint` and `pod lib lint` in Travis [#264](https://github.com/SwifterSwift/SwifterSwift/pull/264) by [calebkleveter](https://github.com/calebkleveter).
- New **SignedNumeric** extensions tests
### Bugfixes
- **Color**
  - Fixed a bug in `rgbComponents`, `shortHexString`, and `shortHexOrHexString` where an exception was raised when color is white or black.
  - Corrected a typo in `rgbComponenets` -> `rgbComponents`



# v4.0.0

### API Breaking
- **Swift4 / Xcode9 🎉**
  - This version brings support for Swift4 and Xcode9. [Looking for Swift3 / 3.2 ?](https://github.com/SwifterSwift/SwifterSwift#looking-for-swift-3)
- **UIColor**
  - `social` has been renamed to `Social` to match Apple Swift guidelines
  - `material` has been renamed to `Material` to match Apple Swift guidelines
  - `flatUI` has been renamed to `FlatUI` to match Apple Swift guidelines
  - `css` has been renamed to `CSS` to match Apple Swift guidelines
- **NSColor**
  - `social` has been renamed to `Social` to match Apple Swift guidelines
  - `material` has been renamed to `Material` to match Apple Swift guidelines
  - `flatUI` has been renamed to `FlatUI` to match Apple Swift guidelines
  - `css` has been renamed to `CSS` to match Apple Swift guidelines

### Enhancements
- **SwiftLint**
  - Added [SwiftLint](https://github.com/realm/SwiftLint) to enforce Swift style and conventions.
- **Danger**
  - Added Danger to continuous integration. [#252](https://github.com/SwifterSwift/SwifterSwift/pull/252) by [SD10](https://github.com/SD10).
- New **Date** extensions
  - added `isBetween(_ startDate: Date, _ endDate: Date, includeBounds: Bool = false) -> Bool` method to check if a date is between two other dates. [#248](https://github.com/SwifterSwift/SwifterSwift/pull/248) by [BennX](https://github.com/BennX).
- New **UIFont** extensions
  - added `monospaced -> UIFont` method to get the current font as monospaced font. [#250](https://github.com/SwifterSwift/SwifterSwift/pull/250) by [BennX](https://github.com/BennX), [Monospaced Font explanation](https://en.wikipedia.org/wiki/Monospaced_font)
- **UITableView**
  - `dequeueReusableCell` now returns an optional
  - `dequeueReusableHeaderFooterView` now returns an optional
- **UICollectionView**
  - `dequeueReusableCell` now returns an optional
  - `dequeueReusableSupplementaryView` now returns an optional
- **UIAlertController**
  - Added `preferredStyle: UIAlertControllerStyle = .alert` to `init from error`.
- **UIStoryboard**
  - `instantiateViewController` now returns an optional.
- **Continuous Integration**
  - Travis now builds `watchOS` target.

### Bugfixes
- **SwifterSwift**
  - `didTakeScreenShot` now returns the notification, make sure to remove listener when you don't need it anymore.


# v3.2.0

### API Breaking
- **Swift 3.2**
  - Code has been updated to Swift 3.2; please use [`v3.1.1`](https://github.com/SwifterSwift/SwifterSwift/releases/tag/3.1.1) if you are still using Swift 3 or Xcode 8
- **SwifterSwift**
  - `userDefaults` is deprecated, use Apple's `UserDefaults.standard` instead.
  - `object(forKey: String)` is deprecated, use Apple's `UserDefaults.standard.object(forKey: _)` instead.
  - `string(forKey: String)` is deprecated, use Apple's `UserDefaults.standard.string(forKey: _)` instead.
  - `integer(forKey: String)` is deprecated, use Apple's `UserDefaults.standard.integer(forKey: _)` instead.
  - `double(forKey: String)` is deprecated, use Apple's `UserDefaults.standard.double(forKey: _)` instead.
  - `data(forKey: String)` is deprecated, use Apple's `UserDefaults.standard.data(forKey: _)` instead.
  - `bool(forKey: String)` is deprecated, use Apple's `UserDefaults.standard.bool(forKey: _)` instead.
  - `array(forKey: String)` is deprecated, use Apple's `UserDefaults.standard.array(forKey: _)` instead.
  - `dictionary(forKey: String)` is deprecated, use Apple's `UserDefaults.standard.dictionary(forKey: _)` instead.
  - `float(forKey: String)` is deprecated, use SwifterSwift's `UserDefaults.standard.float(forKey: _) ` instead.
  - `set(_ value: Any?, forKey: String)` is deprecated, use Apple's `UserDefaults.standard.setValue(_, forKey: _)` instead.
- **Int**
  - Property `romanNumeral` is now a method.
- **String**
  - Property `lines` is now a method.
  - Property `mostCommonCharacter` is now a method.
  - Property `reversed` is now a method.
  - Property `unicodeArray` is now a method.
  - Property `words` is now a method.
  - Property `wordCount` is now a method.
- **UICollectionView**
  - Property `numberOfItems` is now a method.
- **UITableView**
  - Property `numberOfRows` is now a method.
- **UIViewController**
  - Removed `navigationBar` that was causing app to crash, thanks to [drewpitchford](https://github.com/drewpitchford) for reporting in [#243](https://github.com/SwifterSwift/SwifterSwift/issues/243).


### Enhancements
- New **Date** extensions
  - added `secondsSince(_ date: Date)` method to get a number of seconds between two dates.
  - added `minutesSince(_ date: Date)` method to get a number of minutes between two date.
  - added `hoursSince(_ date: Date)` method to get a number of hours between two dates.
  - added `daysSince(_ date: Date)` method to get a number of days between two date.
  - added `isInThisYear` property to check if the date is in the current year.
  - added `isInThisMonth` property to check if the date is in the current month.
  - added `isInThisWeek` property to check if the date is in the current week.
- New **URLRequest** extensions
  - added `init?(urlString: String)` fallible initializer create a URLRequest from URL string.
- New **UIWebView** extensions
  - added `loadURL(_ url: URL)` method to load a URL.
  - added `loadURLString(_ urlString: String)` method to load a URL string.
- New **UserDefaults** extensions
  - added `subscript(key: String)` method to get values from UserDefaults using the [] operator.
  - added `float(forKey key: String)` method to get a Float value from UserDefaults.
  - added `date(forKey key: String)` method to get a Date value from UserDefaults.
- Improved file structre, as in [#236](https://github.com/SwifterSwift/SwifterSwift/issues/236)
- Improved README
  - Removed unnecessary description in Installation section
  - Updated **List of All Extensions** section to match the new file structure.

### Bugfixes
N/A


# v3.1.1

### API Breaking
N/A

### Enhancements
- New **NSAttributedString** extensions
  - added `NSAttributedString + NSAttributedString` operator to return a new appended NSAttributedString.
  - added `NSAttributedString += String` operator to append a string to a NSAttributedString.
  - added `NSAttributedString + String` operator to return a new appended NSAttributedString. [#218](https://github.com/SwifterSwift/SwifterSwift/pull/218) by [@LucianoPAlmeida](https://github.com/LucianoPAlmeida)
- New **UIColor** extensions
  - added `flatUI` struct with all Flat UI colors. [#213](https://github.com/SwifterSwift/SwifterSwift/pull/213) by [@tache](https://github.com/tache)
  - added `coreImageColor` property to return CoreImage.CIColor. [#213](https://github.com/SwifterSwift/SwifterSwift/pull/213) by [@tache](https://github.com/tache)
  - added `hsbaComponents` property to get components of hue, saturation, and brightness, and alpha. [#213](https://github.com/SwifterSwift/SwifterSwift/pull/213) by [@tache](https://github.com/tache)
  - added `uInt` property to get components of hue, saturation, and brightness, and alpha as UInt. [#213](https://github.com/SwifterSwift/SwifterSwift/pull/213) by [@tache](https://github.com/tache)
- New **NSColor** extensions
  - added `flatUI` struct with all Flat UI colors. [#213](https://github.com/SwifterSwift/SwifterSwift/pull/213) by [@tache](https://github.com/tache)
- New **UIImage** extensions
  - added `tint()` to get UIImage tinted with color. [#213](https://github.com/SwifterSwift/SwifterSwift/pull/213) by [@tache](https://github.com/tache)
- New **SignedNumber** extensions. [#224](https://github.com/SwifterSwift/SwifterSwift/pull/224) by [@omaralbeik](https://github.com/omaralbeik)
  - moved `abs` from `FloatingPointExtensions` and `IntExtensions`
  - moved `isPositive` from `FloatingPointExtensions` and `IntExtensions`
  - moved `isNegative` from `FloatingPointExtensions` and `IntExtensions`
  - moved `string` from `FloatingPointExtensions` and `IntExtensions`
  - moved `asLocaleCurrency` from `FloatingPointExtensions` and `IntExtensions`
- New **SignedInteger** extensions. [#224](https://github.com/SwifterSwift/SwifterSwift/pull/224) by [@omaralbeik](https://github.com/omaralbeik)
  - moved `isEven` from `IntExtensions`
  - moved `isOdd` from `IntExtensions`
  - moved `digits` from `IntExtensions`
  - moved `digitsCount` from `IntExtensions`
  - moved `timeString` from `IntExtensions`
  - moved `gcd(of n)` from `IntExtensions`
  - moved `lcm(of n)` from `IntExtensions`
- Added `SwifterSwift` module_name to podspecs file to help solving conflicts with other 3rd party libraries. [#226](https://github.com/SwifterSwift/SwifterSwift/pull/226) by [@omaralbeik](https://github.com/omaralbeik)
- Moved missing examples from the old docs. [#216](https://github.com/SwifterSwift/SwifterSwift/pull/216) by [@LucianoPAlmeida](https://github.com/LucianoPAlmeida)
- New `Int` extensions
  - added `isPrime()` to check if integer is prime number. [#221](https://github.com/SwifterSwift/SwifterSwift/pull/221) by [@pvtmert](https://github.com/pvtmert)
- Improve sum & average extensions by not relying on reduce. [#225](https://github.com/SwifterSwift/SwifterSwift/pull/225) by [@SD10](https://github.com/SD10)
- New SVG logo in README! by [@omaralbeik](https://github.com/omaralbeik)

### Bugfixes
- Fixed UISlider test by using XCTExpectation ([#209](https://github.com/SwifterSwift/SwifterSwift/issues/209)). [#229](https://github.com/SwifterSwift/SwifterSwift/issues/229). by [@LucianoPAlmeida](https://github.com/LucianoPAlmeida)


# v3.1.0

### API Breaking
- **String**
  - `firstCharacter` has been renamed to `firstCharacterAsString`. [#208](https://github.com/SwifterSwift/SwifterSwift/pull/208) by [@omaralbeik](https://github.com/omaralbeik)
  - `lastCharacter` has been renamed to `lastCharacterAsString`. [#208](https://github.com/SwifterSwift/SwifterSwift/pull/208) by [@omaralbeik](https://github.com/omaralbeik)
  - `firstCharacter` has been renamed to `firstCharacterAsString`. [#208](https://github.com/SwifterSwift/SwifterSwift/pull/208) by [@omaralbeik](https://github.com/omaralbeik)
  - `float` has been renamed to `float(locale: Locale = .current)`. [#208](https://github.com/SwifterSwift/SwifterSwift/pull/208) by [@omaralbeik](https://github.com/omaralbeik)
  - `double` has been renamed to `double(locale: Locale = .current)`. [#208](https://github.com/SwifterSwift/SwifterSwift/pull/208) by [@omaralbeik](https://github.com/omaralbeik)
  - `subscript(i: Int)` has been renamed to `subscript(safe i: Int)`. [#208](https://github.com/SwifterSwift/SwifterSwift/pull/208) by [@omaralbeik](https://github.com/omaralbeik)
  - `subscript(range: CountableRange<Int>)` has been renamed to `subscript(safe range: CountableRange<Int>)`. [#208](https://github.com/SwifterSwift/SwifterSwift/pull/208) by [@omaralbeik](https://github.com/omaralbeik)
  - `subscript(range: ClosedRange<Int>)` has been renamed to `subscript(safe range: ClosedRange<Int>)`. [#208](https://github.com/SwifterSwift/SwifterSwift/pull/208) by [@omaralbeik](https://github.com/omaralbeik)
  - `replacing(_ substring: String, with newString: String)` is deprecated, use Apple's `replacingOccurrences(of: substring, with: newString)` instead. [#208](https://github.com/SwifterSwift/SwifterSwift/pull/208) by [@omaralbeik](https://github.com/omaralbeik)
  - `int8` is deprecated, use `Int8(string)` instead. [#208](https://github.com/SwifterSwift/SwifterSwift/pull/208) by [@omaralbeik](https://github.com/omaralbeik)
  - `int16` is deprecated, use `Int16(string)` instead. [#208](https://github.com/SwifterSwift/SwifterSwift/pull/208) by [@omaralbeik](https://github.com/omaralbeik)
  - `int32` is deprecated, use `Int32(string)` instead. [#208](https://github.com/SwifterSwift/SwifterSwift/pull/208) by [@omaralbeik](https://github.com/omaralbeik)
  - `int64` is deprecated, use `Int64(string)` instead. [#208](https://github.com/SwifterSwift/SwifterSwift/pull/208) by [@omaralbeik](https://github.com/omaralbeik)
  - `float32` is deprecated, use `Float32(string)` instead. [#208](https://github.com/SwifterSwift/SwifterSwift/pull/208) by [@omaralbeik](https://github.com/omaralbeik)
  - `float64` is deprecated, use `Float64(string)` instead. [#208](https://github.com/SwifterSwift/SwifterSwift/pull/208) by [@omaralbeik](https://github.com/omaralbeik)

- **UIColor**
  - `init(hex: Int, transparency: CGFloat = 1)` is now a failable initializer `init?`. [#208](https://github.com/SwifterSwift/SwifterSwift/pull/208) by [@omaralbeik](https://github.com/omaralbeik)
  - `init(red: Int, green: Int, blue: Int, transparency: CGFloat = 1)` is now a failable initializer `init?`. [#208](https://github.com/SwifterSwift/SwifterSwift/pull/208) by [@omaralbeik](https://github.com/omaralbeik)
  - `redComponent` is deprecated, use the new `rgbComponenets.red` instead. [#208](https://github.com/SwifterSwift/SwifterSwift/pull/208) by [@omaralbeik](https://github.com/omaralbeik)
  - `greenComponent` is deprecated, use the new `rgbComponenets.green` instead. [#208](https://github.com/SwifterSwift/SwifterSwift/pull/208) by [@omaralbeik](https://github.com/omaralbeik)
  - `blueComponent` is deprecated, use the new `rgbComponenets.blue` instead. [#208](https://github.com/SwifterSwift/SwifterSwift/pull/208) by [@omaralbeik](https://github.com/omaralbeik)

### Enhancements
- New **String** extensions
  - added `cgFloat(locale: Locale = .current)` to get CGFloat value from string. [#208](https://github.com/SwifterSwift/SwifterSwift/pull/208) by [@omaralbeik](https://github.com/omaralbeik)
  - added `words` to return an array of all words in a string. [#208](https://github.com/SwifterSwift/SwifterSwift/pull/208) by [@omaralbeik](https://github.com/omaralbeik)
  - added `wordCount` to get count of words in a string. [#208](https://github.com/SwifterSwift/SwifterSwift/pull/208) by [@omaralbeik](https://github.com/omaralbeik)
- New **Int** extensions
  - added `countableRange` to get CountableRange 0..<Int. [#208](https://github.com/SwifterSwift/SwifterSwift/pull/208) by [@omaralbeik](https://github.com/omaralbeik)
  - added `uInt` to get UInt from Int. [#208](https://github.com/SwifterSwift/SwifterSwift/pull/208) by [@omaralbeik](https://github.com/omaralbeik)
- New **Array** extensions
  - added `group(size:)` to split in an array of slices of a size. [#199](https://github.com/SwifterSwift/SwifterSwift/pull/199). [#208](https://github.com/SwifterSwift/SwifterSwift/pull/208) by [@LucianoPAlmeida](https://github.com/LucianoPAlmeida)
  - added `rotated(by:)` to return a new rotated array by the given places. [#207](https://github.com/SwifterSwift/SwifterSwift/pull/207) by [@LucianoPAlmeida](https://github.com/LucianoPAlmeida)
  - added `rotate(by:)` to rotate the array by the given places. [#207](https://github.com/SwifterSwift/SwifterSwift/pull/207) by [@LucianoPAlmeida](https://github.com/LucianoPAlmeida)
- New **UITextField** extensions
  - added `addPaddingLeftIcon(_ image: UIImage, padding: CGFloat)` to add padding to the left of the textfield rect. [#203](https://github.com/SwifterSwift/SwifterSwift/pull/203) by [@xingfuqiu](https://github.com/xingfuqiu)
  - added `hasValidEmail` to check if textFields text is a valid email format. [#208](https://github.com/SwifterSwift/SwifterSwift/pull/208) by [@omaralbeik](https://github.com/omaralbeik)
  - added `textType` to set textField for common text types like email addresses & passwords. [#208](https://github.com/SwifterSwift/SwifterSwift/pull/208) by [@omaralbeik](https://github.com/omaralbeik)
- New **UIColor** extensions
  - added `rgbComponenets` to get RGB components for a UIColor. [#208](https://github.com/SwifterSwift/SwifterSwift/pull/208) by [@omaralbeik](https://github.com/omaralbeik)
- Added usage examples in documentation for Foundation extensions. [#208](https://github.com/SwifterSwift/SwifterSwift/pull/208) by [@omaralbeik](https://github.com/omaralbeik)
- Moved many duplicated extensions from `DoubleExtensions` and `FloatExtensions` into the new `FloatingPointExtensions`, this makes the code easier to maintain and brings support for other FloatingPoint types like CGFloat, Double32, ... [#208](https://github.com/SwifterSwift/SwifterSwift/pull/208) by [@omaralbeik](https://github.com/omaralbeik)

### Bugfixes
- Fixed XCTAssertNotNil cannot handle optionals. [#188](https://github.com/SwifterSwift/SwifterSwift/issues/188). by [@omaralbeik](https://github.com/omaralbeik)
- Fixed Tests are failing at non-english machine / Bug in String.double [#187](https://github.com/SwifterSwift/SwifterSwift/issues/187). by [@omaralbeik](https://github.com/omaralbeik)


# v3.0.0

### API Breaking

### Enhancements

- Documentation should be greatly improved and up to date now that we are using [Jazzy](https://github.com/realm/jazzy) to auto-generate docs! :tada: [#198](https://github.com/SwifterSwift/SwifterSwift/pull/198) by [@omaralbeik](https://github.com/omaralbeik)

- SwifterSwift now supports subspecs to offer more control over imported extensions: [#198](https://github.com/SwifterSwift/SwifterSwift/pull/198) by [@omaralbeik](https://github.com/omaralbeik)
    - SwifterSwift/Foundation
    - SwifterSwift/UIKit
    - SwifterSwift/Cocoa

- `Array` extensions now have throwing signatures. [#170](https://github.com/SwifterSwift/SwifterSwift/pull/170) by [@LucianoPAlmeida](https://github.com/LucianoPAlmeida)

- New **Array** extensions
    - added `groupByKey` to group the elements of the array by key in a dictionary. [#181](https://github.com/SwifterSwift/SwifterSwift/pull/181) by [@LucianoPAlmeida](https://github.com/LucianoPAlmeida)
    - added `forEach(slice:body:)` to iterate by specified slice size and call a closure. [#194](https://github.com/SwifterSwift/SwifterSwift/pull/194/files) by [@LucianoPAlmeida](https://github.com/LucianoPAlmeida)
- New **Dictionary** extensions
    - add `count(where:)` to count dictionary elements where the condition returns true. [#193](https://github.com/SwifterSwift/SwifterSwift/pull/193) by [@LucianoPAlmeida](https://github.com/LucianoPAlmeida)

- New **String** extensions
    - added `isValidFileUrl` to check if a String is a valid file URL. [#175](https://github.com/SwifterSwift/SwifterSwift/pull/175) by [@LucianoPAlmeida](https://github.com/LucianoPAlmeida)
    - added `hasUniqueCharacters()` method to check if string only contains unique characters. [#195](https://github.com/SwifterSwift/SwifterSwift/pull/195) by [@FrankKair](https://github.com/FrankKair)

- New **Data** extensions
    - added `bytes` to return data as an array of bytes. [#171](https://github.com/SwifterSwift/SwifterSwift/pull/171) by [@LucianoPAlmeida](https://github.com/LucianoPAlmeida)

- New **UITextField** extensions
    - added `addPaddingLeft` extension to add padding to a UITextField. [#185](https://github.com/SwifterSwift/SwifterSwift/pull/185) by [@SD10](https://github.com/SD10)

### Bugfixes
- Fixes asynchronous `iOS`/`tvOS`/`watchOS` unit tests causing crashes. [#191](https://github.com/SwifterSwift/SwifterSwift/pull/191) by [@LucianoPAlmeida](https://github.com/LucianoPAlmeida)

# v1.6.4

- New **Array** extensions
    - added `removeAll` passing an array of items.
    - added `swap` and `safeSwap` extensions to swap to elements in an array.
    - new `firstIndex` and `lastIndex` that returns the (first or last) index where the condition is true.
    - new `indexes` extension that return indexes where the condition is true.
    - new `all` and `none` that checks if (all or none) of array elements match condition.
    - new `last` extension to find the last element that matches condition.
    - new `reject` extension to filter elements that **not** matches condition.
    - new `count` extension to count elements that match condition.
    - new `forEachReversed` extension to iterate over an array in reverse order.
    - new `accumulate` extension to reduces an array while returning each interim combination.
    - new `forEach` with condition to a filtered interaction over the array.
    - new `keep` extension to keep all elements that in order are until the condition is false.
    - new `take` extension that returns all elements that in order are until the condition is false.
    - new `skip` extension that returns all elements that in order are after the condition is false.
    - new `filtered: map` extension to perform a map and filter operation in just one iteration.
- New **Character** extensions
    - added isLetter & isWhiteSpace extensions
    - new lowercased extension to lower case the character
    - new uppercased extension to upper case the character
- New **Date** extensions
    - new `isInWeekday` extension to check if the date is within a weekday period
- New **Dictionary** extensions
    - new `removeAll` extension to remove the values for all keys in an array.
    - new + operator to merge to dictionaries in a new one and += to merge one dictionary into another.
    - new - operator to get a new dictionary with the values for all keys in an array removed and -= to remove the values for all keys in an array.
- New **String** extensions
    - new `matches` extension to check if the string matches a regex pattern.
- New **Locale** extensions
    - new posix property extension to convenience create the "en_US_POSIX" locale.
- New **CLLocation** extensions
    - new `midLocation` to find the half-way point along a great circle path between relative to another point.
    - new `bearing` to calculate the bearing relative another location.
### Improvements
- Fixes on wrong access  levels for some extensions
- Improve NSAttributedStringExtensions extensions
- Fixes on implementations of some array extensions
- Fixes on some UIButtonExtensions
- Improvements on some Date extensions
- Improvements on some methods signatures based on Swift 3 API guidelines
- Improve code coverage.
- Improvements on documentation headers     

### Testing

This release has drastically increased test coverage: currently 92%.
Areas affected are:

**Foundation**

    - ArrayExtensions tests
    - CharacterExtensions tests
    - DateExtensions tests
    - DictionaryExtensions tests
    - StringExtensions tests
    - LocaleExtensions tests

**UIKit**

    - UIColorExtensions tests
    - UIButtonExtensions tests

**Cocoa**

    - CGSizeExtensions tests
    - CGPointExtensions tests
    - CLLocationExtensions tests

---


# v1.6.3

- New **Character** extensions
    - new * operator (repeat character n amount of times)
    - added isLowercased & isUppercased extensions

- New **UICollectionView** extensions
    - new extensions to register/dequeue cells using UICollectionViewCell class as identifier
    - new extensions to register/dequeue reusable views using UICollectionReusableView class as identifier

- New **UITableView** extensions
    - new extensions to register/dequeue cells using UITableViewCell class as identifier
    - new extensions to register/dequeue header/footer views using UITableViewHeaderFooterView as identifier

- New **UIStoryboard** extensions
    - added extension to `instantiateViewController` with class as identifier
    - added extension get `mainStoryboard`

- New **UIView** extensions
    - added quick getter and setter for frame’s X and Y values

- New **Array** extensions
    - added `safeSwap` method as a fail-safe way to swap to elements in an array

- New **NSView** extensions
    - `borderColor` (IBInspectable)
    - `borderWidth` (IBInspectable)
    - `cornerRadius` (IBInspectable)
    - `height`
    - `shadowColor` (IBInspectable)
    - `shadowOffset` (IBInspectable)
    - `shadowOpacity` (IBInspectable)
    - `shadowRadius` (IBInspectable)
    - `size`
    - `width`
    - `addSubviews(subviews:)`
    - `removeSubviews()`

- New **Optional** extensions
    - `unwrapped(or:)` unwrap an optional or provide default value
    - `run(block:)` block to run if optional unwrapped is not nil

### Improvements
- Improve UIImageView extensions
    - fixes infinite recursive call in `blurred()` method
    - removes superfluous error from `download(url:)` method completion block

- Replace deprecated `M_PI` with `.pi`

- Fixes wrong implementation of -= `CGPoint` operator

- Improve Array extensions
    - properties with O(n) or higher complexity have been changed to methods
    - reduced shuffle method complexity by using Fisher-Yates algorithm and is now completely random
    - `removeDuplicates` renamed to `duplicatesRemoved.`
    - remove generic constraint on `firstIndex(of:)` and `lastIndex(of:)`

- Improve String extensions
- Improve Date extensions
- Improve Data extensions
- Improve Dictionary extensions

### Testing
This release has drastically increased test coverage: currently 88%.
Areas affected are:

**Foundation**

    - CharacterExtensions tests
    - StringExtensions tests
    - ArrayExtensions tests
    - IntExtensions tests
    - DateExtensions tests
    - DataExtensions tests
    - DoubleExtensions tests
    - FloatExtensions tests
    - CGFloatExtensions tests
    - CGPointExtensions tests


**UIKit**

    - UIColorExtensions tests
    - UIAlertControllerExtensions tests
    - UIBarButtonItemExtensions tests
    - UIButtonExtensions tests
    - UITextViewExtensions tests
    - UISegmentedControlExtensions tests
    - UINavigationControllerExtensions tests
    - UINavigationBarExtensions tests
    - UINavigationItemExtensions tests
    - UISliderExtensions tests
    - UITableViewExtensions tests
    - UICollectionViewExtensions tests
    - UIViewControllerExtensions tests
    - UIStoryboardExtensions tests
    - UITextFieldExtensions tests
    - UIViewExtensions tests
    - UIImageExtensions tests


**Cocoa**

    - NSColorExtensions tests
    - NSViewExtensions tests

---

# v1.6.2
- Major bug fixes in DateExtensions.
- New Tests.

---

# v1.6.1
Fixed Cocoapods.

---

# v1.6
This is the biggest update since v1.3!
With over 100 new extensions, improved Cocoa support, new tests, and many minor bug fixes.

## New Extensions
- CGColorExtensions
- NSColorExtensions
- URLExtensions
- StringExtensions
- **length**: Number of characters in string.
- **isValidSchemedUrl**: Check if string is a valid schemed URL.
- UIImageExtensions:
- **original**: UIImage with .alwaysOriginal rendering mode.
- **template**: UIImage with .alwaysTemplate rendering mode.
- UISearchBarExtensions:
- **clear**: Clear text.
- UITextFieldExtensions:
- **clear**: Clear text.

## Improved extensions
- StringExtensions:
- **trimmed**
- **copyToPasteboard**
- **truncated**
- SwifterSwift
- **isInTestFlight**
- UIColorExtensions:
- **shortHexString**
- **complementary**
- **Improved initializers**

## New Tests
- StringExtensionsTests
- NSAttributedStringExtensionsTests
- UIColorExtensionsTests
- DateExtensionsTests
- CharacterExtensionsTests

## CodeCov!
Added project to [CodeCov](codecov.io/gh/SwifterSwift/SwifterSwift) for better code coverage visualization.

---

# v1.4.8
General bug fixes and improvements.

---

# v1.4.6

###watchOS Support:
Thanks to [Paweł Urbanek](https://github.com/pawurb) for his great work adding watchOS target!

---

# v1.4.5

###tvOS Support:
Thanks to [Paweł Urbanek](https://github.com/pawurb) for his great work adding tvOS target!

---

# v1.4.3

###UICollectionViewExtensions:

- Fixed a bug in **indexPathForLastItem**.
- Renamed **indexPathForLastItem(in section: Int)** to **indexPathForLastItem(inSection section: Int)** to match Apple naming conventions

###UITableViewExtensions:

- Fixed a bug in **indexPathForLastRow**.
- Renamed **indexPathForLastRow(in section: Int)** to **indexPathForLastRow(inSection section: Int)** to match Apple naming conventions

##StringExtensions:

- Fixed a bug in **count(of string: String, caseSensitive: Bool)**
- Added **slicing(from i: Int, length: Int)**: Sliced string from a start index with length.
- Added **slice(from i: Int, length: Int)**: Slice given string from a start index with length (if applicable).
- Added **slicing(from start: Int, to end: Int)**: Sliced string from a start index to an end index.
- Added **slice(from start: Int, to end: Int)**: Slice given string from a start index to an end index (if applicable).
- Added **slicing(at i: Int)**: Sliced string from a start index.
- Added **slice(at i: Int)**: Slice given string from a start index (if applicable).

##StringExtensionsTests:

- Added tests for **count(of string: String, caseSensitive: Bool)**
- Added tests for slicing methods

##Contributing:

- Added **Releases Flow**
- Updated **Adding new Extensions**

##Misc:

- Introduced new [**releases Flow**](https://github.com/omaralbeik/SwifterSwift/blob/master/CONTRIBUTING.md#releases-flow)

Thanks to [Paweł Urbanek](https://github.com/pawurb) and [Michael](https://github.com/muescha)

---

# v1.4.2

###CollectionExtensions:

- Added **subscript (safe index: Index)**. Thanks to [Sai Ram Kotha](https://github.com/sairamkotha)

###UIColorExtensions:

- Added **complementary**
- Added **init?(complementaryFor color: UIColor)**

Thanks to [matt](https://github.com/ythecombinator)

###SwifterSwift:

- Added **isInTestFlight**

---

# v1.4.1

###DateExtensions:

- Added **enum DayNameStyle**.
- Added **enum MonthNameStyle**.
- Added **isInYesterday**.
- Added **isInTomorrow**.
- Added **nearestHour**.
- Added **dayName(ofStyle style: DayNameStyle)**.
- Added **monthName(ofStyle style: MonthNameStyle)**.

###UISearchBarExtensions:
- Added **trimmedText**.

###UIColorExtensions:

- Added **cssColors**.
- Added **init?(hexString: String, transparency: CGFloat)**.
- Added **shortHexString**.
- Added **shortHexOrHexString**.

###StringExtensions:

- Added **subscript(i: Int)**.
- Added **subscript(range: CountableRange<Int>)**.
- Added **subscript(range: ClosedRange<Int>)**.

---

# v1.4

- Swift Package Manager support

---

# v1.3.9

- Extension moved to Source directory; tests moved to Tests directory for a cleaner structure

---

# v1.3.8

###CollectionExtensions:
- Added **forEachInParallel**. Thanks to [Siarhei Fiedartsou](https://github.com/SiarheiFedartsou) for contributing.

###TableViewExtensions:
- Added **reloadData(_ completion: () -> Void)**.

###CollectionViewExtensions:
- Added **reloadData(_ completion: () -> Void)**.

###UIButtonExtensions:
- Refactored setForAllStates methods code. Thanks to [Ronan Rodrigo Nunes](https://github.com/ronanrodrigo)

###Misc.
- Fixed typos in README.

---

# v1.3.7

###DateExtensions:

- Changed **nearestHourQuarter** to **nearestQuarterHour**. Thanks to [Robert Nix](https://github.com/rpural) for reporting.
- Updated initializers to be optional.

###UITabBarExtensions:

- fixed selected color in  **setColors** method.

###Tests

- Updated tests. Thanks to [Siarhei Fiedartsou](https://github.com/SiarheiFedartsou) for updating.

---

# v1.3.6

###UIViewExtensions:

- Fixed bugs in **fadeIn**, **fadeOut** and **rotate(byAngle)** methods. Thanks to [bastianschilbe](https://github.com/bastianschilbe) for reporting.
- Removed **isVisible** property since it was causing many problems and not working correctly.
- Added **parentViewController** property to return view's parent view controller.

---

# v1.3.5

### DateExtensions:

Fixed a bug in DateExtensinos where the year was not set correctly. Thanks to [songhailiang](https://github.com/songhailiang) you for reporting this bug.

---

# v1.3.4

### UIViewExtensions:

- **func addConstraints(withFormat: String, views: UIView...)**: Add Visual Format constraints
- **func fillToSuperview()**: Anchor all sides of the view into it's superview
- **func anchor(top: NSLayoutYAxisAnchor?, left: NSLayoutXAxisAnchor?, bottom: NSLayoutYAxisAnchor?, right: NSLayoutXAxisAnchor?, topConstant: CGFloat, leftConstant: CGFloat, bottomConstant: CGFloat, rightConstant: CGFloat, widthConstant: CGFloat, heightConstant: CGFloat) -> [NSLayoutConstraint]**: Add anchors from any side of the current view into the specified anchors and returns the newly added constraints.
- **func anchorCenterXToSuperview(withConstant: CGFloat)**: Anchor center X into current view's superview with a constant margin value.
- **anchorCenterYToSuperview(constant: CGFloat)**: Anchor center Y into current view's superview with a constant margin value.
- **func anchorCenterSuperview()**: Anchor center X and Y into current view's superview

### IntExtensions:

- **kFormatted**: String formatted for values over ±1000 (example: 1k, -2k, 100k, 1kk, -5kk..)

Thanks to [Jonathan Bijos](https://github.com/Quaggie) & [zzjzz9266a](https://github.com/zzjzz9266a) for adding new extensions.

---

# v1.3.2

Added [CollectionViewExtensions](https://github.com/omaralbeik/SwifterSwift/wiki/uicollectionview-extensions)

---

# v1.3.1

### ArrayExtensions:

- removed duplicated contains a method
- use of reducing to remove duplicates (Thanks to [sairamkotha](https://github.com/sairamkotha))

---

# v1.3

This version adds **more than 90 new extensions** making it the widest extensions library available online for Swift 3 with **more than 360 properties and methods for more than 35 type**.
This is the biggest update since library launch! We're so excited 🤓

Here are some changes:
- Updated some properties and methods names to follow [Swift API Design Guidelines](https://developer.apple.com/videos/play/wwdc2016/403/).
- Added default values to methods parameters (where possible).
- All units documentation has been re-written in Xcode,
    - Now you see "**SwifterSwift:** " at the beginning of description to know the source of the extension while writing your code.
    - All method parameters and return types have been documented in Xcode as well.
    - All extensions documentation has been re-written in [Wiki](https://github.com/omaralbeik/SwifterSwift/wiki), separating properties from methods in different tables.
- All extensions files re-organized in separate extensions based on type (properties, methods, initializers, ..)
- Fixed some bugs where some extensions were not public.
- New section explaining how to add new extensions in [Contributing Guidelines](https://github.com/omaralbeik/SwifterSwift/blob/master/CONTRIBUTING.md)
- And finally: new logo

---

## v1.2.2

### New Extensions:

- **UIColorExtensions**:
    - **struct material**: get [Google material palette colors](https://material.google.com/style/color.html) with ease

### Updated Extensions:

- **UIColorExtensions**:
    - struct socialColors -> **struct social**

---

## v1.2.1

### New Extensions:

- **ConvenienceExtensions**:
    - **func string(forKey: String)**: Get a string from UserDefaults
    - **func integer(forKey: String)**: Get an integer from UserDefaults
    - **func double(forKey: String)**: Get a double from UserDefaults
    - **func float(forKey: String)**: Get a float from UserDefaults
    - **func data(forKey: String)**: Get a data from UserDefaults
    - **func bool(forKey: String)**: Get a bool from UserDefaults
    - **func array(forKey: String)**: Get an array from UserDefaults
    - **func dictionary(forKey: String)**: Get a dictionary from UserDefaults

- **StringExtensions**:
    - **func toDate(withFormat format: String)**: Return Date value from string of date format (if applicable).
    - **var toURL**: Return URL from string (if applicable).

- **UIAlertControllerExtensions**:
    - **addAction(title, style, isEnabled, handler)**: Add an action to Alert.
    - **addTextField(text, placeholder, editingChangedTarget, editingChangedSelector)**: Add a text field to Alert.

- **UINavigationBarExtensions**:
    - **func setColors(background, text)**: Set Navigation Bar background and text colors.


### Updated Extensions:

- **ConvenienceExtensions**:
    - var deviceHeight -> **var screenHeight**
    - var deviceWidth -> **var screenWidth**

- **ArrayExtensions**:
    - func removeAll(item: Element) -> **func removeAll(_ item: Element))**

- **DateExtensions**:
    - func add(component: Calendar.Component, value: Int) -> **add(_ component: Calendar.Component, value: Int)**
    - func adding(component: Calendar.Component, value: Int) -> **adding(_ component: Calendar.Component, value: Int)**
    - func changing(component: Calendar.Component, value: Int) -> **changing(_ component: Calendar.Component, value: Int)**
    - func isIn(current: Calendar.Component) -> **isInCurrent(_ component: Calendar.Component)**

- **StringExtensions**:
    - func contain(string: String, caseSensitive: Bool) -> **func contain(_ string: String, caseSensitive: Bool)**
    - func lines() -> **var lines**
    - static func random(of length: Int) -> **static func random(ofLength: Int)**
    - func replace(string: String, with: String) -> **func replace(_ substring: String, with: String)**
    - func truncate(to length: Int, trailing: String?) -> **func truncate(toLength: Int, trailing: String?)**
    - func truncated(to length: Int, trailing: String? = "...") -> **func truncated(to length: Int, trailing: String?)**

- **UIButtonExtensions**:
    - func imageForAllStates(image: UIImage) -> **func setImageForAllStates(_ image: UIImage)**
    - func titleColorForAllStates(color: UIColor) -> **func setTitleColorForAllStates(_ color: UIColor)**
    - func titleForAllStates(title: String) -> **func setTitleForAllStates(_ title: String)**


- **UIColorExtensions**:
    - init(netHex:Int) -> **init(hex:Int, transparency: CGFloat = 1)**

- **UIImageExtensions**:
    - func scaledToHeight(height: CGFloat, with orientation: UIImageOrientation?) -> **scaled(toHeight: CGFloat, with orientation: UIImageOrientation?)**
    - func scaledToWidth(width: CGFloat, with orientation: UIImageOrientation?) -> **scaled(toWidth: CGFloat, with orientation: UIImageOrientation?)**

- **UIImageViewExtensions**:
    - func download(fromUrl: String?, contentMode: UIViewContentMode, placeHolder: UIImage?)) -> **download(from: URL?, contentMode: UIViewContentMode, placeHolder: UIImage?, completionHandler: ((UIImage?, Error?) -> Void)?)**

- **UISliderExtensions**:
    - func setValue(value: Float, animated: Bool, duration: TimeInterval, completion: (() -> Void)? = nil) -> **func setValue(_ value: Float, animated: Bool, duration: TimeInterval, completion: (() -> Void)?)**

- **UITableViewExtensions**:
    - var totalRows -> **var numberOfRows**

- **UITextFieldExtensions**:
    - func setPlaceHolderTextColor(color: UIColor) -> **func setPlaceHolderTextColor(_ color: UIColor)**

- **UIViewExtensions**:
    - func loadFromNibNamed(nibNamed: String, bundle : Bundle?) -> **func loadFromNib(named: String, bundle : Bundle?)**

### Removed Extensions:

- **StringExtensions**:
     - var locale

---

## v1.1

UISearchBarExtensions:
- **textField**: Return the text field inside search bar

UITextFieldExtensions:
- **setPlaceHolderTextColor(color)**: Change place holder text color
- **leftViewTintColor**: Left view tint color
- **rightViewTintColor**: Right view tint color

UINavigationItemExtensions:
- **replaceTitle(with image)**: Replace title with an image in naivgation item

UITabBarExtensions:
- **setColors(background, selectedBackground, item, selectedItem)**: Change UITabBar colors

UIImageExtensions:
- **filled(withColor)**: Return image filled with color
- **init(color, size)**: Create image from color and size

UITextViewExtensions:
- **scrollToBotom()**: Scroll to the bottom of text view
- **scrollToTop()**: Scroll to the top of text view

UISegmentedControlExtensions:
- **segmentTitles**: Segments titles
- **segmentImages**: Segments images

UISliderExtensions:
- **setValue(value, animated, duration, completion)**: Set slide bar value with completion handler

UIAlertControllerExtensions:
- **show(vibrate)**: Added optional vibration while presenting the alert

IntExtensions:
- **asLocaleCurrency**: Return string with number and current locale currency

FloatExtensions:
- **asLocaleCurrency**: Return string with number and current locale currency

DoubleExtensions:
- **asLocaleCurrency**: Return string with number and current locale currency

StringExtensions:
- Fixed a bug in toDouble, toFloat, toFloat32, toFloat64 where number is not calculated if not in English

DateExtensions:
- **adding(component, value)**: Return date by adding a component
- **nearestHourQuarter**: Return the nearest quarter to date
- **nearestHalfHour**: Return nearest half hour to date
- **changing(component, value)**: Return date by changing a component
- Fixed a bug in nearestFiveMinutes, nearestTenMinutes where date was always rounded always to next 5, 10 mins

---

## v1.0.4

UILabelExtensions:
- **requiredHeight**: Return required height for a label

UIImageViewExtensions:
- **blur(withStyle: UIBlurEffectStyle)**: Make image view blurry
- **blurred(withStyle: UIBlurEffectStyle)**: Return a blurred version of an image view

UINavigationControllerExtensions:
- **makeTransparent(withTint: UIColor)**: Make navigation controller's navigation bar transparent

UINavigationBarExtensions:
- **makeTransparent(withTint: UIColor)**: Make navigation controller's navigation bar transparent

UITextFieldExtensions:
- **trimmedText**: Return text with no spaces or new lines in beginning and end

UIViewExtensions:
- **addShadow(ofColor, radius, offset, opacity)**: /// Add shadow to view

UIImageExtensions:
- **filled(withColor)**: Return image filled with color

DateExtensions:
- **nearestFiveMinutes**: Return nearest five minutes to date
- **nearestTenMinutes**: Return nearest ten minutes to date

UIViewExtensions:
- **shake**: Completion handler added to shake function
