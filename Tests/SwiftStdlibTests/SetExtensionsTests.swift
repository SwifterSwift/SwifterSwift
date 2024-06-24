// SetExtensionsTests.swift - Copyright 2024 SwifterSwift

import Foundation
@testable import SwifterSwift
import XCTest

final class SetExtensionsTests: XCTestCase {
    func testToggle() {
        var numSet: Set<Int> = [1, 2, 3]
        numSet.toggle(1)
        XCTAssertEqual(numSet, [2, 3])
        numSet.toggle(1)
        XCTAssertEqual(numSet, [1, 2, 3])
    }
}
