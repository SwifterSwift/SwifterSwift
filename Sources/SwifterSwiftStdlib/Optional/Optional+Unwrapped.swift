// Optional+Unwrapped.swift - Copyright 2026 SwifterSwift

public extension Optional {
    /// SwifterSwift: Returns the wrapped value, or throws the given error if the optional is `nil`.
    ///
    /// The error is an autoclosure, so it's only created when the optional is `nil`. The method uses typed throws, so
    /// the caller's `catch` sees the concrete error type.
    ///
    /// ```swift
    /// enum LookupError: Error { case missing }
    ///
    /// let name: String? = "Swift"
    /// try name.unwrapped(or: LookupError.missing)  // "Swift"
    ///
    /// let age: Int? = nil
    /// try age.unwrapped(or: LookupError.missing)  // throws LookupError.missing
    /// ```
    ///
    /// It replaces the `guard let value else { throw error }` dance when the value is needed inside an expression.
    ///
    /// - Parameter error: The error to throw if the optional is `nil`.
    /// - Returns: The wrapped value.
    /// - Throws: `error`, if the optional is `nil`.
    func unwrapped<Failure: Error>(or error: @autoclosure () -> Failure) throws(Failure) -> Wrapped {
        guard let value = self else { throw error() }
        return value
    }
}
