//
//  LocaleExtensionsTests.swift
//  SwifterSwift
//
//  Created by Basem Emara on 4/19/17.
//  Copyright © 2017 SwifterSwift
//

import XCTest
@testable import SwifterSwift

final class LocaleExtensionsTests: XCTestCase {
    
    func testPosix() {
        let test: Locale = .posix
        XCTAssertEqual(test.identifier, "en_US_POSIX")
    }
}
