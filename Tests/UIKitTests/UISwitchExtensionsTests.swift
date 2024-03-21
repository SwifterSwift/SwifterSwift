// UISwitchExtensionsTests.swift - Copyright 2024 SwifterSwift

@testable import SwifterSwift
import XCTest

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
