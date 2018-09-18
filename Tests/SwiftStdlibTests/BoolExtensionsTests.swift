//
//  BoolExtensionsTests.swift
//  SwifterSwift
//
//  Created by Omar Albeik on 20/01/2017.
//  Copyright © 2017 SwifterSwift
//

import XCTest
@testable import SwifterSwift

final class BoolExtensionsTests: XCTestCase {

    func testInt() {
        XCTAssertEqual(true.int, 1)
        XCTAssertEqual(false.int, 0)
    }

    func testString() {
        XCTAssertEqual(true.string, "true")
        XCTAssertEqual(false.string, "false")
    }

}
