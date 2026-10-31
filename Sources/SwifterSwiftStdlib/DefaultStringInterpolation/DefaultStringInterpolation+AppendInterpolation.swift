// DefaultStringInterpolation+AppendInterpolation.swift - Copyright 2026 SwifterSwift

public extension DefaultStringInterpolation {
    /// SwifterSwift: Interpolates an optional value if it isn't `nil` and passes a test, or a default text otherwise.
    ///
    /// Swift 6.2 added `"\(value, default: "-")"`, which falls back to the default only when the value is `nil`. This
    /// overload adds a `where` test, so values that are present but meaningless (zero, empty, out of range) can fall
    /// back to the same default without an `if` around the whole string. The value is interpolated exactly as
    /// `"\(value)"` would interpolate it, and the default is evaluated only when it's used.
    ///
    /// Don't call this method directly; the compiler calls it for an interpolation written as
    /// `\(value, default: ..., where: ...)`. If the test can throw, mark the string literal with `try`.
    ///
    /// ```swift
    /// let unread: Int? = 0
    /// "Unread: \(unread, default: "none", where: { $0 > 0 })"  // "Unread: none"
    /// let missing: Int? = nil
    /// "Unread: \(missing, default: "none", where: { $0 > 0 })"  // "Unread: none"
    /// let three: Int? = 3
    /// "Unread: \(three, default: "none", where: { $0 > 0 })"  // "Unread: 3"
    /// ```
    ///
    /// - Parameters:
    ///   - value: The optional value to interpolate.
    ///   - defaultValue: The text to interpolate when `value` is `nil` or doesn't pass `predicate`.
    ///   - predicate: A closure that takes the unwrapped value and returns whether to interpolate it.
    /// - Throws: Rethrows any error that `predicate` throws.
    mutating func appendInterpolation<T>(
        _ value: T?,
        default defaultValue: @autoclosure () -> some StringProtocol,
        where predicate: (T) throws -> Bool
    ) rethrows {
        if let value, try predicate(value) {
            appendInterpolation(value)
        } else {
            appendInterpolation(defaultValue())
        }
    }
}
