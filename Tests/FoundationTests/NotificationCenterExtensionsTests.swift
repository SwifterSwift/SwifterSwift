// NotificationCenterExtensionsTests.swift - Copyright 2025 SwifterSwift

#if canImport(Foundation) && canImport(Combine)

@testable import SwifterSwift
import XCTest

final class NotificationCenterExtensionsTests: XCTestCase {
    @available(iOS 13.0, macOS 10.15, tvOS 13.0, *)
    func testObserveOnce() {
        var count = 0

        let notificationCenter = NotificationCenter()
        let notificationName = Notification.Name(rawValue: "foo")
        let object = NSObject()
        let increment = { (_: Notification) in count += 1 }
        notificationCenter.observeOnce(forName: notificationName,
                                       object: object,
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

        notificationCenter.observeOnce(forName: notificationName,
                                       object: nil,
                                       using: increment)
        notificationCenter.post(name: notificationName, object: nil)
        XCTAssertEqual(count, 2)

        notificationCenter.observeOnce(forName: notificationName,
                                       object: object,
                                       using: increment)
        notificationCenter.post(name: notificationName, object: object)
        XCTAssertEqual(count, 3)
    }
}

#endif
