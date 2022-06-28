# Contributing Guidelines

This document contains information and guidelines about contributing to this project. Please read it before you start participating.

**Topics**

- [Asking Questions](#asking-questions)
- [Ways to Contribute](#ways-to-contribute)
- [Adding new Extensions](#adding-new-extensions)
- [Reporting Issues](#reporting-issues)

---

## Asking Questions

We don't use GitHub as a support forum.
For any usage questions that are not specific to the project itself, please ask on [Stack Overflow](https://stackoverflow.com) instead, with the tag SwifterSwift.
By doing so, you'll be more likely to quickly solve your problem, and you'll allow anyone else with the same question to find the answer.
This also allows us to focus on improving the project for others.

---

## Ways to Contribute

You can contribute to the project in a variety of ways:

- Improve documentation 🙏
- Add more extensions 👍
- Add missing unit tests 😅
- Fix or report bugs 😱

If you're new to Open Source or Swift the SwifterSwift community is a great place to get involved.

**Your contribution is always welcomed, no contribution is too small.**

---

## Adding new Extensions

Please refer to the following rules before submitting a pull request with your new extensions:

- Make sure no similar extension already exists in SwifterSwift.
- Add your contributions to [**master branch**](https://github.com/SwifterSwift/SwifterSwift/tree/master), by doing so we can merge new pull requests as soon as they are accepted, and add them to the next releases once they are fully tested.
- A pull request should preferably only add **one extension** at a time.

For an extension to be suitable for SwifterSwift, it has to fulfill the following conditions:

### 1. Clarity
- Extension names should be in English and as clear as possible.
- Code should be readable and easy to reason about. Refer to [Swift’s API Design Guidelines]([https://www.swift.org/documentation/api-design-guidelines/](https://www.swift.org/documentation/api-design-guidelines/)) for more details.

### 2. No dependencies
- We do not allow 3rd party dependencies in SwifterSwift.
- Extensions can not rely on each other. We prefer code duplication over-abstraction in this project. That makes it easier to reason about a single extension individually.
- Ideally, copy-pasting any single extension into another codebase should be possible.

Allowed:

```swift
public extension Foo {
	var bar: Bar { ... }
}
```

Not allowed:

```swift
public extension Foo {
	func bar() -> Bar { /* ... */ }
	func baz() {
      let bar = bar()
      // ...
  }
}
```

### 3. Public extensions
- Extension should be **public**:

Example:
```swift
public extension Foo {
	var bar: Bar { ... }
}
```

- Avoid adding unnecessary `public` keywords for unites in an extension:

```swift
public extension Foo {
	public var bar: Bar { ... }
}
```

### 4. Examples of allowed code
- Basically, anything that can be expressed in a single extension and does not expose a new type is allowed.

Examples where `Foo` is the extended type:

Get-only property:
```swift
public extension Foo {
	var bar: Bar {
        // ...
    }
}
```

Static get-only property:

```swift
public extension Foo {
	static var bar: Bar {
        // ...
    }
}
```

Get/set property:

```swift
public extension Foo {
	var bar: Bar {
        get { /* ... */ }
        set { /* ... */ }

    }
}
```

Static get/set property:

```swift
public extension Foo {
	static var bar: Bar {
        get { /* ... */ }
        set { /* ... */ }

    }
}
```

Method:

```swift
public extension Foo {
	func bar() {
        // ...
    }
}
```

Static method:

```swift
public extension Foo {
	static func bar() {
        // ...
    }
}
```

Initializer:

```swift
public extension Foo {
    init(bar: Bar) {
        // ...
    }
}
```

Failable initializer:

```swift
public extension Foo {
    init?(bar: Bar) {
        // ...
    }
}
```

Operators and precedence groups:

```swift
precedencegroup PowerPrecedence { higherThan: MultiplicationPrecedence }
infix operator **: PowerPrecedence
public func ** (x: Decimal, y: Int) -> Decimal {
    return pow(x, y)
}
```

### 5. Examples of disallowed code
- Introducing new types, including protocols, classes, actors, structs, or enums.
- Protocol conformance. Example:

```swift
extension Foo: Codable {
    // ...
}
```

- Global functions (except operators):

```swift
public func bar() {
    // ...
}
```

- Introducing new types in an extension:

```swift
public extension Foo {
  struct Bar {
    // ...
  }
}
```

### 6. Documentation
- Extensions should be well documented with an example —if possible—.
- Documentation should always start with the prefix **SwifterSwift:**
- Extensions should be fully documented in English and as clear as possible.
- In Xcode select the extension and use the shortcut `command` + `alt` + `/` to create a documentation template. or use the following template:

```swift
/// SwifterSwift: <Description>.
///
///    <Example Code>
///
/// - Parameter <Parameter>: <Description>.
/// - Throws: <Error>
/// - Returns: <Description>
```

- Mention the source —if possible— as a comment inside the extension:

```swift
public extension Foo {
	var bar: Bar {
		// https://stackoverflow.com/...
		// ...
	}
}
```

### 7. Tested
- Every extended type should have a matching test case. Example:

For the following extension of type `Bar` defined in framework `Foo`:

> Sources/Foo/BarExtensions.swift

```swift
import Foo

public extension Bar {
    var baz: Baz { /* ... */ }
}
```

The matching test case is:

> Tests/Foo/BarExtensionsTests.swift

```swift
import Foo

final class BarExtensionsTests: XCTestCase {
    func testBaz() {
        // ...
    }
}
```

- There should be a one to one relationship between methods/properties and their backing tests.
- Tests should be named using the same API of the extension it backs, example: `DateExtensions`'s method `isBetween` is named `testIsBetween`.
- Test case classes should be marked as final.
- SwifterSwift source files should not be added to the test target directly, but you should rather import SwifterSwift into the test target by using: `@testable import SwifterSwift`

---

## Reporting Issues

A great way to contribute to the project is to send a detailed issue when you encounter a problem.
We always appreciate a well-written, thorough bug report.

Check that the project [issues page](https://github.com/SwifterSwift/SwifterSwift/issues) doesn't already include that problem or suggestion before submitting an issue.
If you find a match, add a quick "**+1**" or "**I have this problem too**". Doing this helps prioritize the most common problems and requests.

**When reporting issues, please include the following:**

- What did you do?
- What did you expect to happen?
- What happened instead?
- SwifterSwift version
- Xcode version
- macOS version running Xcode
- Swift version
- Platform(s) running SwifterSwift
- Demo Project (if available)

This information will help us review and fix your issue faster.

---

## [No Brown M&M's](http://en.wikipedia.org/wiki/Van_Halen#Contract_riders)

If you made it all the way to the end, bravo dear user, we love you. You can include the 🚀 emoji in the top of your ticket to signal to us that you did in fact read this file and are trying to conform to it as best as possible: `:rocket:`.
