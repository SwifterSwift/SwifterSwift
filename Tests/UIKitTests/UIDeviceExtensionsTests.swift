//
//  UIDeviceExtensionsTests.swift
//  SwifterSwift
//
//  Created by Anton Novoselov on 31/12/2017.
//  Copyright © 2017 SwifterSwift
//

import XCTest
@testable import SwifterSwift

final class UIDeviceExtensionsTests: XCTestCase {
    func testCountryISOCode() {
        XCTAssertNotNil(UIDevice.countryISOCode)
    }
}
