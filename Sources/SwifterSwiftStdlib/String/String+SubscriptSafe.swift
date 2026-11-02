// String+SubscriptSafe.swift - Copyright 2026 SwifterSwift

public extension String {
    /// SwifterSwift: Accesses the character at the given integer offset, or returns `nil` if it's out of bounds.
    ///
    /// `String` can't be indexed with integers because its characters have different sizes, so this subscript walks
    /// from the start of the string to the requested character. Offsets count characters as the user sees them, so an
    /// emoji or a letter with a combining accent counts as one. A negative offset, or one at or past the end, returns
    /// `nil` instead of trapping.
    ///
    /// ```swift
    /// let greeting = "Hi 👋🏽!"
    /// greeting[safe: 1]  // "i"
    /// greeting[safe: 3]  // "👋🏽"
    /// greeting[safe: 5]  // nil
    /// greeting[safe: -1]  // nil
    /// ```
    ///
    /// - Parameter offset: The distance, in characters, from the start of the string.
    /// - Returns: The character at `offset`, or `nil` if `offset` is negative or not less than the length of the
    ///   string.
    /// - Complexity: O(*k*), where *k* is `offset`.
    subscript(safe offset: Int) -> Character? {
        guard offset >= 0,
            let position = index(startIndex, offsetBy: offset, limitedBy: endIndex),
            position != endIndex
        else { return nil }
        return self[position]
    }

    /// SwifterSwift: Accesses the characters in the given range of integer offsets, or `nil` if it's out of bounds.
    ///
    /// Offsets count characters as the user sees them. The whole range must lie within the string: a negative lower
    /// bound, or an upper bound past the end, returns `nil` instead of trapping or clamping. An empty range at a valid
    /// offset, including the end of the string, returns an empty substring.
    ///
    /// ```swift
    /// let text = "Hello, World!"
    /// text[safe: 7..<12]  // "World"
    /// text[safe: 13..<13]  // ""
    /// text[safe: 7..<20]  // nil
    /// text[safe: -1..<5]  // nil
    /// ```
    ///
    /// - Parameter range: The range of offsets, in characters, from the start of the string.
    /// - Returns: The characters in `range`, or `nil` if `range` doesn't fit in the string.
    /// - Complexity: O(*k*), where *k* is the upper bound of `range`.
    subscript(safe range: Range<Int>) -> Substring? {
        guard range.lowerBound >= 0,
            let lower = index(startIndex, offsetBy: range.lowerBound, limitedBy: endIndex),
            let upper = index(lower, offsetBy: range.upperBound - range.lowerBound, limitedBy: endIndex)
        else { return nil }
        return self[lower..<upper]
    }

    /// SwifterSwift: Accesses the characters in the given range of integer offsets, or `nil` if it's out of bounds.
    ///
    /// Offsets count characters as the user sees them. The whole range must lie within the string: a negative lower
    /// bound, or an upper bound at or past the end, returns `nil` instead of trapping or clamping.
    ///
    /// ```swift
    /// let text = "Hello, World!"
    /// text[safe: 7...11]  // "World"
    /// text[safe: 12...12]  // "!"
    /// text[safe: 7...13]  // nil
    /// ```
    ///
    /// - Parameter range: The range of offsets, in characters, from the start of the string.
    /// - Returns: The characters in `range`, or `nil` if `range` doesn't fit in the string.
    /// - Complexity: O(*k*), where *k* is the upper bound of `range`.
    subscript(safe range: ClosedRange<Int>) -> Substring? {
        guard range.lowerBound >= 0,
            let lower = index(startIndex, offsetBy: range.lowerBound, limitedBy: endIndex),
            let last = index(lower, offsetBy: range.upperBound - range.lowerBound, limitedBy: endIndex),
            last != endIndex
        else { return nil }
        return self[lower...last]
    }

    /// SwifterSwift: Accesses the characters before the given integer offset, or `nil` if it's out of bounds.
    ///
    /// Offsets count characters as the user sees them. A negative offset, or one past the end, returns `nil`; an offset
    /// of zero returns an empty substring, and an offset equal to the length returns the whole string.
    ///
    /// ```swift
    /// let text = "Hello, World!"
    /// text[safe: ..<5]  // "Hello"
    /// text[safe: ..<0]  // ""
    /// text[safe: ..<20]  // nil
    /// ```
    ///
    /// - Parameter range: The range of offsets, in characters, from the start of the string.
    /// - Returns: The characters before `range.upperBound`, or `nil` if the bound is negative or past the end.
    /// - Complexity: O(*k*), where *k* is the upper bound of `range`.
    subscript(safe range: PartialRangeUpTo<Int>) -> Substring? {
        guard range.upperBound >= 0,
            let upper = index(startIndex, offsetBy: range.upperBound, limitedBy: endIndex)
        else { return nil }
        return self[..<upper]
    }

    /// SwifterSwift: Accesses the characters through the given integer offset, or `nil` if it's out of bounds.
    ///
    /// Offsets count characters as the user sees them. A negative offset, or one at or past the end, returns `nil`.
    ///
    /// ```swift
    /// let text = "Hello, World!"
    /// text[safe: ...4]  // "Hello"
    /// text[safe: ...12]  // "Hello, World!"
    /// text[safe: ...13]  // nil
    /// ```
    ///
    /// - Parameter range: The range of offsets, in characters, from the start of the string.
    /// - Returns: The characters up to and including `range.upperBound`, or `nil` if the bound is negative or not less
    ///   than the length of the string.
    /// - Complexity: O(*k*), where *k* is the upper bound of `range`.
    subscript(safe range: PartialRangeThrough<Int>) -> Substring? {
        guard range.upperBound >= 0,
            let last = index(startIndex, offsetBy: range.upperBound, limitedBy: endIndex),
            last != endIndex
        else { return nil }
        return self[...last]
    }

    /// SwifterSwift: Accesses the characters from the given integer offset to the end, or `nil` if it's out of bounds.
    ///
    /// Offsets count characters as the user sees them. A negative offset, or one past the end, returns `nil`; an offset
    /// equal to the length returns an empty substring, so `""[safe: 0...]` is `""`.
    ///
    /// ```swift
    /// let text = "Hello, World!"
    /// text[safe: 7...]  // "World!"
    /// text[safe: 13...]  // ""
    /// text[safe: 14...]  // nil
    /// ```
    ///
    /// - Parameter range: The range of offsets, in characters, from the start of the string.
    /// - Returns: The characters from `range.lowerBound` to the end, or `nil` if the bound is negative or past the end.
    /// - Complexity: O(*k*), where *k* is the lower bound of `range`.
    subscript(safe range: PartialRangeFrom<Int>) -> Substring? {
        guard range.lowerBound >= 0,
            let lower = index(startIndex, offsetBy: range.lowerBound, limitedBy: endIndex)
        else { return nil }
        return self[lower...]
    }
}
