# CHANGELOG
SwifterSwift adheres to [Semantic Versioning](http://semver.org/) for all versions after v1.6.4.

All notable changes to this project will be documented in this file.

# Versions

> # Next Release
>
> ### API Breaking
> N/A
>
> ### Enhancements
> N/A
>
> ### Bugfixes
> N/A


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
  - added `asMonospacedDigitFont() -> UIFont` method to get the current font as monospaced digit font. [#250](https://github.com/SwifterSwift/SwifterSwift/pull/250) by [BennX](https://github.com/BennX), [Monospaced Font explanation](https://en.wikipedia.org/wiki/Monospaced_font)

- **UITableView**
  - `dequeueReusableCell` now returns an optional
  - `dequeueReusableHeaderFooterView` now returns an optional
- **UICollectionView**
  - `dequeueReusableCell` now returns an optional
  - `dequeueReusableSupplementaryView` now returns an optional
- **UIAlertController**
  - Added `preferredStyle: UIAlertControllerStyle = .alert` to `init from error`.

### Bugfixes
- **SwifterSwift**
  - `didTakeScreenShot` now returns the notification, make sure to remove listener when you don't need it anymore.


# v3.2.0

### API Breaking
- **Swift 3.2**
  - Code has been updated to Swift 3.2, please use [`v3.1.1`](https://github.com/SwifterSwift/SwifterSwift/releases/tag/3.1.1) if you are still using Swift 3 or Xcode 8
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
  - added `secondsSince(_ date: Date)` method to get number of seconds between two date.
  - added `minutesSince(_ date: Date)` method to get number of minutes between two date.
  - added `hoursSince(_ date: Date)` method to get number of hours between two date.
  - added `daysSince(_ date: Date)` method to get number of days between two date.
  - added `isInThisYear` property to check if date is in the current year.
  - added `isInThisMonth` property to check if date is in the current month.
  - added `isInThisWeek` property to check if date is in the current week.
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
    - new `firstIndex` and `lastIndex` that return the (first or last) index where condition is true .
    - new `indexes` extention that return indexes where condition is true .
    - new `all` and `none` that checks if (all or none) of array elements matches condition.
    - new `last` extension to find the last element that matches condition.
    - new `reject` extension to filter elements that **not** matches condition.
    - new `count` extension to count elements that matches condition.
    - new `forEachReversed` extension to iterate over array in reverse order.
    - new `accumulate` extension to reduces an array while returning each interim combination.
    - new `forEach` with condition to a filtered interation over the array.
    - new `keep` extention to keep all elements that in order are until the condition is false.
    - new `take` extension that returns all elements that in order are until the condition is false.
    - new `skip` extension that returns all elements that in order are after the condition is false.
    - new `filtered:map` extension to perform a map and filter operation in just one iteration.
- New **Character** extensions
    - added isLetter & isWhiteSpace extensions
    - new lowercased extension to lower case the character
    - new uppercased extension to upper case the character
- New **Date** extensions
    - new `isInWeekday` extension to check if date is within a weekday period
- New **Dictionary** extensions
    - new `removeAll` extension to remove the values for all keys in a array.
    - new + operator to merge to dictionaries in a new one and += to merge one dictionary into another.
    - new - operator to get a new dictionary with the values for all keys in a array removed and -= to remove the values for all keys in a array.
- New **String** extensions
    - new `matches` extension to check if string matches a regex pattern.
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

This release has drastically increased test coverage: currently 92% .
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
    - added `safeSwap` method as a fail safe way to swap to elements in an array

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
    - `removeDuplicates` renamed to `duplicatesRemoved`
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
With over 100 new extensions, improved Cocoa support, new tests and many minor bug fixes.

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

- Extension moved to Source directory, tests moved to Tests directory for a cleaner structure

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

Fixed a bug in DateExtensinos where year was not set correctly. Thanks to [songhailiang](https://github.com/songhailiang) you for reporting this bug.

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

- removed duplicated contains method
- use of reduce to remove duplicates (Thanks to [sairamkotha](https://github.com/sairamkotha))

---

# v1.3

This version adds **more than 90 new extensions** making it the widest extensions library available online for Swift 3 with **more than 360 properties and methods for more than 35 type**.
This is the biggest update since library launch! we're so excited 🤓

Here are some changes:
- Updated some properties and methods names to follow [Swift API Design Guidelines](https://developer.apple.com/videos/play/wwdc2016/403/).
- Added default values to methods parameters (where possible).
- All units documentation has been re-written in xcode,
    - Now you see "**SwifterSwift:** " at the beginning of description to know the source of the extension while writing your code.
    - All method parameters and return types has been documented in xcode as well.
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
- Fixed a bug in toDouble, toFloat, toFloat32, toFloat64 where number is not calculated if not in english

DateExtensions:
- **adding(component, value)**: Return date by adding a component
- **nearestHourQuarter**: Return nearest quarter to date
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
