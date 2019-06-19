//
//  CharacterExtensionsTests.swift
//  SwifterSwift
//
//  Created by Omar Albeik on 8/27/16.
//  Copyright © 2016 SwifterSwift
//

//
//  CharacterExtensionsTests.swift
//  SwifterSwift
//
//  Created by Omar Albeik on 8/27/16.
//  Copyright © 2016 SwifterSwift
//

import XCTest
@testable import SwifterSwift

final class CharacterExtensionsTests: XCTestCase {

    func testIsEmoji() {
        XCTAssert(Character("😂").isEmoji)
        XCTAssertFalse(Character("j").isEmoji)
    }

    func testInt() {
        XCTAssertNotNil(Character("1").int)
        XCTAssertEqual(Character("1").int, 1)
        XCTAssertNil(Character("s").int)
    }

    func testString() {
        XCTAssertEqual(Character("s").string, String("s"))
    }

    func testUppercased() {
        XCTAssertEqual(Character("s").uppercased, Character("S"))
    }

    func testLowercased() {
        XCTAssertEqual(Character("S").lowercased, Character("s"))
    }
    func testRandom() {
        var string1 = String()
        var string2 = String()
        for _ in 0..<10 {
            string1.append(Character.randomAlphanumeric())
            string2.append(Character.randomAlphanumeric())
        }
        XCTAssertNotEqual(string1, string2)
    }

    func testOperators() {
        let sLetter = Character("s")
        XCTAssertEqual(sLetter * 5, "sssss")
        XCTAssertEqual(5 * sLetter, "sssss")

        XCTAssertEqual(sLetter * 0, "")
        XCTAssertEqual(0 * sLetter, "")

        XCTAssertEqual(sLetter * -5, "")
        XCTAssertEqual(-5 * sLetter, "")
    }

}
