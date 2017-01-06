# Contributing Guidelines

This document contains information and guidelines about contributing to this project. Please read it before you start participating.

**Topics**

* [Asking Questions](#asking-questions)
* [Adding new Extensions](#adding-new-extensions)
* [Releases Flow](#releases-flow)
* [Reporting Issues](#reporting-issues)


## Asking Questions
We don't use GitHub as a support forum.
For any usage questions that are not specific to the project itself, please ask on [Stack Overflow](https://stackoverflow.com) instead with the tag **swifterswift**.
By doing so, you'll be more likely to quickly solve your problem, and you'll allow anyone else with the same question to find the answer.
This also allows maintainers to focus on improving the project for others.


## Releases Flow
Starting from v1.4.3 development branch is no more maintained, instead changes will be made to [**master branch**](https://github.com/omaralbeik/SwifterSwift/tree/master) directly and merged into [**stable branch**](https://github.com/omaralbeik/SwifterSwift/tree/stable) for stable releases

- All new extensions and accepted pull requests will be added to [**master branch**](https://github.com/omaralbeik/SwifterSwift/tree/master)
- Pull requests from master will be created and merged into [**stable branch**](https://github.com/omaralbeik/SwifterSwift/tree/stable) whenever there is a new stable release


## Adding new Extensions
SwifterSwift is a collection of extensions found on [Stack Overflow](https://stackoverflow.com), [Github](https://github.com), and the internet.
Its in its early stages, any new idea is appreciated and welcomed, however please refer to the following rules before submitting a pull request:

- Add your contributions to [**master branch** ](https://github.com/omaralbeik/SwifterSwift/tree/master):
	- by doing this we can merge new pull-requests into **master** branch as soon as they are accepted, and merge them into **stable branch** with next releases once they are fully tested.
- Add original place of extension source (if possible) as a comment inside extension:

 ```swift
 public extension SomeType {
	public name: SomeType {
			// https://stackoverflow.com/somepage
			// .. code
 	}
 }
 ```

- All extensions should follow [Swift API Design Guidelines](https://developer.apple.com/videos/play/wwdc2016/403/)
- Always declare extensions as **public**.
- All extensions names should be as clear as possible.
- All extensions should be well documented.
- Avoid using custom classes and objects the goal for this library is to extend the standards types available nativly in Swift, iOS, MacOS, WatchOS and tvOS.
- extensions could be:
 	- enums
	- Properties & static properties
	- Methods & static methods
	- Initializers
- Files are named based on the type that the contained extensions extend (example: all String extensions are found in "**StringExtensions.swift**" file)
- extensions are ordered inside files in the following order:

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

- Please add each extension in its appropriate place in the file.
- Please submit **only one commit** per pull-request.

## Reporting Issues
A great way to contribute to the project is to send a detailed issue when you encounter an problem.
We always appreciate a well-written, thorough bug report.

Check that the project issues database doesn't already include that problem or suggestion before submitting an issue.
If you find a match, add a quick "**+1**" or "**I have this problem too**".
Doing this helps prioritize the most common problems and requests.


**When reporting issues, please include the following:**

* The version of Xcode you're using
* The version of iOS you're targeting
* The full output of any stack trace or compiler error
* A code snippet that reproduces the described behavior, if applicable
* Any other details that would be useful in understanding the problem

This information will help us review and fix your issue faster.
