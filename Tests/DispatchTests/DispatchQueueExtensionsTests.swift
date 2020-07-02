//
//  DispatchQueueExtensionsTests.swift
//  SwifterSwift
//
//  Created by Quentin Jin on 2018/10/13.
//  Copyright © 2018 SwifterSwift
//

import XCTest
@testable import SwifterSwift

#if canImport(Dispatch)
import Dispatch

final class DispatchQueueExtensionsTests: XCTestCase {

    func testIsMainQueue() {
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

        waitForExpectations(timeout: 0.5)
    }

    func testIsCurrent() {
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

        waitForExpectations(timeout: 0.5)
    }

    func testAsyncAfter() {
        let delay = TimeInterval(2)
        let codeShouldBeExecuted = expectation(description: "Executed")

        DispatchQueue.main.asyncAfter(delay: delay) {
            codeShouldBeExecuted.fulfill()
        }

        waitForExpectations(timeout: delay + 1)
    }

    func testDebounce() {
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

        waitForExpectations(timeout: 2.5) { _ in
            XCTAssertEqual(value, 1, "Value was incremented more once")
        }
    }

}

#endif
