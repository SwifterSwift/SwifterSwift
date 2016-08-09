//
//  DoubleExtensionsTests.swift
//  SwiftierSwift
//
//  Created by Omar Albeik on 8/9/16.
//  Copyright © 2016 Omar Albeik. All rights reserved.
//

import XCTest
@testable import SwiftierSwift

class DoubleExtensionsTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        tearDown()
    }
    
    func testAbs() {
        XCTAssert((-10.0).abs == 10.0, "Couldn't get correct value for \(#function)")
    }
    
    func testFloor() {
        XCTAssert((10.23).floor == 10.0, "Couldn't get correct value for \(#function)")
    }
    
    func testCeil() {
        XCTAssert((10.23).ceil == 11.0, "Couldn't get correct value for \(#function)")
    }
    
    func testRandomBetween() {
        let random = Double.randomBetween(min: 10, max: 20)
        XCTAssert(random >= 10 && random < 20, "Couldn't get correct value for \(#function)")
    }
    
    override func tearDown() {
        super.tearDown()
    }
}
