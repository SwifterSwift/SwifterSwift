// BidirectionalCollectionExtensionsTests.swift - Copyright 2020 SwifterSwift

@testable import SwifterSwift
import XCTest

final class BidirectionalCollectionExtensionsTests: XCTestCase {
    func testOffsetSubscript() {
        let arr = [1, 2, 3, 4, 5]
        XCTAssertEqual(arr[offset: 0], 1)
        XCTAssertEqual(arr[offset: 4], 5)
        XCTAssertEqual(arr[offset: -2], 4)
    }
}
