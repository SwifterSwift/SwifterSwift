//
//  CharacterExtensionsTests.swift
//  SwiftierSwift
//
//  Created by Omar Albeik on 8/9/16.
//  Copyright © 2016 Omar Albeik. All rights reserved.
//

import XCTest
@testable import SwiftierSwift

class CharacterExtensionsTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        tearDown()
    }
    
    func testLocale() {
        XCTAssert(Character("T").locale == Locale.current, "Couldn't get correct value for \(#function)")
    }
    
    func testIsNumber() {
        XCTAssert(Character("1").isNumber == true && Character("T").isNumber == false, "Couldn't get correct value for \(#function)")
    }
    
    func testToString() {
        XCTAssert(Character("1").toString == "1", "Couldn't get correct value for \(#function)")
    }
    
    func testToInt() {
        XCTAssert(Character("1").toInt! == 1 && Character("T").toInt == nil, "Couldn't get correct value for \(#function)")
    }
    
    override func tearDown() {
        super.tearDown()
    }
}
