// NSAttributedString+ApplyingAttributes.swift - Copyright 2026 SwifterSwift

#if canImport(Foundation)
import Foundation

public extension NSAttributedString {
    /// SwifterSwift: Returns a copy of the attributed string with the given attributes added to all of its text.
    ///
    /// An attribute that's already set somewhere in the string is replaced by the new value; every other attribute is
    /// kept. The original string isn't modified. For `AttributedString`, use `mergingAttributes(_:)` instead.
    ///
    /// ```swift
    /// let text = NSAttributedString(string: "Hello", attributes: [.kern: 2])
    /// let styled = text.applying(attributes: [.underlineStyle: NSUnderlineStyle.single.rawValue])
    /// styled.attributes(at: 0, effectiveRange: nil)  // [.kern: 2, .underlineStyle: 1]
    /// ```
    ///
    /// - Parameter attributes: The attributes to add to the whole string.
    /// - Returns: A copy of the string with `attributes` applied to its full range.
    /// - Complexity: O(*n*), where *n* is the number of attribute runs in the string.
    func applying(attributes: [NSAttributedString.Key: Any]) -> NSAttributedString {
        let result = NSMutableAttributedString(attributedString: self)
        result.addAttributes(attributes, range: NSRange(location: 0, length: result.length))
        return result
    }
}
#endif
