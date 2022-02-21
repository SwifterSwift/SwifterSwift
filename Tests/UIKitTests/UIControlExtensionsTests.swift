//  UIControlExtensionsTests.swift - Copyright 2022 SwifterSwift

@testable import SwifterSwift
import XCTest

#if canImport(UIKit)
import UIKit

final class UIControlExtensionsTests: XCTestCase {
    
    func simulateEvent(_ event: UIControl.Event, for control: UIControl) {
        // https://stackoverflow.com/questions/58519479/xctestcase-of-a-uibutton-tap
        for target in control.allTargets {
            let target = target as NSObjectProtocol
            for actionName in control.actions(forTarget: target, forControlEvent: event) ?? [] {
                let selector = Selector(actionName)
                target.perform(selector)
            }
        }
    }
    
    func testOn() {
        let control = UIButton()
        let expectation = self.expectation(description: "Action")
        
        control.on(.touchUpInside) {
            expectation.fulfill()
        }
        simulateEvent(.touchUpInside, for: control)
        waitForExpectations(timeout: 0.1, handler: nil)
    }
}
#endif
