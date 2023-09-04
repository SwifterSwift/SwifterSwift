//
//  DecimalExtensionsTests.swift
//  SwifterSwift
//
//  Created by Viktar Tsialitsyn on 04/09/2023.
//  Copyright © 2023 SwifterSwift
//

import XCTest
@testable import SwifterSwift

final class DecimalExtensionsTests: XCTestCase {

    func testDoubleValue() {
        XCTAssertEqual(Decimal(12345).doubleValue, Double(12345))
        XCTAssertEqual(Decimal(0).doubleValue, Double(0))
        XCTAssertEqual(Decimal(12345.2).doubleValue, Double(12345.2))
        XCTAssertLessThanOrEqual(abs(Decimal(1234.5678).doubleValue - Double(1234.5678)), 0.00001)
    }

}
