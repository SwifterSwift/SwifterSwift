//
//  NotificationCenterExtensionsTests.swift
//  SwifterSwift
//
//  Created by Guy Kogus on 6/3/20.
//  Copyright © 2020 SwifterSwift
//

import XCTest
@testable import SwifterSwift

final class NotificationCenterExtensionsTests: XCTestCase {

    func testObserveOnce() {
        var count = 0

        let notificationCenter = NotificationCenter()
        let notificationName = Notification.Name(rawValue: "foo")
        let object = NSObject()
        let operationQueue = OperationQueue()
        let increment = { (_: Notification) in count += 1 }
        notificationCenter.observeOnce(forName: notificationName,
                                       object: object,
                                       queue: operationQueue,
                                       using: increment)

        let wrongNotificationName = Notification.Name(rawValue: "bar")

        notificationCenter.post(name: wrongNotificationName, object: object)
        XCTAssertEqual(count, 0)
        notificationCenter.post(name: notificationName, object: nil)
        XCTAssertEqual(count, 0)
        notificationCenter.post(name: notificationName, object: object)
        XCTAssertEqual(count, 1)
        notificationCenter.post(name: notificationName, object: object)
        XCTAssertEqual(count, 1)

        notificationCenter.observeOnce(forName: nil,
                                       object: object,
                                       queue: operationQueue,
                                       using: increment)
        notificationCenter.post(name: wrongNotificationName, object: object)
        XCTAssertEqual(count, 2)

        notificationCenter.observeOnce(forName: notificationName,
                                       object: nil,
                                       queue: operationQueue,
                                       using: increment)
        notificationCenter.post(name: notificationName, object: nil)
        XCTAssertEqual(count, 3)

        notificationCenter.observeOnce(forName: notificationName,
                                       object: object,
                                       queue: nil,
                                       using: increment)
        notificationCenter.post(name: notificationName, object: object)
        XCTAssertEqual(count, 4)
    }

}
