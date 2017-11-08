//
//  SwiftStdlibDeprecated.swift
//  SwifterSwift
//
//  Copyright © 2016 SwifterSwift
//

extension String {
    /// SwifterSwift: Number of characters in string.
    ///
    ///        "Hello world!".length -> 12
    ///
    @available(*, deprecated: 4.1.0, message: "This extension is deprecated, please use .count instead.")
    public var length: Int {
        return count
    }
    
    /// SwifterSwift: Sliced string from a start index.
    ///
    ///        "Hello World".slicing(at: 6) -> "World"
    ///
    /// - Parameter i: string index the slicing should start from.
    /// - Returns: sliced substring starting from start index (if applicable) (example: "Hello world".slicing(at: 6) -> "world")
    @available(*, deprecated: 4.1.0, message: "Please use string[safe: i] instead.")
    public func slicing(at i: Int) -> String? {
        guard i < count else {
            return nil
        }
        return self[safe: i..<count]
    }
    
    /// SwifterSwift: Sliced string from a start index to an end index.
    ///
    ///        "Hello World".slicing(from: 6, to: 11) -> "World"
    ///
    /// - Parameters:
    ///   - start: string index the slicing should start from.
    ///   - end: string index the slicing should end at.
    /// - Returns: sliced substring starting from start index, and ends at end index (if applicable) (example: "Hello World".slicing(from: 6, to: 11) -> "World")
    @available(*, deprecated: 4.1.0, message: "Please use string[safe: start..<end] instead.")
    public func slicing(from start: Int, to end: Int) -> String? {
        guard end >= start else {
            return nil
        }
        return self[safe: start..<end]
    }
    
    /// SwifterSwift: First index of substring in string.
    ///
    ///        "Hello World!".firstIndex(of: "l") -> 2
    ///        "Hello World!".firstIndex(of: "s") -> nil
    ///
    /// - Parameter string: substring to search for.
    /// - Returns: first index of substring in string (if applicable).
    @available(*, deprecated: 4.1.0, message: "Please use string.index(of: Character) or string.range(of: StringProtocol) instead.")
    public func firstIndex(of string: String) -> Int? {
        return map({ String($0) }).index(of: string)
    }

    //

    /// SwifterSwift: Array of strings separated by given string.
    ///
    ///        "hello World".splited(by: " ") -> ["hello", "World"]
    ///
    /// - Parameter separator: separator to split string by.
    /// - Returns: array of strings separated by given string.
    @available(*, deprecated: 4.1.0, message: "Please use string.split(separator: Character) instead.")
    public func splitted(by separator: Character) -> [String] {
        return split { $0 == separator }.map(String.init)
    }
    
    /// SwifterSwift: Reversed string.
    ///
    ///        "foo".reversed() -> "oof"
    ///
    /// - Returns: The reversed string.
    @available(*, deprecated: 4.1.0, message: "Please use String(str.reversed()) or reversed() -> ReversedCollection<String> instead.")
    public func reversed() -> String {
        let chars: [Character] = reversed()
        return String(chars)
    }

}
