//
//  UIViewExtensionsTests.swift
//  SwifterSwift
//
//  Created by Omar Albeik on 2/15/17.
//  Copyright © 2017 omaralbeik. All rights reserved.
//

import XCTest
@testable import SwifterSwift

#if os(iOS) || os(tvOS)
	class UIViewExtensionsTests: XCTestCase {
		
		override func setUp() {
			super.setUp()
			// Put setup code here. This method is called before the invocation of each test method in the class.
		}
		
		override func tearDown() {
			// Put teardown code here. This method is called after the invocation of each test method in the class.
			super.tearDown()
		}
		
		func testBorderColor() {
			let frame = CGRect(x: 0, y: 0, width: 100, height: 100)
			let view = UIView(frame: frame)
			view.borderColor = nil
			XCTAssertNil(view.layer.borderColor)
			
			view.borderColor = UIColor.red
			XCTAssertNotNil(view.layer.borderColor)
			XCTAssertEqual(view.borderColor!, UIColor.red)
			XCTAssertEqual(view.layer.borderColor!.uiColor, UIColor.red)
		}
		
		func testBorderWidth() {
			let frame = CGRect(x: 0, y: 0, width: 100, height: 100)
			let view = UIView(frame: frame)
			view.borderWidth = 0
			XCTAssertEqual(view.layer.borderWidth, 0)
			
			view.borderWidth = 5
			XCTAssertEqual(view.borderWidth, 5)
		}
		
		func testCornerRadius() {
			let frame = CGRect(x: 0, y: 0, width: 100, height: 100)
			let view = UIView(frame: frame)
			XCTAssertEqual(view.layer.cornerRadius, 0)
			
			view.cornerRadius = 50
			XCTAssertEqual(view.cornerRadius, 50)
		}
		
		func testHeight() {
			let frame = CGRect(x: 0, y: 0, width: 100, height: 100)
			let view = UIView(frame: frame)
			XCTAssertEqual(view.height, 100)
			view.height = 150
			XCTAssertEqual(view.frame.size.height, 150)
		}
		
		func testShadowColor() {
			let frame = CGRect(x: 0, y: 0, width: 100, height: 100)
			let view = UIView(frame: frame)
			view.layer.shadowColor = nil
			XCTAssertNil(view.shadowColor)
			view.shadowColor = UIColor.orange
			XCTAssertNotNil(view.layer.shadowColor!)
			XCTAssertEqual(view.layer.shadowColor!.uiColor, UIColor.orange)
		}
		
		func testShadowOffset() {
			let frame = CGRect(x: 0, y: 0, width: 100, height: 100)
			let view = UIView(frame: frame)
			view.layer.shadowOffset = CGSize.zero
			XCTAssertEqual(view.shadowOffset, CGSize.zero)
			let size = CGSize(width: 5, height: 5)
			view.shadowOffset = size
			XCTAssertEqual(view.layer.shadowOffset, size)
		}
		
		func testShadowOpacity() {
			let frame = CGRect(x: 0, y: 0, width: 100, height: 100)
			let view = UIView(frame: frame)
			view.layer.shadowOpacity = 0
			XCTAssertEqual(view.shadowOpacity, 0)
			view.shadowOpacity = 0.5
			XCTAssertEqual(view.layer.shadowOpacity, 0.5)
		}
		
		func testShadowRadius() {
			let frame = CGRect(x: 0, y: 0, width: 100, height: 100)
			let view = UIView(frame: frame)
			view.layer.shadowRadius = 0
			XCTAssertEqual(view.shadowRadius, 0)
			view.shadowRadius = 0.5
			XCTAssertEqual(view.layer.shadowRadius, 0.5)
		}
		
		func testSize() {
			let frame = CGRect(x: 0, y: 0, width: 100, height: 100)
			let view = UIView(frame: frame)
			XCTAssertEqual(view.size, view.frame.size)
			
			view.size = CGSize(width: 50, height: 50)
			XCTAssertEqual(view.frame.size.width, 50)
			XCTAssertEqual(view.frame.size.height, 50)
		}
		
		func testParentViewController() {
			let vc = UIViewController()
			XCTAssertNotNil(vc.view.parentViewController)
			XCTAssertEqual(vc.view.parentViewController, vc)
			
			let frame = CGRect(x: 0, y: 0, width: 100, height: 100)
			let view = UIView(frame: frame)
			XCTAssertNil(view.parentViewController)
		}
		
		func testWidth() {
			let frame = CGRect(x: 0, y: 0, width: 100, height: 100)
			let view = UIView(frame: frame)
			XCTAssertEqual(view.width, 100)
			view.width = 150
			XCTAssertEqual(view.frame.size.width, 150)
		}
		
		func testAddSubviews() {
			let frame = CGRect(x: 0, y: 0, width: 100, height: 100)
			let view = UIView(frame: frame)
			XCTAssertEqual(view.subviews.count, 0)
			
			view.addSubviews([UIView(), UIView()])
			XCTAssertEqual(view.subviews.count, 2)
		}
		
		func testRemoveSubviews() {
			let view = UIView()
			view.addSubviews([UIView(), UIView()])
			view.removeSubviews()
			XCTAssertEqual(view.subviews.count, 0)
		}
		
		func testRemoveGestureRecognizers() {
			let view = UIView()
			XCTAssertNil(view.gestureRecognizers)
			view.removeGestureRecognizers()
			XCTAssertNil(view.gestureRecognizers)
			
			let tap = UIGestureRecognizer(target: nil, action: nil)
			view.addGestureRecognizer(tap)
			XCTAssertNotNil(view.gestureRecognizers)
			view.removeGestureRecognizers()
			XCTAssertEqual(view.gestureRecognizers!.count, 0)
		}
		
		
	}
#endif
