// Optional+UnwrappedTests.swift - Copyright 2026 SwifterSwift

import SwifterSwiftStdlib
import Testing

struct OptionalUnwrappedTests {
    enum LookupError: Error, Equatable {
        case missing
    }

    enum OtherError: Error, Equatable {
        case failed
    }

    @Test
    func returnsTheWrappedValue() throws {
        let name: String? = "Swift"
        #expect(try name.unwrapped(or: LookupError.missing) == "Swift")

        let zero: Int? = 0
        #expect(try zero.unwrapped(or: LookupError.missing) == 0)

        let empty: String? = ""
        #expect(try empty.unwrapped(or: LookupError.missing) == "")
    }

    @Test
    func throwsTheGivenErrorForNil() {
        let missing: String? = nil
        #expect(throws: LookupError.missing) {
            try missing.unwrapped(or: LookupError.missing)
        }
    }

    @Test
    func throwsATypedError() {
        let missing: Int? = nil
        do {
            _ = try missing.unwrapped(or: LookupError.missing)
            Issue.record("Expected an error")
        } catch {
            // `error` is a `LookupError` here, not `any Error`, thanks to typed throws.
            #expect(error == .missing)
        }
    }

    @Test
    func createsTheErrorOnlyWhenNeeded() throws {
        var errorsCreated = 0
        func makeError() -> LookupError {
            errorsCreated += 1
            return .missing
        }

        let value: Int? = 42
        _ = try value.unwrapped(or: makeError())
        #expect(errorsCreated == 0)

        let missing: Int? = nil
        #expect(throws: LookupError.missing) { try missing.unwrapped(or: makeError()) }
        #expect(errorsCreated == 1)
    }

    @Test
    func returnsWrappedErrorsInsteadOfThrowingThem() throws {
        let storedError: OtherError? = .failed
        #expect(try storedError.unwrapped(or: LookupError.missing) == .failed)
    }

    @Test
    func acceptsAnExistentialError() {
        let missing: String? = nil
        let error: any Error = LookupError.missing
        #expect(throws: LookupError.missing) { try missing.unwrapped(or: error) }
    }

    @Test
    func unwrapsNestedOptionalsOneLevel() throws {
        let nested: Int?? = .some(nil)
        let inner = try nested.unwrapped(or: LookupError.missing)
        #expect(inner == nil)
    }
}
