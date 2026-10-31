// Sequence+Joined.swift - Copyright 2026 SwifterSwift

#if canImport(Foundation)
import Foundation

public extension Sequence where Element: NSAttributedString {
    /// SwifterSwift: Returns the elements joined into one attributed string, with the given separator between them.
    ///
    /// Each element and each copy of the separator keeps its own attributes. An empty sequence gives an empty string,
    /// and a single element is returned as a copy, without the separator. Neither `NSAttributedString` nor
    /// `AttributedString` has a `joined(separator:)` of its own.
    ///
    /// ```swift
    /// let bold: [NSAttributedString.Key: Any] = [.font: UIFont.boldSystemFont(ofSize: 17)]
    /// let names = [NSAttributedString(string: "Ada"), NSAttributedString(string: "Grace")]
    /// let joined = names.joined(separator: NSAttributedString(string: " & ", attributes: bold))
    /// joined.string  // "Ada & Grace", with a bold " & "
    /// ```
    ///
    /// - Parameter separator: The attributed string to insert between each element.
    /// - Returns: The elements of the sequence joined by `separator`.
    /// - Complexity: O(*n*), where *n* is the total length of the elements and separators.
    func joined(separator: NSAttributedString) -> NSAttributedString {
        let result = NSMutableAttributedString()
        var isFirst = true
        for element in self {
            if !isFirst {
                result.append(separator)
            }
            result.append(element)
            isFirst = false
        }
        return result
    }

    /// SwifterSwift: Returns the elements joined into one attributed string, with a plain-text separator between them.
    ///
    /// Each element keeps its own attributes, and the separator has none: it doesn't take the attributes of the text
    /// around it. An empty sequence gives an empty string, and a single element is returned as a copy, without the
    /// separator.
    ///
    /// ```swift
    /// let names = [NSAttributedString(string: "Ada"), NSAttributedString(string: "Grace")]
    /// names.joined(separator: ", ").string  // "Ada, Grace"
    /// ```
    ///
    /// - Parameter separator: The text to insert between each element.
    /// - Returns: The elements of the sequence joined by `separator`.
    /// - Complexity: O(*n*), where *n* is the total length of the elements and separators.
    func joined(separator: String) -> NSAttributedString {
        let separator = NSAttributedString(string: separator)
        let result = NSMutableAttributedString()
        var isFirst = true
        for element in self {
            if !isFirst {
                result.append(separator)
            }
            result.append(element)
            isFirst = false
        }
        return result
    }
}
#endif
