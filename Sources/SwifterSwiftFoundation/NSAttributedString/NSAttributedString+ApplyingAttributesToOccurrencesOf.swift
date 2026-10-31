// NSAttributedString+ApplyingAttributesToOccurrencesOf.swift - Copyright 2026 SwifterSwift

#if canImport(Foundation)
import Foundation

public extension NSAttributedString {
    /// SwifterSwift: Returns a copy with the given attributes added to every occurrence of a substring.
    ///
    /// The target is matched literally, character by character, like `String.ranges(of:)`: it's case-sensitive,
    /// characters such as `.` or `\` have no special meaning, and a match must start and end on a `Character` boundary,
    /// so searching for "🇸🇫" in "🇺🇸🇫🇷" finds nothing. Occurrences don't overlap: "aa" occurs twice in "aaaa", not three
    /// times. An empty target matches nothing. The original string isn't modified.
    ///
    /// ```swift
    /// let text = NSAttributedString(string: "Swift, Swifter, SwifterSwift")
    /// let underline: [NSAttributedString.Key: Any] = [.underlineStyle: NSUnderlineStyle.single.rawValue]
    /// let styled = text.applying(attributes: underline, toOccurrencesOf: "Swifter")
    /// // "Swifter" is underlined twice: in "Swifter" and at the start of "SwifterSwift".
    /// ```
    ///
    /// - Parameters:
    ///   - attributes: The attributes to add to each occurrence.
    ///   - target: The text to look for.
    /// - Returns: A copy of the string with `attributes` applied to every occurrence of `target`.
    /// - Complexity: O(*n* × *m*), where *n* is the length of the string and *m* is the length of `target`.
    func applying(
        attributes: [NSAttributedString.Key: Any],
        toOccurrencesOf target: some StringProtocol
    ) -> NSAttributedString {
        let result = NSMutableAttributedString(attributedString: self)
        guard !target.isEmpty else { return result }
        let text = string
        for range in text.ranges(of: target) {
            result.addAttributes(attributes, range: NSRange(range, in: text))
        }
        return result
    }
}
#endif
