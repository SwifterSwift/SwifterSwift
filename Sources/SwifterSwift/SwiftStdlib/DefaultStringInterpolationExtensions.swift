// DefaultStringInterpolationExtensions.swift - Copyright 2023 SwifterSwift

public extension DefaultStringInterpolation {
    /// SwifterSwift: Interpolates the given value's textual representation
    /// into the string literal being created if the value is not `nil` and the
    /// optional predicate returns `true`, otherwise append a placeholder.
    ///
    /// Do not call this method directly. It is used by the compiler when
    /// interpreting string interpolations. Instead, use string
    /// interpolation to create a new string by including values, literals,
    /// variables, or expressions enclosed in parentheses, prefixed by a
    /// backslash (`\(`...`, placeholder: `...`)`).
    ///
    ///     var token: Int? = nil
    ///     print("\(token, placeholder: "-")")
    ///     // Prints "-"
    ///     token = 0
    ///     print("\(token, placeholder: "-")")
    ///     // Prints "0"
    ///     print("\(token, placeholder: "-", where: { $0 > 0} )")
    ///     // Prints "-"
    ///
    /// - Parameters:
    ///   - value: The values, literals, variables, or expressions to be interpolated.
    ///   - placeholder: The string that displays when `value` is `nil`.
    ///   - predicate: A closure that takes unwrapped `value` as its argument and returns `true` if the `value`'s
    ///                textual representation  should be interpolated into the string literal or `false` if the
    ///                `placeholder` should be interpolated into the string literal. You can use a `nil` value for
    ///                this parameter.
    mutating func appendInterpolation<T>(_ value: T?,
                                         placeholder: @autoclosure () -> String,
                                         where predicate: ((T) throws -> Bool)? = nil) rethrows {
        switch value {
        case let .some(value) where try predicate?(value) != false:
            appendInterpolation(value)

        default:
            appendInterpolation(placeholder())
        }
    }
}
