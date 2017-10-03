//
//  NSDecimalNumberExtensionsTests.swift
//  SwifterSwift
//
//  Created by Vitaliy Gozhenko on 15/09/17.
//
//

import XCTest
@testable import SwifterSwift

class NSDecimalNumberExtensionsTests: XCTestCase {
  
  func testCompare() {
    let a = NSDecimalNumber(value: 1)
    let b = NSDecimalNumber(value: 1.5)
    let c = NSDecimalNumber(value: 1)
    XCTAssertTrue(a < b)
    XCTAssertTrue(a == c)
    XCTAssertTrue(b > a)
  }
  
  func testNegativeOperation() {
    let a = NSDecimalNumber(value: 1)
    XCTAssertTrue(-a == -1)
  }
  
  func testAddOperation() {
    var a = NSDecimalNumber(value: 1)
    a = a + 1
    XCTAssertTrue(a == 2)
    a += 1
    XCTAssertTrue(a == 3)
    a = a + 0.5
    XCTAssertTrue(a == 3.5)
    a += 0.5
    XCTAssertTrue(a == 4)
  }
  
  func testSubtractOperation() {
    var a = NSDecimalNumber(value: 5)
    a = a - 1
    XCTAssertTrue(a == 4)
    a -= 1
    XCTAssertTrue(a == 3)
    a = a - 0.5
    XCTAssertTrue(a == 2.5)
    a -= 0.5
    XCTAssertTrue(a == 2)
  }
  
  func testDivideOperation() {
    var a = NSDecimalNumber(value: 10)
    a = a / 2
    XCTAssertTrue(a == 5)
    a /= 2
    XCTAssertTrue(a == 2.5)
    a = a / 0.5
    XCTAssertTrue(a == 5)
    a /= 0.5
    XCTAssertTrue(a == 10)
  }
  
  func testMultiplyOperation() {
    var a = NSDecimalNumber(value: 1)
    a = a * 2
    XCTAssertTrue(a == 2)
    a *= 2
    XCTAssertTrue(a == 4)
    a = a * 2.5
    XCTAssertTrue(a == 10)
    a *= 2.5
    XCTAssertTrue(a == 25)
  }
  
  func testPowerOperation() {
    var a = NSDecimalNumber(value: 2)
    a = a ^ 3
    XCTAssertTrue(a == 8)
    a = a ^ 2
    XCTAssertTrue(a == 64)
  }
  
}
