// FutureExtensionsTests.swift - Copyright 2024 SwifterSwift

@testable import SwifterSwift
import XCTest

#if canImport(Combine)
import Combine

@available(iOS 13.0, macOS 10.15, tvOS 13.0, watchOS 6.0, *)
final class FutureExtensionsTests: XCTestCase {
    private enum FutureExtensionsTestsError: Error {
        case error
    }

    private var cancellable: AnyCancellable?

    override func tearDown() {
        super.tearDown()

        cancellable?.cancel()
        cancellable = nil
    }

    func testInitAsync() {
        let expect = expectation(description: "testInitAsync")

        cancellable = Just(100)
            .flatMap { [weak self] value in
                Future<Int, Never> {
                    await self?.doSomething(value: value) ?? 0
                }
            }
            .sink {
                XCTAssertEqual($0, 100)
                expect.fulfill()
            }

        waitForExpectations(timeout: 1)
    }

    func testInitAsyncThrows() {
        let expect = expectation(description: "testInitAsyncThrows")

        cancellable = Just(100)
            .setFailureType(to: (any Error).self)
            .flatMap { [weak self] value in
                Future<Int, any Error> {
                    try await self?.doSomethingThrows(value: value, shouldThrow: true) ?? 0
                }
            }
            .catch { error in
                XCTAssertEqual(error as? FutureExtensionsTestsError, FutureExtensionsTestsError.error)
                return Just(200)
                    .setFailureType(to: (any Error).self)
            }
            .sink(receiveCompletion: { _ in

            }, receiveValue: {
                XCTAssertEqual($0, 200)
                expect.fulfill()
            })

        waitForExpectations(timeout: 1)
    }

    private func doSomething(value: Int) async -> Int {
        try? await Task.sleep(nanoseconds: 1_000_000 * 1)
        return await withCheckedContinuation { continuation in
            continuation.resume(returning: value)
        }
    }

    private func doSomethingThrows(value: Int, shouldThrow: Bool) async throws -> Int {
        try? await Task.sleep(nanoseconds: 1_000_000 * 1)
        return try await withCheckedThrowingContinuation { continuation in
            continuation.resume(with: shouldThrow ? .failure(FutureExtensionsTestsError.error) : .success(value))
        }
    }
}

#endif
