//
//  StringProtocolExtensionsTests.swift
//  SwifterSwift
//
//  Created by Max Härtwig on 11/26/17.
//  Copyright © 2017 SwifterSwift
//

import XCTest
@testable import SwifterSwift

final class StringProtocolExtensionsTests: XCTestCase {
    
    func testCommonSuffix() {
        let string1 = "Hello world!"
        let string2 = "It's cold!"
        XCTAssert(string1.commonSuffix(with: string2) == "ld!")
        
        let string3 = "你好世界"
        XCTAssert(string1.commonSuffix(with: string3).isEmpty)
    }
    
}
