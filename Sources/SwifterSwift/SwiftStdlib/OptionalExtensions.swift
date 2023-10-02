// OptionalExtensions.swift - Copyright 2023 SwifterSwift

// MARK: - Methods

public extension Optional {
    /// SwifterSwift: Get self of default value (if self is nil).
    ///
    ///		let foo: String? = nil
    ///		print(foo.unwrapped(or: "bar")) -> "bar"
    ///
    ///		let bar: String? = "bar"
    ///		print(bar.unwrapped(or: "foo")) -> "bar"
    ///
    /// - Parameter defaultValue: default value to return if self is nil.
    /// - Returns: self if not nil or default value if nil.
    func unwrapped(or defaultValue: Wrapped) -> Wrapped {
        // http://www.russbishop.net/improving-optionals
        return self ?? defaultValue
    }

    /// SwifterSwift: Gets the wrapped value of an optional. If the optional is `nil`, throw a custom error.
    ///
    ///        let foo: String? = nil
    ///        try print(foo.unwrapped(or: MyError.notFound)) -> error: MyError.notFound
    ///
    ///        let bar: String? = "bar"
    ///        try print(bar.unwrapped(or: MyError.notFound)) -> "bar"
    ///
    /// - Parameter error: The error to throw if the optional is `nil`.
    /// - Throws: The error passed in.
    /// - Returns: The value wrapped by the optional.
    func unwrapped(or error: Error) throws -> Wrapped {
        guard let wrapped = self else { throw error }
        return wrapped
    }

    /// SwifterSwift: Runs a block to Wrapped if not nil.
    ///
    ///		let foo: String? = nil
    ///		foo.run { unwrappedFoo in
    ///			// block will never run since foo is nil
    ///			print(unwrappedFoo)
    ///		}
    ///
    ///		let bar: String? = "bar"
    ///		bar.run { unwrappedBar in
    ///			// block will run since bar is not nil
    ///			print(unwrappedBar) -> "bar"
    ///		}
    ///
    /// - Parameter block: a block to run if self is not nil.
    func run(_ block: (Wrapped) -> Void) {
        // http://www.russbishop.net/improving-optionals
        _ = map(block)
    }

    /// SwifterSwift: Assign an optional value to a variable only if the value is not nil.
    ///
    ///     let someParameter: String? = nil
    ///     let parameters = [String: Any]() // Some parameters to be attached to a GET request
    ///     parameters[someKey] ??= someParameter // It won't be added to the parameters dict
    ///
    /// - Parameters:
    ///   - lhs: Any?
    ///   - rhs: Any?
    static func ??= (lhs: inout Optional, rhs: Optional) {
        guard let rhs = rhs else { return }
        lhs = rhs
    }

    /// SwifterSwift: Assign an optional value to a variable only if the variable is nil.
    ///
    ///     var someText: String? = nil
    ///     let newText = "Foo"
    ///     let defaultText = "Bar"
    ///     someText ?= newText // someText is now "Foo" because it was nil before
    ///     someText ?= defaultText // someText doesn't change its value because it's not nil
    ///
    /// - Parameters:
    ///   - lhs: Any?
    ///   - rhs: Any?
    static func ?= (lhs: inout Optional, rhs: @autoclosure () -> Optional) {
        if lhs == nil {
            lhs = rhs()
        }
    }
}

// MARK: - Methods (Collection)

public extension Optional where Wrapped: Collection {
    /// SwifterSwift: Check if optional is nil or empty collection.
    var isNilOrEmpty: Bool {
        return self?.isEmpty ?? true
    }

    /// SwifterSwift: Returns the collection only if it is not nil and not empty.
    var nonEmpty: Wrapped? {
        return (self?.isEmpty ?? true) ? nil : self
    }
}

// MARK: - Methods (RawRepresentable, RawValue: Equatable)

public extension Optional where Wrapped: RawRepresentable, Wrapped.RawValue: Equatable {
    // swiftlint:disable missing_swifterswift_prefix

    /// Returns a Boolean value indicating whether two values are equal.
    ///
    /// Equality is the inverse of inequality. For any values `a` and `b`,
    /// `a == b` implies that `a != b` is `false`.
    ///
    /// - Parameters:
    ///   - lhs: A value to compare.
    ///   - rhs: Another value to compare.
    @inlinable static func == (lhs: Optional, rhs: Wrapped.RawValue?) -> Bool {
        return lhs?.rawValue == rhs
    }

    /// Returns a Boolean value indicating whether two values are equal.
    ///
    /// Equality is the inverse of inequality. For any values `a` and `b`,
    /// `a == b` implies that `a != b` is `false`.
    ///
    /// - Parameters:
    ///   - lhs: A value to compare.
    ///   - rhs: Another value to compare.
    @inlinable static func == (lhs: Wrapped.RawValue?, rhs: Optional) -> Bool {
        return lhs == rhs?.rawValue
    }

    /// Returns a Boolean value indicating whether two values are not equal.
    ///
    /// Inequality is the inverse of equality. For any values `a` and `b`,
    /// `a != b` implies that `a == b` is `false`.
    ///
    /// - Parameters:
    ///   - lhs: A value to compare.
    ///   - rhs: Another value to compare.
    @inlinable static func != (lhs: Optional, rhs: Wrapped.RawValue?) -> Bool {
        return lhs?.rawValue != rhs
    }

    /// Returns a Boolean value indicating whether two values are not equal.
    ///
    /// Inequality is the inverse of equality. For any values `a` and `b`,
    /// `a != b` implies that `a == b` is `false`.
    ///
    /// - Parameters:
    ///   - lhs: A value to compare.
    ///   - rhs: Another value to compare.
    @inlinable static func != (lhs: Wrapped.RawValue?, rhs: Optional) -> Bool {
        return lhs != rhs?.rawValue
    }

    // swiftlint:enable missing_swifterswift_prefix
}

// MARK: - Operators

infix operator ??=: AssignmentPrecedence
infix operator ?=: AssignmentPrecedence
