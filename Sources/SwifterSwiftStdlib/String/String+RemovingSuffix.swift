// String+RemovingSuffix.swift - Copyright 2026 SwifterSwift

public extension String {
    /// SwifterSwift: Returns the string without the given suffix, or the string unchanged if it doesn't end with it.
    ///
    /// Only one occurrence is removed. The suffix is matched like `hasSuffix(_:)`: character by character, with
    /// canonically equivalent characters (such as a precomposed `é` and `e` followed by a combining accent) treated as
    /// equal, and case-sensitively.
    ///
    /// The standard library's `trimmingPrefix(_:)` covers the start of a string, but has no counterpart for the end.
    ///
    /// ```swift
    /// "photo.jpeg".removingSuffix(".jpeg")  // "photo"
    /// "photo.jpeg".removingSuffix(".png")  // "photo.jpeg"
    /// "tick tock".removingSuffix("TOCK")  // "tick tock"
    /// ```
    ///
    /// - Parameter suffix: The suffix to remove.
    /// - Returns: The string without `suffix` at its end, or the original string if it doesn't end with `suffix`.
    /// - Complexity: O(*n*), where *n* is the length of the string.
    func removingSuffix(_ suffix: String) -> String {
        guard hasSuffix(suffix) else { return self }
        return String(dropLast(suffix.count))
    }
}
