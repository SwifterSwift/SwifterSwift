// SignedNumericExtensionsTests.swift - Copyright 2026 SwifterSwift

@testable import SwifterSwift
import Foundation
import XCTest

final class SignedNumericExtensionsTests: XCTestCase {
    func testString() {
        let number1: Double = -1.2
        XCTAssertEqual(number1.string, "-1.2")

        let number2: Float = 2.3
        XCTAssertEqual(number2.string, "2.3")
    }

    func testAsLocaleCurrency() {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.locale = .current
        func expectedCurrency(for value: some SignedNumeric) -> String? {
            return formatter.string(from: value as? NSNumber ?? 0)
        }

        let number1 = 3.2
        XCTAssertEqual(number1.asLocaleCurrency, expectedCurrency(for: number1), "Failed to format number with locale \(Locale.current)")

        let number2 = Double(10.23)
        XCTAssertEqual(number2.asLocaleCurrency, expectedCurrency(for: number2))

        let number3 = 10
        XCTAssertEqual(number3.asLocaleCurrency, expectedCurrency(for: number3))
    }
}
