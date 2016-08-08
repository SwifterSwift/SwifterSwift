//
//  StringExtensionsTests.swift
//  SwiftierSwift
//
//  Created by Omar Albeik on 8/8/16.
//  Copyright © 2016 Omar Albeik. All rights reserved.
//

import XCTest
@testable import SwiftierSwift


class StringExtensionsTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        tearDown()
    }
    
    let str = "Hello Tests"
    
    func testLocale() {
        XCTAssert(str.locale == Locale.current, "Couldn't get correct locale from string")
    }
    
    func testCount() {
        XCTAssert(str.count(of: "e") == 2, "Couldn't get correct value for count function")
    }
    
    func testContain() {
        XCTAssert(str.contains("Hello") == true, "Couldn't get correct value for count function")
    }
    
    func testStarts() {
        XCTAssert(str.starts(with: "He"), "Couldn't get correct value for starts function")
    }
    
    func testEnds() {
        XCTAssert(str.ends(with: "sts"), "Couldn't get correct value for \(#function) function")
    }
    
    func testEmpty() {
        let emptyStr = " \n"
        XCTAssert(emptyStr.empty == true && str.empty == false, "Couldn't get correct value for empty")
    }
    
    func testSplit() {
        XCTAssert(str.split(by: " ") == ["Hello", "Tests"], "Couldn't get correct value for split function")
    }
    
    func testTrimmed() {
        XCTAssert("\n Hello \n ".trimmed == "Hello", "Couldn't get correct value for \(#function) function")
    }
    
    func testTrimmed() {
        let str = "\n Hello \n "
        XCTAssert(str.trimmed == "Hello", "Couldn't get correct value for \(#function) function")
    }
    
    
    
    override func tearDown() {
        super.tearDown()
    }
}
