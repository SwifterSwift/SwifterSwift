//
//  UISliderExtensionsTests.swift
//  SwifterSwift
//
//  Created by Steven on 2/16/17.
//  Copyright © 2017 omaralbeik. All rights reserved.
//

#if os(iOS)
    
import XCTest
@testable import SwifterSwift

class UISliderExtensionsTests: XCTestCase {

    func testSetValue() {
        let slider = UISlider()
        slider.minimumValue = 0
        slider.maximumValue = 100
        var completionCalled = false
        
        slider.setValue(99) {
            completionCalled = true
            XCTAssert(completionCalled)
        }
        XCTAssert(slider.value == 99)
        
        completionCalled = false
        XCTAssertFalse(completionCalled)
        
        slider.setValue(50, animated: false, duration: 2) {
            completionCalled = true
            XCTAssert(completionCalled)
        }
        XCTAssert(slider.value == 50)
    }
}
#endif
