//
//  EncodableExtensionsTests.swift
//  SwifterSwift
//
//  Created by zeero on 26/05/2019.
//  Copyright © 2019 SwifterSwift
//

import XCTest
@testable import SwifterSwift

final class EncodableExtensionsTests: XCTestCase {

    /// Stub
    private struct EncodableStruct: Encodable {
        let string: String
    }

    func testEncode() {
        let encodable = EncodableStruct(string: "test")
        guard let actual = try? encodable.encode() else {
            return XCTFail("Failed to encode.")
        }
        let expected = "{\"string\":\"test\"}"
        XCTAssertEqual(actual, expected)
    }

}
