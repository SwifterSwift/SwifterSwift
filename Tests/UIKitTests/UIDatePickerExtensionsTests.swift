//
//  UIDatePickerExtensionsTests.swift
//  SwifterSwift
//
//  Created by Omar Albeik on 12/9/17.
//  Copyright © 2017 SwifterSwift
//

import XCTest
@testable import SwifterSwift

#if canImport(UIKit) && !os(watchOS)
import UIKit

final class UIDatePickerExtensionsTests: XCTestCase {

    func testTextColor() {
        let datePicker = UIDatePicker()
        XCTAssertNil(datePicker.textColor)

        datePicker.textColor = .red
        XCTAssertEqual(datePicker.textColor, .red)

        datePicker.textColor = .green
        XCTAssertEqual(datePicker.textColor, .green)

        datePicker.textColor = nil
        XCTAssertNil(datePicker.textColor)
    }

}
#endif
