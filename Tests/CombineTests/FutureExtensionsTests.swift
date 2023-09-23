// FutureExtensionsTests.swift - Copyright 2023 SwifterSwift

@testable import SwifterSwift
import XCTest

#if canImport(Combine)
import Combine
#endif

final class FutureExtensionsTests: XCTestCase {
    enum FutureExtensionsTestsError: Error {
        case error
    }
    
    #if swift(>=5.5) && canImport(_Concurrency)
    @available(iOS 13.00, macOS 10.15, tvOS 13.0, watchOS 6.0, *)
    private func doSomething(value: Int) async -> Int {
        try? await Task.sleep(nanoseconds: 1_000_000 * 1)
        return await withCheckedContinuation { continuation in
            continuation.resume(returning: value)
        }
    }

    @available(iOS 13.00, macOS 10.15, tvOS 13.0, watchOS 6.0, *)
    private func doSomethingThrows(value: Int, shouldThrow: Bool) async throws -> Int {
        try? await Task.sleep(nanoseconds: 1_000_000 * 1)
        return try await withCheckedThrowingContinuation { continuation in
            continuation.resume(with: shouldThrow ? .failure(FutureExtensionsTestsError.error) : .success(value))
        }
    }
    #endif
    
    private var cancellable: Any?
    
    override func tearDown() {
        super.tearDown()
        
        #if canImport(Combine)
        if #available(iOS 13.00, macOS 10.15, tvOS 13.0, watchOS 6.0, *) {
            (cancellable as? AnyCancellable)?.cancel()
        }
        cancellable = nil
        #endif
    }
    
    func testInitAsync() {
        let expect = expectation(description: "")
        
        guard #available(iOS 13.00, macOS 10.15, tvOS 13.0, watchOS 6.0, *) else {
            return
        }
        #if canImport(Combine) && swift(>=5.5) && canImport(_Concurrency)
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
        
        guard #available(iOS 13.00, macOS 10.15, tvOS 13.0, watchOS 6.0, *) else {
            return
        }
        #if canImport(Combine) && swift(>=5.5) && canImport(_Concurrency)
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
}
