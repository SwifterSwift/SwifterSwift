// NSAttributedString+ApplyingAttributesToRangesMatchingOptions.swift - Copyright 2026 SwifterSwift

#if canImport(Foundation)
import Foundation

public extension NSAttributedString {
    /// SwifterSwift: Returns a copy with the given attributes added to every match of a regular expression.
    ///
    /// The pattern uses `NSRegularExpression` syntax and is matched against the whole string. An invalid pattern throws
    /// instead of being ignored, and a pattern with no matches returns an unchanged copy. Matches of zero length, such as
    /// those of `x*`, have no text to style and are skipped. The original string isn't modified.
    ///
    /// ```swift
    /// let text = NSAttributedString(string: "Call 555-0100 or 555-0199")
    /// let underline: [NSAttributedString.Key: Any] = [.underlineStyle: NSUnderlineStyle.single.rawValue]
    /// let styled = try text.applying(attributes: underline, toRangesMatching: #"\d{3}-\d{4}"#)
    /// // Both phone numbers are underlined.
    ///
    /// try text.applying(attributes: [:], toRangesMatching: "(")  // Throws, the pattern is invalid.
    /// ```
    ///
    /// - Parameters:
    ///   - attributes: The attributes to add to each match.
    ///   - pattern: The regular expression to match, in `NSRegularExpression` syntax.
    ///   - options: The options to compile the regular expression with, such as `.caseInsensitive`. The default is none.
    /// - Returns: A copy of the string with `attributes` applied to every match of `pattern`.
    /// - Throws: The error from `NSRegularExpression` if `pattern` isn't a valid regular expression.
    /// - Complexity: O(*n*) to find the matches of a typical pattern, where *n* is the length of the string, plus the
    ///   cost of applying the attributes to each match.
    func applying(
        attributes: [NSAttributedString.Key: Any],
        toRangesMatching pattern: String,
        options: NSRegularExpression.Options = []
    ) throws -> NSAttributedString {
        let expression = try NSRegularExpression(pattern: pattern, options: options)
        let result = NSMutableAttributedString(attributedString: self)
        let matches = expression.matches(in: string, options: [], range: NSRange(location: 0, length: length))
        for match in matches where match.range.length > 0 {
            result.addAttributes(attributes, range: match.range)
        }
        return result
    }
}
#endif
