//
//  SignedNumericExtensionsTests.swift
//  SwifterSwift
//
//  Created by Omar Albeik on 10/7/17.
//  Copyright © 2017 SwifterSwift
//

import XCTest
@testable import SwifterSwift

final class SignedNumericExtensionsTests: XCTestCase {

    func testString() {
        let number1: Double = -1.2
        XCTAssertEqual(number1.string, "-1.2")

        let number2: Float = 2.3
        XCTAssertEqual(number2.string, "2.3")
    }

    func testAsLocaleCurrency() {
        let number1: Double = 3.2
        XCTAssertEqual(number1.asLocaleCurrency, "$3.20")

        let number2 = Double(10.23)
        if let symbol = Locale.current.currencySymbol {
            XCTAssertNotNil(number2.asLocaleCurrency!)
            XCTAssert(number2.asLocaleCurrency!.contains(symbol))
        }
        XCTAssertNotNil(number2.asLocaleCurrency!)
        XCTAssert(number2.asLocaleCurrency!.contains("\(number2)"))

        let number3 = 10
        if let symbol = Locale.current.currencySymbol {
            XCTAssertNotNil(number3.asLocaleCurrency)
            XCTAssert(number3.asLocaleCurrency!.contains(symbol))
        }
        XCTAssertNotNil(number3.asLocaleCurrency)
        XCTAssert(number3.asLocaleCurrency!.contains("\(number3)"))
    }

}
