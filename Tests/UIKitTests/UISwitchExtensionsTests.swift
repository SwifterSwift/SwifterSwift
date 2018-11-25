//
//  UISwitchExtensionsTests.swift
//  SwifterSwift
//
//  Created by Omar Albeik on 2/15/17.
//  Copyright © 2017 SwifterSwift
//

import XCTest
@testable import SwifterSwift

#if os(iOS)
import UIKit

final class UISwitchExtensionsTests: XCTestCase {

    func testToggle() {
        let frame = CGRect(x: 0, y: 0, width: 100, height: 30)
        let aSwitch = UISwitch(frame: frame)
        XCTAssertFalse(aSwitch.isOn)
        aSwitch.toggle(animated: false)
        XCTAssert(aSwitch.isOn)
    }

}
#endif
