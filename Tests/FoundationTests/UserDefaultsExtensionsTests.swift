//
//  UserDefaultsExtensionsTests.swift
//  SwifterSwift
//
//  Created by Omar Albeik on 9/6/17.
//
//
import XCTest
@testable import SwifterSwift

class UserDefaultsExtensionsTests: XCTestCase {
	
	func testSubscript() {
		let key = "testKey"
		UserDefaults.standard.set(true, forKey: key)
		XCTAssertNotNil(UserDefaults.standard[key])
		XCTAssert(UserDefaults.standard[key] as! Bool)
		
		UserDefaults.standard.removeObject(forKey: key)
		UserDefaults.standard[key] = false
		XCTAssertNotNil(UserDefaults.standard[key])
		XCTAssertFalse(UserDefaults.standard[key] as! Bool)
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
	
}
