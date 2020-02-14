//
//  RawRepresentableExtensionsTests.swift
//  SwifterSwift
//
//  Created by Guy Kogus on 14/2/20.
//  Copyright © 2020 SwifterSwift
//

import XCTest
@testable import SwifterSwift

final class RawRepresentableExtensionsTests: XCTestCase {

    func testEqualsRawValue() {
        let summer = Season.summer

        let summerString = "summer"
        XCTAssert(summer == summerString)
        XCTAssert(summerString == summer)

        let summerStringOptional: String? = "summer"
        XCTAssert(summer == summerStringOptional)
        XCTAssert(summerStringOptional == summer)

        let nilString: String? = nil
        XCTAssertFalse(summer == nilString)
        XCTAssertFalse(nilString == summer)
    }

}
