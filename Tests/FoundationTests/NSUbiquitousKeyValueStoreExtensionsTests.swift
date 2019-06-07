//
//  UserDefaultsExtensionsTests.swift
//  SwifterSwift
//
//  Created by Omar Albeik on 9/6/17.
//  Copyright © 2016 SwifterSwift
//

import XCTest
@testable import SwifterSwift

#if canImport(Foundation)
import Foundation

final class NSUbiquitousKeyValueStoreExtensionsTests: XCTestCase {

    private struct TestObject: Codable {
        var itemId: Int
    }

    func testSubscript() {
        #if !os(Linux)
        let key = "testKey"
        NSUbiquitousKeyValueStore.default.set(true, forKey: key)
        XCTAssertNotNil(NSUbiquitousKeyValueStore.default[key])
        XCTAssert(NSUbiquitousKeyValueStore.default[key] as? Bool ?? false)

        NSUbiquitousKeyValueStore.default.removeObject(forKey: key)
        NSUbiquitousKeyValueStore.default[key] = false
        XCTAssertNotNil(NSUbiquitousKeyValueStore.default[key])
        XCTAssertFalse(NSUbiquitousKeyValueStore.default[key] as? Bool ?? false)
        #endif
    }

    func testFloat() {
        #if !os(Linux)
        let key = "floatTestKey"
        let number: Float = 10.0
        NSUbiquitousKeyValueStore.default.set(number, forKey: key)
        XCTAssertNotNil(NSUbiquitousKeyValueStore.default.float(forKey: key))
        XCTAssertEqual(NSUbiquitousKeyValueStore.default.float(forKey: key)!, number)
        #endif
    }

    func testDate() {
        #if !os(Linux)
        let key = "dateTestKey"
        let date: Date = Date()
        NSUbiquitousKeyValueStore.default.set(date, forKey: key)
        XCTAssertNotNil(NSUbiquitousKeyValueStore.default.date(forKey: key))
        XCTAssertEqual(NSUbiquitousKeyValueStore.default.date(forKey: key)!, date)
        #endif
    }

    func testGetCodableObject() {
        #if !os(Linux)
        let key = "codableTestKey"
        let codable: TestObject = TestObject(itemId: 1)
        NSUbiquitousKeyValueStore.default.set(object: codable, forKey: key)
        let retrievedCodable = NSUbiquitousKeyValueStore.default.object(TestObject.self, with: key)
        XCTAssertNotNil(retrievedCodable)
        #endif
    }

    func testSetCodableObject() {
        #if !os(Linux)
        let key = "codableTestKey"
        let codable: TestObject = TestObject(itemId: 1)
        NSUbiquitousKeyValueStore.default.set(object: codable, forKey: key)
        let retrievedCodable = NSUbiquitousKeyValueStore.default.object(TestObject.self, with: key)
        XCTAssertNotNil(retrievedCodable)
        #endif
    }

}

#endif
