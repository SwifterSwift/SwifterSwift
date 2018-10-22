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
            XCTAssertTrue(DispatchQueue.isMainQueue)
        }
        DispatchQueue.global().async(group: group) {
            XCTAssertFalse(DispatchQueue.isMainQueue)
        }

        group.notify(queue: .main) {
            expect.fulfill()
        }

        waitForExpectations(timeout: 0.5, handler: nil)
    }

    func testIsCurrent() {
        let expect = expectation(description: "isCurrent")
        let group = DispatchGroup()
        let queue = DispatchQueue.global()

        queue.async(group: group) {
            XCTAssertTrue(DispatchQueue.isCurrent(queue))
        }
        DispatchQueue.main.async(group: group) {
            XCTAssertTrue(DispatchQueue.isCurrent(DispatchQueue.main))
            XCTAssertFalse(DispatchQueue.isCurrent(queue))
        }

        group.notify(queue: .main) {
            expect.fulfill()
        }

        waitForExpectations(timeout: 0.5, handler: nil)
    }

}
#endif
