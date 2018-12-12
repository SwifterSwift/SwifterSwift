//
//  NSMutableAttributedStringTest.swift
//  SwifterSwift
//
//  Created by ratul sharker on 12/13/18.
//  Copyright © 2018 SwifterSwift
//

import XCTest
@testable import SwifterSwift

#if canImport(Foundation)
import Foundation

final class NSMutableAttributedStringTest: XCTestCase {
    public func testApplyingColors() {
        let testAttrStr = NSMutableAttributedString(string: "HELLO WORLD")

        testAttrStr.applying(colors: [.red, .green, .blue], substring: "WOR")
        let redAttribute = testAttrStr.attributes(at: 6, effectiveRange: nil)
        let greenAttribute = testAttrStr.attributes(at: 7, effectiveRange: nil)
        let blueAttribute = testAttrStr.attributes(at: 8, effectiveRange: nil)

        let redApplied = redAttribute.filter({ (key, value) -> Bool in
            return key == NSAttributedString.Key.foregroundColor &&
                    (value as? UIColor) == UIColor.red
        })
        let greenApplied = greenAttribute.filter({ (key, value) -> Bool in
            return key == NSAttributedString.Key.foregroundColor &&
                    (value as? UIColor) == UIColor.green
        })
        let blueApplied = blueAttribute.filter({ (key, value) -> Bool in
            return key == NSAttributedString.Key.foregroundColor &&
                    (value as? UIColor) == UIColor.blue
        })

        XCTAssertEqual(redApplied.count, 1)
        XCTAssertEqual(greenApplied.count, 1)
        XCTAssertEqual(blueApplied.count, 1)
    }
}

#endif
