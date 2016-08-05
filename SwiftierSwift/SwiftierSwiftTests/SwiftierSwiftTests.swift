//
//  SwiftierSwiftTests.swift
//  SwiftierSwiftTests
//
//  Created by Omar Albeik on 8/5/16.
//  Copyright © 2016 Omar Albeik. All rights reserved.
//

import XCTest
@testable import SwiftierSwift

class SwiftierSwiftTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        tearDown()
    }
    
    func testUITextFieldExtensions() {
        
        let textField = UITextField()
        XCTAssert(textField.isEmpty == true, "Could not get correct value for empty textField")
        
        textField.text = "Some Text"
        XCTAssert(textField.isEmpty == false, "Could not get correct value for an textField with text")
    }
    
    func testStringExtensions() {
        
        let text = "Hello Test"
        
        // count(of string: String) test
        XCTAssert(text.count(of: "e") == 2, "Could not get correct count of substring in a string")
        
        // contain(string: String) test
        XCTAssert(text.contains("Test") == true && text.contains("Another text") == false, "Could not get correct value occurrence of substring in a string")
        
        // end(with suffix: String) test
        XCTAssert(text.end(with: "Test") == true && text.end(with: "Hello") == false, "Could not get correct value for occurrence of substring in the end of a string")
        
        // start(with prefix: String) test
        XCTAssert(text.start(with: "Hello") == true && text.start(with: "Test") == false, "Could not get correct value for occurrence of substring in the beginning of a string")

    }

    override func tearDown() {
        super.tearDown()
    }
    
}
