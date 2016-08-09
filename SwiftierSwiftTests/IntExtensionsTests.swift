//
//  IntExtensionsTests.swift
//  SwiftierSwift
//
//  Created by Omar Albeik on 8/9/16.
//  Copyright © 2016 Omar Albeik. All rights reserved.
//

import XCTest
@testable import SwiftierSwift

class IntExtensionsTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        tearDown()
    }
    
    func testAbs() {
        XCTAssert((-10).abs == 10, "Couldn't get correct value for \(#function)")
    }
    
    func testIsEven() {
        XCTAssert(2.isEven == true && 3.isEven == false, "Couldn't get correct value for \(#function)")
    }
    
    func testIsOdd() {
        XCTAssert(3.isOdd == true && 2.isOdd == false, "Couldn't get correct value for \(#function)")
    }
    
    func testDigits() {
        XCTAssert(123.digits == [1,2,3], "Couldn't get correct value for \(#function)")
    }
    
    func testDigitsCount() {
        XCTAssert(123.digitsCount == 3, "Couldn't get correct value for \(#function)")
    }
    
    func testGcd() {
        XCTAssert(8.gcd(of: 20) == 4, "Couldn't get correct value for \(#function)")
    }
    
    func testLcm() {
        XCTAssert(4.lcm(of: 3) == 12, "Couldn't get correct value for \(#function)")
    }
    
    func testRandomBetween() {
        let random = Int.randomBetween(min: 10, max: 20)
        XCTAssert(random >= 10 && random < 20, "Couldn't get correct value for \(#function)")
    }
    
    override func tearDown() {
        super.tearDown()
    }
}
