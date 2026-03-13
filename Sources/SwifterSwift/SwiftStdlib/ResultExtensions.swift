// ResultExtensions.swift - Copyright 2025 SwifterSwift

// MARK: - Properties

public extension Result {
    /// SwifterSwift: Returns the success value, or `nil` if the result is a failure.
    ///
    ///     let success: Result<Int, Error> = .success(42)
    ///     success.success // Optional(42)
    ///
    ///     let failure: Result<Int, Error> = .failure(SomeError())
    ///     failure.success // nil
    var success: Success? {
        guard case let .success(value) = self else { return nil }
        return value
    }

    /// SwifterSwift: Returns the failure error, or `nil` if the result is a success.
    ///
    ///     let success: Result<Int, Error> = .success(42)
    ///     success.failure // nil
    ///
    ///     let failure: Result<Int, Error> = .failure(SomeError())
    ///     failure.failure // Optional(SomeError())
    var failure: Failure? {
        guard case let .failure(error) = self else { return nil }
        return error
    }

    /// SwifterSwift: Returns `true` if the result is a success.
    ///
    ///     let success: Result<Int, Error> = .success(42)
    ///     success.isSuccess // true
    ///
    ///     let failure: Result<Int, Error> = .failure(SomeError())
    ///     failure.isSuccess // false
    var isSuccess: Bool {
        guard case .success = self else { return false }
        return true
    }

    /// SwifterSwift: Returns `true` if the result is a failure.
    ///
    ///     let success: Result<Int, Error> = .success(42)
    ///     success.isFailure // false
    ///
    ///     let failure: Result<Int, Error> = .failure(SomeError())
    ///     failure.isFailure // true
    var isFailure: Bool {
        !isSuccess
    }
}
