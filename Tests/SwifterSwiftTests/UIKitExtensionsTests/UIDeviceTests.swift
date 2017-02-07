//
//  UIDeviceTests.swift
//  SwifterSwift
//
//  Created by Michal Kowalski on 07/02/2017.
//  Copyright © 2017 omaralbeik. All rights reserved.
//

import XCTest

class UIDeviceTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testDeviceType() {
        XCTAssertEqual(UIDevice.current.isIPad(), UIDevice.current.userInterfaceIdiom == .pad)
        XCTAssertEqual(UIDevice.current.isIPhone(), UIDevice.current.userInterfaceIdiom == .phone)
    }
    
}
