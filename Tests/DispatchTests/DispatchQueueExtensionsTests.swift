// DispatchQueueExtensionsTests.swift - Copyright 2025 SwifterSwift

@testable import SwifterSwift
import XCTest

#if canImport(Dispatch)
import Dispatch

@available(macOS 10.15, iOS 13.0, tvOS 13.0, *)
final class DispatchQueueExtensionsTests: XCTestCase {
    #if !os(Linux) && !os(Android)
    func testIsMainQueue() async {
        let expect = expectation(description: "isMainQueue")
        let group = DispatchGroup()

        DispatchQueue.main.async(group: group) {
            XCTAssert(DispatchQueue.isMainQueue)
        }
        DispatchQueue.global().async(group: group) {
            XCTAssertFalse(DispatchQueue.isMainQueue)
        }

        group.notify(queue: .main) {
            expect.fulfill()
        }

        await fulfillment(of: [expect], timeout: 0.5)
    }
    #endif

    func testIsCurrent() async {
        let expect = expectation(description: "isCurrent")
        let group = DispatchGroup()
        let queue = DispatchQueue.global()

        queue.async(group: group) {
            XCTAssert(DispatchQueue.isCurrent(queue))
        }
        DispatchQueue.main.async(group: group) {
            XCTAssert(DispatchQueue.isCurrent(DispatchQueue.main))
            XCTAssertFalse(DispatchQueue.isCurrent(queue))
        }

        group.notify(queue: .main) {
            expect.fulfill()
        }

        await fulfillment(of: [expect], timeout: 0.5)
    }

    func testAsyncAfter() async {
        let delay = TimeInterval(2)
        let codeShouldBeExecuted = expectation(description: "Executed")

        DispatchQueue.main.asyncAfter(delay: delay) {
            codeShouldBeExecuted.fulfill()
        }

        await fulfillment(of: [codeShouldBeExecuted], timeout: delay + 1)
    }

    #if !os(Linux) && !os(Android)
    @available(macOS 14.0, iOS 17.0, tvOS 17.0, watchOS 10.0, *)
    func testDebounce() async {
        var value = 0
        let done = expectation(description: "Execute block after delay")

        let delay = 0.02
        let debouncedIncrementor = DispatchQueue.main.debounce(delay: delay) {
            value += 1
        }

        for _ in 1...10 {
            debouncedIncrementor()
        }

        DispatchQueue.main.asyncAfter(deadline: .now() + delay) {
            done.fulfill()
        }

        XCTAssertEqual(value, 0, "Debounced function was executed right away")

        await fulfillment(of: [done], timeout: 2.5)

        XCTAssertEqual(value, 1, "Value was incremented more once")
    }
    #endif
}

#endif
