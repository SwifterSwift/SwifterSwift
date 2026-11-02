// String+FullNSRange.swift - Copyright 2026 SwifterSwift

#if canImport(Foundation)
import Foundation

public extension String {
    /// SwifterSwift: The `NSRange` that covers the whole string, for use with Foundation and UIKit or AppKit APIs.
    ///
    /// An `NSRange` counts UTF-16 code units, not characters, so `NSRange(location: 0, length: count)` is too short for
    /// strings with emoji or other characters outside the Basic Multilingual Plane, and too short or too long for
    /// strings with combining marks. This range is built from the string's own indices, so it's always right.
    ///
    /// ```swift
    /// "Hello".fullNSRange  // {0, 5}
    /// "👋🏽 Hi".fullNSRange  // {0, 7}
    /// "".fullNSRange  // {0, 0}
    /// ```
    ///
    /// - Complexity: O(*n*), where *n* is the length of the string.
    var fullNSRange: NSRange {
        NSRange(startIndex..<endIndex, in: self)
    }
}
#endif
