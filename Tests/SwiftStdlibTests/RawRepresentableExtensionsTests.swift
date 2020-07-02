//
//  RawRepresentableExtensionsTests.swift
//  SwifterSwift
//
//  Created by 方林威 on 2020/7/1.
//  Copyright © 2020 SwifterSwift
//

import XCTest
@testable import SwifterSwift

final class RawRepresentableExtensionsTests: XCTestCase {

    func testOptionalRawValueInitializer() {
        private enum Animal: String {
            case cat, dog
        }
        
        XCTAssertNil(Animal(rawValue: nil))

        let optionalString1: String? = "cat"
        let optionalString2: String? = "dog"
        XCTAssertEqual(Animal(rawValue: optionalString1), Animal.cat)
        XCTAssertEqual(Animal(rawValue: optionalString1)?.rawValue, Animal.cat.rawValue)
        XCTAssertEqual(Animal(rawValue: optionalString2), Animal.dog)
        XCTAssertEqual(Animal(rawValue: optionalString2)?.rawValue, Animal.dog.rawValue)
    }
}
