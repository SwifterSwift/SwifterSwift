// String+PadEnd.swift - Copyright 2026 SwifterSwift

public extension String {
    /// SwifterSwift: Pads the string at the end to the given length, by repeating another string.
    ///
    /// The padding string is repeated as many times as needed and cut to fit, so the string becomes exactly `length`
    /// characters long. If the string is already at least `length` characters long, or the padding string is empty,
    /// nothing changes; the string is never shortened. Lengths count characters as the user sees them.
    ///
    /// ```swift
    /// var label = "Name"
    /// label.padEnd(8, with: ".")
    /// label  // "Name...."
    /// ```
    ///
    /// - Parameters:
    ///   - length: The length the string should have, in characters.
    ///   - string: The string to repeat at the end. The default is a single space.
    /// - Complexity: O(*m*), where *m* is the larger of `length` and the length of the string.
    mutating func padEnd(_ length: Int, with string: String = " ") {
        let currentLength = count
        let padLength = string.count
        guard length > currentLength, padLength > 0 else { return }
        let missing = length - currentLength
        append(String(repeating: string, count: missing / padLength))
        append(contentsOf: string.prefix(missing % padLength))
    }
}
