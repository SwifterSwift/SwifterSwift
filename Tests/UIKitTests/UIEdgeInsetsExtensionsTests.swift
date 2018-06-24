//
//  UIEdgeInsetsExtensionsTests.swift
//  SwifterSwift
//
//  Created by Luciano Almeida on 15/06/18.
//  Copyright © 2018 SwifterSwift
//

#if !os(macOS)

import XCTest
@testable import SwifterSwift

final class UIEdgeInsetsExtensionsTests: XCTestCase {

    func testHorizontal() {
        let inset = UIEdgeInsets(top: 30.0, left: 5.0, bottom: 5.0, right: 10.0)
        XCTAssertEqual(inset.horizontal, 15.0)
    }

    func testVertical() {
        let inset = UIEdgeInsets(top: 10.0, left: 10.0, bottom: 5.0, right: 10.0)
        XCTAssertEqual(inset.vertical, 15.0)
    }

    func testInitInset() {
        let inset = UIEdgeInsets(inset: 5.0)
        XCTAssertEqual(inset.top, 5.0)
        XCTAssertEqual(inset.bottom, 5.0)
        XCTAssertEqual(inset.right, 5.0)
        XCTAssertEqual(inset.left, 5.0)
    }

    func testInitVerticalHorizontal() {
        let inset = UIEdgeInsets(horizontal: 20.0, vertical: 10.0)
        XCTAssertEqual(inset.top, 5.0)
        XCTAssertEqual(inset.bottom, 5.0)
        XCTAssertEqual(inset.right, 10.0)
        XCTAssertEqual(inset.left, 10.0)
    }
}

#endif
