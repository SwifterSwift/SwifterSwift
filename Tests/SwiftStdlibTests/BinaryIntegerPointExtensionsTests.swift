//
//  BinaryIntegerPointExtensionsTests.swift
//  SwifterSwift
//
//  Created by calm on 2019/6/3.
//  Copyright © 2019 SwifterSwift
//

import XCTest
@testable import SwifterSwift

final class BinaryIntegerPointExtensionsTests: XCTestCase {

    func testInt() {
        XCTAssertTrue(0.isZero)
        XCTAssertFalse(1.isZero)
        XCTAssertFalse(100.isZero)
        
        let integer: Int = -10
        XCTAssertFalse(integer.isZero)
    }

}
