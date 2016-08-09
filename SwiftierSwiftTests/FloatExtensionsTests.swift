//
//  FloatExtensionsTests.swift
//  SwiftierSwift
//
//  Created by Omar Albeik on 8/9/16.
//  Copyright © 2016 Omar Albeik. All rights reserved.
//

import XCTest
@testable import SwiftierSwift

class FloatExtensionsTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        tearDown()
    }
    
    func testAbs() {
        XCTAssert(Float(-10.0).abs == Float(10.0), "Couldn't get correct value for \(#function)")
    }
    
    func testFloor() {
        XCTAssert(Float(10.23).floor == Float(10.0), "Couldn't get correct value for \(#function)")
    }
    
    func testCeil() {
        XCTAssert(Float(10.23).ceil == Float(11.0), "Couldn't get correct value for \(#function)")
    }
    
    func testRandomBetween() {
        let random = Float.randomBetween(min: 10, max: 20)
        XCTAssert(random >= 10 && random < 20, "Couldn't get correct value for \(#function)")
    }
    
    override func tearDown() {
        super.tearDown()
    }
}
