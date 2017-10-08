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
final class UIViewExtensionsTests: XCTestCase {
	
	func testBorderColor() {
		let frame = CGRect(x: 0, y: 0, width: 100, height: 100)
		let view = UIView(frame: frame)
		view.borderColor = nil
		XCTAssertNil(view.borderColor)
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
	
	func testRoundCorners() {
		let frame = CGRect(x: 0, y: 0, width: 100, height: 100)
		let view = UIView(frame: frame)
		view.roundCorners([.allCorners], radius: 5.0)
		
		let maskPath = UIBezierPath(roundedRect: view.bounds,
		                            byRoundingCorners: [.allCorners],
		                            cornerRadii: CGSize(width: 5.0, height: 5.0))
		let shape = CAShapeLayer()
		shape.path = maskPath.cgPath
		XCTAssertEqual(view.layer.mask?.bounds, shape.bounds)
		XCTAssertEqual(view.layer.mask?.cornerRadius, shape.cornerRadius)

	}
	
	func testShadowColor() {
		let frame = CGRect(x: 0, y: 0, width: 100, height: 100)
		let view = UIView(frame: frame)
		view.layer.shadowColor = nil
		XCTAssertNil(view.shadowColor)
		view.shadowColor = UIColor.orange
		XCTAssertNotNil(view.layer.shadowColor!)
		XCTAssertEqual(view.shadowColor, UIColor.orange)
	}
	
	func testScreenshot() {
		let frame = CGRect(x: 0, y: 0, width: 100, height: 100)
		let view = UIView(frame: frame)
		view.backgroundColor = .black
		let screenshot = view.screenshot
		XCTAssertNotNil(screenshot)
		
		let view2 = UIView()
		XCTAssertNil(view2.screenshot)
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
	
	func testAddShadow() {
		let frame = CGRect(x: 0, y: 0, width: 100, height: 100)
		let view = UIView(frame: frame)
		view.addShadow(ofColor: .red, radius: 5.0, offset: .zero, opacity: 0.5)
		XCTAssertEqual(view.shadowColor, UIColor.red)
		XCTAssertEqual(view.shadowRadius, 5.0)
		XCTAssertEqual(view.shadowOffset, CGSize.zero)
		XCTAssertEqual(view.shadowOpacity, 0.5)
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
	
	func testX() {
		let frame = CGRect(x: 20, y: 20, width: 100, height: 100)
		let view = UIView(frame: frame)
		XCTAssertEqual(view.x, 20)
		view.x = 10
		XCTAssertEqual(view.frame.origin.x, 10)
	}
	
	func testY() {
		let frame = CGRect(x: 20, y: 20, width: 100, height: 100)
		let view = UIView(frame: frame)
		XCTAssertEqual(view.y, 20)
		view.y = 10
		XCTAssertEqual(view.frame.origin.y, 10)
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
	
	func testAnchor() {
		let view = UIView()
		let subview = UIView()
		view.addSubview(subview)
		subview.anchor(top: nil, left: nil, bottom: nil, right: nil)
		XCTAssert(subview.constraints.isEmpty)
		
		subview.anchor(top: view.topAnchor)
		XCTAssertNotNil(subview.topAnchor)
		
		subview.anchor(left: view.leftAnchor)
		XCTAssertNotNil(subview.leftAnchor)
		
		subview.anchor(bottom: view.bottomAnchor)
		XCTAssertNotNil(subview.bottomAnchor)
		
		subview.anchor(right: view.rightAnchor)
		XCTAssertNotNil(subview.rightAnchor)
		
		subview.anchor(widthConstant: 10.0, heightConstant: 10.0)
		XCTAssertNotNil(subview.widthAnchor)
		XCTAssertNotNil(subview.heightAnchor)
	}
	
	func testAnchorCenterXToSuperview() {
		let superview = UIView()
		let view = UIView()
		superview.addSubview(view)
		view.anchorCenterXToSuperview()
		let subview = UIView()
		view.addSubview(subview)
		view.anchorCenterXToSuperview(constant: 10.0)
		XCTAssertNotNil(subview.centerXAnchor)
	}
	
	func testAnchorCenterYToSuperview() {
		let superview = UIView()
		let view = UIView()
		superview.addSubview(view)
		view.anchorCenterXToSuperview()
		let subview = UIView()
		view.addSubview(subview)
		view.anchorCenterYToSuperview(constant: 10.0)
		XCTAssertNotNil(subview.centerYAnchor)
	}
	
	func testAnchorCenterToSuperview() {
		let superview = UIView()
		let view = UIView()
		superview.addSubview(view)
		view.anchorCenterSuperview()
		let subview = UIView()
		view.addSubview(subview)
		view.anchorCenterSuperview()
		XCTAssertNotNil(subview.centerXAnchor)
		XCTAssertNotNil(subview.centerYAnchor)
	}
	
}
#endif
