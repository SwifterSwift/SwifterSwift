// String+PaddingStart.swift - Copyright 2026 SwifterSwift

public extension String {
    /// SwifterSwift: Returns the string padded at the start to the given length, by repeating another string.
    ///
    /// The padding string is repeated as many times as needed and cut to fit, so the result is exactly `length`
    /// characters long. If the string is already at least `length` characters long, or the padding string is empty, the
    /// string is returned unchanged; it's never shortened. Lengths count characters as the user sees them.
    ///
    /// Foundation's `padding(toLength:withPad:startingAt:)` pads only at the end, and also truncates longer strings.
    ///
    /// ```swift
    /// "42".paddingStart(5, with: "0")  // "00042"
    /// "hue".paddingStart(10, with: "br")  // "brbrbrbhue"
    /// "hue".paddingStart(6)  // "   hue"
    /// "hue".paddingStart(2)  // "hue"
    /// ```
    ///
    /// - Parameters:
    ///   - length: The length of the result, in characters.
    ///   - string: The string to repeat at the start. The default is a single space.
    /// - Returns: The padded string, or the original string if it doesn't need padding.
    /// - Complexity: O(*m*), where *m* is the larger of `length` and the length of the string.
    func paddingStart(_ length: Int, with string: String = " ") -> String {
        let currentLength = count
        let padLength = string.count
        guard length > currentLength, padLength > 0 else { return self }
        let missing = length - currentLength
        return String(repeating: string, count: missing / padLength) + String(string.prefix(missing % padLength)) + self
    }
}
