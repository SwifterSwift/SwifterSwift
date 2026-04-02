// ResultExtensionsTests.swift - Copyright 2025 SwifterSwift

@testable import SwifterSwift
import XCTest

private enum TestError: Error, Equatable {
    case generic
}

final class ResultExtensionsTests: XCTestCase {
    // MARK: - Properties

    func testSuccess() {
        let successResult: Result<Int, TestError> = .success(42)
        XCTAssertEqual(successResult.success, 42)

        let failureResult: Result<Int, TestError> = .failure(.generic)
        XCTAssertNil(failureResult.success)
    }

    func testFailure() {
        let successResult: Result<Int, TestError> = .success(42)
        XCTAssertNil(successResult.failure)

        let failureResult: Result<Int, TestError> = .failure(.generic)
        XCTAssertEqual(failureResult.failure, .generic)
    }

    func testIsSuccess() {
        let successResult: Result<Int, TestError> = .success(42)
        XCTAssertTrue(successResult.isSuccess)

        let failureResult: Result<Int, TestError> = .failure(.generic)
        XCTAssertFalse(failureResult.isSuccess)
    }

    func testIsFailure() {
        let successResult: Result<Int, TestError> = .success(42)
        XCTAssertFalse(successResult.isFailure)

        let failureResult: Result<Int, TestError> = .failure(.generic)
        XCTAssertTrue(failureResult.isFailure)
    }
}
