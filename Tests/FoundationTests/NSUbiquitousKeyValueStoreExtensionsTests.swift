//
//  NSUbiquitousKeyValueStoreExtensions.swift
//  SwifterSwift
//
//  Created by Joseph Canale on 6/7/19.
//  Copyright © 2017 SwifterSwift
//

import XCTest
@testable import SwifterSwift

#if canImport(Foundation) && !os(Linux) && !os(watchOS)
import Foundation

final class NSUbiquitousKeyValueStoreExtensionsTests: XCTestCase {

    private struct TestObject: Codable, Equatable {
        var itemId: Int
    }

    func testSubscript() {
        let key = "testKey"
        NSUbiquitousKeyValueStore.default.set(true, forKey: key)
        XCTAssertNotNil(NSUbiquitousKeyValueStore.default[key])
        XCTAssert(NSUbiquitousKeyValueStore.default[key] as? Bool ?? false)

        NSUbiquitousKeyValueStore.default.removeObject(forKey: key)
        NSUbiquitousKeyValueStore.default[key] = false
        XCTAssertNotNil(NSUbiquitousKeyValueStore.default[key])
        XCTAssertFalse(NSUbiquitousKeyValueStore.default[key] as? Bool ?? false)
    }

    func testDate() {
        let key = "dateTestKey"
        let date = Date()
        NSUbiquitousKeyValueStore.default.set(date, forKey: key)
        XCTAssertNotNil(NSUbiquitousKeyValueStore.default.date(forKey: key))
        XCTAssertEqual(NSUbiquitousKeyValueStore.default.date(forKey: key)!, date)
    }

    func testGetCodableObject() {
        let key = "codableTestKey"
        let codable = TestObject(itemId: 1)
        NSUbiquitousKeyValueStore.default.set(codable, forKey: key)
        let retrievedCodable = NSUbiquitousKeyValueStore.default.object(TestObject.self, with: key)
        XCTAssertNotNil(retrievedCodable)
    }

    func testSetCodableObject() {
        let key = "codableTestKey"
        let codable = TestObject(itemId: 1)
        NSUbiquitousKeyValueStore.default.set(codable, forKey: key)
        let retrievedCodable = NSUbiquitousKeyValueStore.default.object(TestObject.self, with: key)
        XCTAssertEqual(codable, retrievedCodable)
    }

}

#endif
