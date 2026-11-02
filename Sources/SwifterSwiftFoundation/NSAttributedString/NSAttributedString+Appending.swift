// NSAttributedString+Appending.swift - Copyright 2026 SwifterSwift

#if canImport(Foundation)
import Foundation

public extension NSAttributedString {
    /// SwifterSwift: Returns a new attributed string made of this string followed by the given attributed string.
    ///
    /// Each part keeps its own attributes, and neither string is modified. The SDK only has the mutating `append(_:)`
    /// on `NSMutableAttributedString`; `AttributedString` has `+` and `append(_:)` of its own.
    ///
    /// ```swift
    /// let bold: [NSAttributedString.Key: Any] = [.font: UIFont.boldSystemFont(ofSize: 17)]
    /// let greeting = NSAttributedString(string: "Hello, ")
    /// let text = greeting.appending(NSAttributedString(string: "world", attributes: bold))
    /// text.string  // "Hello, world", with a bold "world"
    /// ```
    ///
    /// - Parameter other: The attributed string to add at the end.
    /// - Returns: The two strings joined, each with its own attributes.
    /// - Complexity: O(*n* + *m*), where *n* and *m* are the lengths of the two strings.
    func appending(_ other: NSAttributedString) -> NSAttributedString {
        let result = NSMutableAttributedString(attributedString: self)
        result.append(other)
        return result
    }

    /// SwifterSwift: Returns a new attributed string with the given text appended, styled like the end of this one.
    ///
    /// The text takes all the attributes of the last character of this string, as if it were typed at the end, so it
    /// also continues a link or any other attribute there. When this string is empty, the text has no attributes. To
    /// add text without attributes, pass `NSAttributedString(string:)` to `appending(_:)` instead. The original string
    /// isn't modified.
    ///
    /// ```swift
    /// let bold: [NSAttributedString.Key: Any] = [.font: UIFont.boldSystemFont(ofSize: 17)]
    /// let text = NSAttributedString(string: "Hello", attributes: bold).appending(", world")
    /// text.string  // "Hello, world", all bold
    /// ```
    ///
    /// - Parameter string: The text to add at the end.
    /// - Returns: The attributed string followed by `string`, which has the attributes of its last character.
    /// - Complexity: O(*n* + *m*), where *n* and *m* are the lengths of the two strings.
    func appending(_ string: String) -> NSAttributedString {
        let result = NSMutableAttributedString(attributedString: self)
        let inherited = length > 0 ? attributes(at: length - 1, effectiveRange: nil) : [:]
        result.append(NSAttributedString(string: string, attributes: inherited))
        return result
    }
}
#endif
