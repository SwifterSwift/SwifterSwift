//
//  UserDefaultsExtensionsTests.swift
//  SwifterSwift
//
//  Created by Omar Albeik on 9/6/17.
//  Copyright © 2016 SwifterSwift
//
import XCTest
@testable import SwifterSwift

final class UserDefaultsExtensionsTests: XCTestCase {
    
    private struct TestObject: Codable {
        var id: Int
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
    
    func testCodable() {
        let key = "codableTestKey"
        let id = 1
        let codable: TestObject = TestObject(id: id)
        UserDefaults.standard.set(codable: codable, forKey: key)
        let retrievedCodable = UserDefaults.standard.codable(TestObject.self, with: key)
        XCTAssertNotNil(retrievedCodable)
        XCTAssertEqual((retrievedCodable as! TestObject).id, id)
    }
	
}
