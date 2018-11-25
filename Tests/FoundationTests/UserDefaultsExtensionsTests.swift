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

final class UserDefaultsExtensionsTests: XCTestCase {

    private struct TestObject: Codable {
        var itemId: Int
    }

    func testSubscript() {
        let key = "testKey"
        UserDefaults.standard.set(true, forKey: key)
        XCTAssertNotNil(UserDefaults.standard[key])
        XCTAssert(UserDefaults.standard[key] as? Bool ?? false)

        UserDefaults.standard.removeObject(forKey: key)
        UserDefaults.standard[key] = false
        XCTAssertNotNil(UserDefaults.standard[key])
        XCTAssertFalse(UserDefaults.standard[key] as? Bool ?? false)
    }

    func testFloat() {
        let key = "floatTestKey"
        let number: Float = 10.0
        UserDefaults.standard.set(number, forKey: key)
        XCTAssertNotNil(UserDefaults.standard.float(forKey: key))
        XCTAssertEqual(UserDefaults.standard.float(forKey: key)!, number)
    }

    func testDate() {
        let key = "dateTestKey"
        let date: Date = Date()
        UserDefaults.standard.set(date, forKey: key)
        XCTAssertNotNil(UserDefaults.standard.date(forKey: key))
        XCTAssertEqual(UserDefaults.standard.date(forKey: key)!, date)
    }

    func testGetCodableObject() {
        let key = "codableTestKey"
        let codable: TestObject = TestObject(itemId: 1)
        UserDefaults.standard.set(object: codable, forKey: key)
        let retrievedCodable = UserDefaults.standard.object(TestObject.self, with: key)
        XCTAssertNotNil(retrievedCodable)
    }

    func testSetCodableObject() {
        let key = "codableTestKey"
        let codable: TestObject = TestObject(itemId: 1)
        UserDefaults.standard.set(object: codable, forKey: key)
        let retrievedCodable = UserDefaults.standard.object(TestObject.self, with: key)
        XCTAssertNotNil(retrievedCodable)
    }

}

#endif
