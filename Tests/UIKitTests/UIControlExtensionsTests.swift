//
//  UIControlExtensionsTests.swift
//  SwifterSwift
//
//  Created by zeng on 2018/12/29.
//  Copyright © 2018 SwifterSwift
//

import XCTest
@testable import SwifterSwift
#if canImport(UIKit)
import UIKit

class UIControlExtensionsTests: XCTestCase {

    func testForAddClosure() {
        var flag = false
        let control = UIControl()

        control.addClosure(for: .touchUpInside, with: { _ in
            flag = true
            print("touchUpInside click")
        })

        control.sendActions(for: .touchUpInside)
        XCTAssertEqual(flag, true)
    }

    func testForSetClosure() {
        var flag = 0
        let control = UIControl()

        control.addClosure(for: .touchUpInside, with: { _ in
            flag = 1
            print("[addClosure] value--> ", flag)
        })
        control.sendActions(for: .touchUpInside)
        XCTAssertEqual(flag, 1)

        control.setClosure(for: .touchUpInside, with: { _ in
            flag = 2
            print("[setClosure] value--> ", flag)
        })

        control.sendActions(for: .touchUpInside)
        XCTAssertEqual(flag, 2)
    }

}
#endif
