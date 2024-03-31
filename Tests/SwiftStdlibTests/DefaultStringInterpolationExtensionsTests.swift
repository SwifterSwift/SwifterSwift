// DefaultStringInterpolationExtensionsTests.swift - Copyright 2024 SwifterSwift

@testable import SwifterSwift
import XCTest

// swiftlint:disable:next type_name
final class DefaultStringInterpolationExtensionsTests: XCTestCase {
    func testStringInterpolationPlaceholder() {
        var token: Int?
        XCTAssertEqual("\(token, placeholder: "-")", "-")
        XCTAssertEqual("\(token, placeholder: "*")", "*")
        XCTAssertEqual("\(token, placeholder: "-", where: { $0 > 0 })", "-")
        token = 0
        XCTAssertEqual("\(token, placeholder: "-")", "0")
        XCTAssertEqual("\(token, placeholder: "-", where: { $0 > 0 })", "-")
    }
}
