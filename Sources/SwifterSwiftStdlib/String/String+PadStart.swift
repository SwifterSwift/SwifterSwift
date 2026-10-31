// String+PadStart.swift - Copyright 2026 SwifterSwift

public extension String {
    /// SwifterSwift: Pads the string at the start to the given length, by repeating another string.
    ///
    /// The padding string is repeated as many times as needed and cut to fit, so the string becomes exactly `length`
    /// characters long. If the string is already at least `length` characters long, or the padding string is empty,
    /// nothing changes; the string is never shortened. Lengths count characters as the user sees them.
    ///
    /// ```swift
    /// var code = "42"
    /// code.padStart(5, with: "0")
    /// code  // "00042"
    /// ```
    ///
    /// - Parameters:
    ///   - length: The length the string should have, in characters.
    ///   - string: The string to repeat at the start. The default is a single space.
    /// - Complexity: O(*m*), where *m* is the larger of `length` and the length of the string.
    mutating func padStart(_ length: Int, with string: String = " ") {
        let currentLength = count
        let padLength = string.count
        guard length > currentLength, padLength > 0 else { return }
        let missing = length - currentLength
        self = String(repeating: string, count: missing / padLength) + string.prefix(missing % padLength) + self
    }
}
