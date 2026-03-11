// SignedNumericExtensionsTests.swift - Copyright 2026 SwifterSwift

@testable import SwifterSwift
import XCTest

final class SignedNumericExtensionsTests: XCTestCase {
    func testString() {
        let number1: Double = -1.2
        XCTAssertEqual(number1.string, "-1.2")

        let number2: Float = 2.3
        XCTAssertEqual(number2.string, "2.3")
    }

    func testAsLocaleCurrency() throws {
        #if !os(Linux) && !os(Android)
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.locale = Locale.current

        let number1 = 3.2
        XCTAssertEqual(number1.asLocaleCurrency,
                       formatter.string(from: number1 as NSNumber),
                       "Failed to format number with locale \(Locale.current)")

        let number2 = Double(10.23)
        XCTAssertEqual(number2.asLocaleCurrency,
                       formatter.string(from: number2 as NSNumber),
                       "Failed to format number with locale \(Locale.current)")

        let number3 = 10
        XCTAssertEqual(number3.asLocaleCurrency,
                       formatter.string(from: number3 as NSNumber),
                       "Failed to format number with locale \(Locale.current)")
        #else
        throw XCTSkip("Currency formatting not supported on this platform.")
        #endif
    }
}
