# Contributing to SwifterSwift

Thanks for helping. Every extension in SwifterSwift follows the same rules. Together they make sure any single extension can be copied into a project and just work.

## Ways to contribute

- Improve the documentation.
- Add an extension.
- Add missing tests or edge cases.
- Report or fix a bug.

If you're new to open source or to Swift, SwifterSwift is a good place to start. No contribution is too small.

## Asking questions

GitHub issues are for bugs and extension proposals, not support. For questions about using SwifterSwift, start a thread in [GitHub Discussions](https://github.com/SwifterSwift/SwifterSwift/discussions), where others with the same question can find the answer too.

## Reporting issues

A detailed bug report is one of the most useful contributions. First, check the [issues](https://github.com/SwifterSwift/SwifterSwift/issues) to see whether someone has already reported it; if so, add your details there.

To report a security vulnerability, don't open an issue; follow the [security policy](.github/SECURITY.md) instead.

When you open an issue, include:

- what you did, what you expected, and what happened instead, ideally with a small code sample;
- the SwifterSwift, Xcode and Swift versions;
- the platform and OS version the code runs on.

## What makes a good extension

An extension belongs in SwifterSwift when it:

- **Fills a real gap.** The standard library, Foundation and Apple's frameworks don't already provide it. Check the latest SDKs first; Apple adds APIs every year.
- **Is more than a rename.** A one-liner is welcome only when the SDK spelling is awkward or easy to get wrong.
- **Is correct for every input.** It handles empty values, Unicode, locales, time zones and extreme numbers, and it never crashes.
- **Has a clear name.** It follows the [Swift API Design Guidelines](https://www.swift.org/documentation/api-design-guidelines/), and the name is unlikely to collide with an API Apple might add later.

## The rules

1. **One extension per file.** A file contains exactly one public member: a property, method, initializer or subscript. Overloads of the same member, such as the same method for `Int` and `Double`, may share a file.
2. **Self-contained.** An extension may only use the standard library and Apple's frameworks. It must not call another SwifterSwift extension. Prefer duplicating a few lines over sharing code.
3. **Nothing but the extension.** A file must not declare types (top-level or nested), typealiases, protocols, global functions or variables, private helpers, or protocol conformances on types you don't own.
4. **No operators.** Don't declare new operators or overload existing ones. Use a method with a descriptive name instead, for example `point.adding(other)`.
5. **No crashes.** No force unwrapping, `try!`, implicitly unwrapped optionals or `fatalError`. Return an optional, or throw, when an input is invalid.
6. **No hidden state.** Don't read global or shared state, such as `Calendar.current`, `Locale.current` or `UIApplication.shared`, behind the caller's back. Take it as a parameter, with the current value as its default.
7. **Every platform it can run on.** Wrap the file in `#if canImport(…)` for its framework, exclude platforms where the extended type doesn't exist, and add `@available` when an API needs a newer OS than the package minimum.
8. **Documented and tested.** See below.

## Where files go

| Extends | Module | Guard |
|---|---|---|
| Swift standard library | `Sources/SwifterSwiftStdlib` | None |
| Foundation | `Sources/SwifterSwiftFoundation` | `#if canImport(Foundation)` |
| Core Graphics, Core Animation | `Sources/SwifterSwiftCoreGraphics` | `#if canImport(CoreGraphics)` or `#if canImport(QuartzCore)` |
| UIKit | `Sources/SwifterSwiftUIKit` | `#if canImport(UIKit)`, plus `&& !os(watchOS)` or `&& !os(tvOS)` for types or APIs those platforms don't have |
| AppKit | `Sources/SwifterSwiftAppKit` | `#if canImport(AppKit) && !targetEnvironment(macCatalyst)` |
| Core Location | `Sources/SwifterSwiftCoreLocation` | `#if canImport(CoreLocation)` |
| MapKit | `Sources/SwifterSwiftMapKit` | `#if canImport(MapKit)`, plus `&& !os(watchOS)` for `MKMapView` |
| SpriteKit | `Sources/SwifterSwiftSpriteKit` | `#if canImport(SpriteKit)` |
| CryptoKit | `Sources/SwifterSwiftCryptoKit` | `#if canImport(CryptoKit)` |
| HealthKit | `Sources/SwifterSwiftHealthKit` | `#if canImport(HealthKit) && !os(tvOS)` |

Check the SDK headers rather than guessing which platforms have a type, and run the tests on tvOS too: some APIs that compile there raise an exception at runtime.

Name files after the extended type and the member, in a folder named after the type:

| Member | Source file | Test file |
|---|---|---|
| `Collection[safe:]` | `Collection/Collection+SubscriptSafe.swift` | `Collection/Collection+SubscriptSafeTests.swift` |
| `URL.queryValue(for:)` | `URL/URL+QueryValue.swift` | `URL/URL+QueryValueTests.swift` |
| `CGRect.center` | `CGRect/CGRect+Center.swift` | `CGRect/CGRect+CenterTests.swift` |
| `CGRect.init(center:size:)` | `CGRect/CGRect+InitCenter.swift` | `CGRect/CGRect+InitCenterTests.swift` |

The member part of the name is its base name in UpperCamelCase:

- Initializers start with `Init`, and subscripts with `Subscript`, followed by the first argument label.
- When two members share a base name but differ in argument labels, add the labels that tell them apart, as in `Sequence+SortedBy.swift` and `Sequence+SortedByAnd.swift`.
- A nested type gets a folder with its full name, as in `Locale.Region/Locale.Region+FlagEmoji.swift`.

Test files mirror the source path under `Tests/SwifterSwift<Area>Tests`.

## Anatomy of an extension

```swift
// URL+QueryValue.swift - Copyright 2026 SwifterSwift

#if canImport(Foundation)
import Foundation

public extension URL {
    /// SwifterSwift: Returns the value of the first query item with the given name.
    ///
    /// Names are matched exactly, so the lookup is case-sensitive. Values are percent-decoded, but a `+` is kept as is
    /// and isn't treated as a space.
    ///
    /// ```swift
    /// let url = URL(string: "https://example.com/search?q=Swifter%20Swift&page=2")!
    /// url.queryValue(for: "q")  // "Swifter Swift"
    /// url.queryValue(for: "sort")  // nil
    /// ```
    ///
    /// - Parameter name: The name of the query item to look up.
    /// - Returns: The decoded value of the first query item named `name`, or `nil` if the URL has no such item.
    func queryValue(for name: String) -> String? {
        URLComponents(url: self, resolvingAgainstBaseURL: false)?
            .queryItems?
            .first { $0.name == name }?
            .value
    }
}
#endif
```

In order, a file has:

1. A header comment with the file name.
2. The platform guard, and the imports the extension needs. Import every module whose API you use, even one that another import brings in indirectly.
3. One `public extension`, with `@available` if needed, containing one member. Overloads of that member that need different constraints, such as one for `Equatable` elements and a faster one for `Hashable` elements, may each have their own `public extension` in the same file.

## Documentation

Every extension has a documentation comment with:

- A one-sentence summary that starts with `SwifterSwift:`, ends with a period and fits on one line, followed by a blank `///` line.
- A discussion of anything surprising: edge cases, what happens with invalid input, how the extension relates to similar APIs in the SDK.
- At least one example in a fenced `swift` code block, with results shown as `// result` comments.
- A `- Parameter` / `- Parameters:` entry for every named parameter, `- Returns:` when the member returns a value, and `- Throws:` when it throws.
- A `- Complexity:` section for anything that isn't O(1).

`scripts/check-docs.py` checks all of these except the discussion and complexity, and CI runs it on every pull request.

## Tests

- Use [Swift Testing](https://developer.apple.com/documentation/testing): `import Testing`, `@Test` and `#expect`. Use `try #require` instead of force unwrapping.
- Put the tests for each extension in their own file and suite, mirroring the source path.
- Cover the edge cases, not just a typical value: empty input, the first and last elements, invalid indices, Unicode, negative numbers and `.min` / `.max`, and different locales and time zones. Use parameterized tests (`@Test(arguments:)`) for tables of inputs.
- Use the same platform guard as the extension, and mark tests that touch UI types `@MainActor`.
- Tests must not use the network, the file system outside a temporary directory, or the device's locale or time zone.
- `Int`, `UInt` and `CGFloat` are 32 bits on Apple Watch hardware. In tests, use `Int64` or `UInt64` for values beyond the 32-bit range, and compare against values like `Int.max.magnitude` rather than hard-coded 64-bit numbers.
- Fonts and some UIKit APIs differ by platform; tvOS, for example, has no Zapfino font and no `systemBackground` color. Compare against UIKit's own behavior, or guard platform-specific tests with `#if` and a comment explaining why.

## Before opening a pull request

To format staged Swift files automatically on every commit, install the pre-commit hook once:

```bash
ln -sf ../../scripts/pre-commit .git/hooks/pre-commit
```

Then make sure everything is formatted, lints cleanly, builds and passes:

```bash
swift format --in-place --recursive --parallel Package.swift Sources Tests
```

```bash
swift format lint --strict --recursive --parallel Package.swift Sources Tests
```

```bash
swift build --build-tests
```

```bash
swift test
```

Then run the same checks CI runs on every pull request:

```bash
scripts/check-structure.sh
```

```bash
python3 scripts/check-docs.py
```

```bash
scripts/check-standalone.sh Sources/SwifterSwiftStdlib/Collection/Collection+SubscriptSafe.swift
```

The last one type-checks each file you pass on its own for every Apple platform, proving it can be copied into a project as is. Pass the files you added or changed; with no arguments it checks every extension, which takes a few minutes. CI runs it with Xcode 26.0, the oldest supported Xcode, so code that only newer compilers accept fails there even if it passes on your Mac.

UIKit extensions are tested on an iOS simulator. Open `Package.swift` in Xcode and run the tests for an iOS destination, or use `xcodebuild test -scheme SwifterSwift-Package -destination "platform=iOS Simulator,name=<device>"`.

## Code of conduct

This project follows the [Contributor Covenant](.github/CODE_OF_CONDUCT.md). By participating, you agree to uphold it.
