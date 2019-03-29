# Contributing Guidelines

This document contains information and guidelines about contributing to this project. Please read it before you start participating.

**Topics**

- [Asking Questions](#asking-questions)
- [Ways to Contribute](#ways-to-contribute)
- [Adding new Extensions](#adding-new-extensions)
- [Adding Tests](#adding-tests)
- [Adding documentation](#adding-documentation)
- [Adding changelog entries](#adding-changelog-entries)
- [Reporting Issues](#reporting-issues)


---


## Asking Questions

We don't use GitHub as a support forum.
For any usage questions that are not specific to the project itself, please ask on [Stack Overflow](https://stackoverflow.com) instead with the tag SwifterSwift.
By doing so, you'll be more likely to quickly solve your problem, and you'll allow anyone else with the same question to find the answer.
This also allows us to focus on improving the project for others.


---


## Ways to Contribute

You can contribute to the project in a variety of ways:

- Improve documentation 🙏
- Add more extensions 👍
- Add missing unit tests 😅
- Fixing or reporting bugs 😱

If you're new to Open Source or Swift the SwifterSwift community is a great place to get involved.

**Your contribution is always welcomed, no contribution is too small.**


---


## Adding new Extensions

Please refer to the following rules before submitting a pull request with your new extensions:

- Make sure no similar extension already exist in SwifterSwift.
- Add your contributions to [**master branch**](https://github.com/SwifterSwift/SwifterSwift/tree/master):
	- by doing this we can merge new pull-requests into **master** branch as soon as they are accepted, and add them to the next releases once they are fully tested.
- Mention the original source of extension source (if possible) as a comment inside extension:

 ```swift
public extension SomeType {

    public name: SomeType {
        // https://stackoverflow.com/somepage
        // .. code
    }

}
 ```

- A pull request should only add one extension at a time.
- Do not use an existing SwifterSwift extension inside another SwifterSwift extension. All extensions should be able to be copied and pasted and work immediately without having to copy another extension.
- All extensions should follow [Swift API Design Guidelines](https://developer.apple.com/videos/play/wwdc2016/403/)
- Always declare extensions as **public**.
- All extensions names should be as clear as possible.
- All extensions should be well documented. see [Adding documentation](#adding-documentation)
- Avoid using custom classes and objects the goal for this library is to extend the standards types available natively in Swift, iOS, macOS, watchOS, tvOS and Linux.
- Extensions could be:
 	- Enums
	- Instance properties & type properties
	- Instance methods & type methods
	- Initializers
	- Structs
- All extensions should be tested. See [Adding Tests](#adding-tests) to know more.
- Files are named based on the type that the contained extensions extend.
   - (example: all String extensions are found in "**StringExtensions.swift**" file)
- Add [subspec](https://github.com/SwifterSwift/SwifterSwift/blob/master/SwifterSwift.podspec) if you submit extensions for a module that is not presented in podspec file yet.
- Extensions and tests are ordered inside files in the following order:

```swift
// MARK: - enums
public enum {
    // ...
}

// MARK: - Properties
public extension SomeType {}

// MARK: - Methods
public extension SomeType {}

// MARK: - Initializers
public extension SomeType {}
```

---

## Adding Tests

Please follow these guidelines before submitting a pull request with new tests:

- Every extended SwifterSwift type should have one specific subclass of XCTestCase.
- There should be a one to one relationship between methods/properties and their backing tests.
- Tests should be named using the same API of the extension it backs.
   - (example: `DateExtensions` method `isBetween` is named `testIsBetween`)
- All test files are named based on the extensions which it tests.
   - (example: all String extensions tests are found in "**StringExtensionsTests.swift**" file)
- The subclass should be marked as final.
- All extensions files and test files have a one to one relationship.
   - (example: all tests for "**StringExtensions.swift**" are found in the "**StringExtensionsTests.swift**" file)
- SwifterSwift source files should not be added to the test target directly, but you should rather import SwifterSwift into the test target by using: @testable import SwifterSwift
- Tests are ordered inside files in the same order as extensions. See [Adding new Extensions](#adding-new-extensions) to know more.

---

## Adding documentation

Use the following template to add documentation for extensions
> Replace placeholders inside <>

> Remove any extra lines, eg. if method does not return any value, delete the `- Returns:` line

#### Documentation template for units with single parameter:

```swift
/// SwifterSwift: <Description>.
///
///    <Example Code>
///
/// - Parameter <Paramenter>: <Description>.
/// - Throws: <Error>
/// - Returns: <Description>
```


#### Documentation template for units with multiple parameters:

```swift
/// SwifterSwift: <Description>.
///
///    <Example Code>
///
/// - Parameters:
///   - <Paramenter>: <Description>.
///   - <Paramenter>: <Description>.
/// - Throws: <Error>
/// - Returns: <Description>
```


#### Documentation template for enums:

```swift
/// SwifterSwift: <Description>.
///
/// - <Case1>: <Description>
/// - <Case2>: <Description>
/// - <Case3>: <Description>
/// - <Case4>: <Description>
```

#### Documentation Examples:

```swift

/// SwifterSwift: Sum of all elements in array.
///
///    [1, 2, 3, 4, 5].sum() -> 15
///
/// - Returns: Sum of the array's elements.
func sum() -> Element {
    // ...
}

/// SwifterSwift: Date by changing value of calendar component.
///
/// - Parameters:
///   - component: component type.
///   - value: new value of component to change.
/// - Returns: original date after changing given component to given value.
func changing(_ component: Calendar.Component, value: Int) -> Date? {
    // ...
}

```

#### Power Tip:

In Xcode select a method and press `command` + `alt` + `/` to create a documentation template!


---


## Adding changelog entries

The [Changelog](https://github.com/SwifterSwift/SwifterSwift/blob/master/CHANGELOG.md) is a file which contains a curated, chronologically ordered list of notable changes for each version of a project. Please make sure to add a changelog entry describing your contribution to it every time there is a notable change.

The [Changelog Guidelines](https://github.com/SwifterSwift/SwifterSwift/blob/master/CHANGELOG_GUIDELINES.md) contains instructions for maintaining (or adding new entries) to the Changelog.


---


## Reporting Issues
A great way to contribute to the project is to send a detailed issue when you encounter a problem.
We always appreciate a well-written, thorough bug report.

Check that the project [issues page](https://github.com/SwifterSwift/SwifterSwift/issues) doesn't already include that problem or suggestion before submitting an issue.
If you find a match, add a quick "**+1**" or "**I have this problem too**".
Doing this helps prioritize the most common problems and requests.

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
