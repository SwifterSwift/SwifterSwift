// FutureExtensionsTests.swift - Copyright 2023 SwifterSwift

@testable import SwifterSwift
import XCTest

#if canImport(Combine)
import Combine
#endif

@available(iOS 13.0, macOS 10.15, tvOS 13.0, watchOS 6.0, *)
final class FutureExtensionsTests: XCTestCase {
    private enum FutureExtensionsTestsError: Error {
        case error
    }
        
    private var cancellable: Any?
    
    override func tearDown() {
        super.tearDown()
        
        #if canImport(Combine)
        (cancellable as? AnyCancellable)?.cancel()
        #endif
        cancellable = nil
    }
    
    func testInitAsync() {
        let expect = expectation(description: "")
        
        #if canImport(Combine) && !os(Linux) && swift(>=5.5) && canImport(_Concurrency)
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
        #endif
        
        waitForExpectations(timeout: 1)
    }
    
    func testInitAsyncThrows() {
        let expect = expectation(description: "")
        
        #if canImport(Combine) && !os(Linux) && swift(>=5.5) && canImport(_Concurrency)
        cancellable = Just(100)
            .setFailureType(to: Error.self)
            .flatMap { [weak self] value in
                Future<Int, Error> {
                    try await self?.doSomethingThrows(value: value, shouldThrow: true) ?? 0
                }
            }
            .catch { error in
                XCTAssertEqual(error as? FutureExtensionsTestsError, FutureExtensionsTestsError.error)
                return Just(200)
                    .setFailureType(to: Error.self)
            }
            .sink(receiveCompletion: { _ in
                
            }, receiveValue: {
                XCTAssertEqual($0, 200)
                expect.fulfill()
            })
        #endif
        
        waitForExpectations(timeout: 1)
    }
    
    #if !os(Linux) && swift(>=5.5) && canImport(_Concurrency)
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
    #endif
}
