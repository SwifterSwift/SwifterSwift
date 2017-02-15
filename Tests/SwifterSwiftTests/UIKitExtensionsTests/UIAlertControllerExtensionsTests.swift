//
//  UIAlertControllerExtensionsTests.swift
//  SwifterSwift
//
//  Created by Steven on 2/13/17.
//  Copyright © 2017 omaralbeik. All rights reserved.
//

#if os(iOS)
import XCTest
@testable import SwifterSwift

class UIAlertControllerExtensionsTests: XCTestCase {
	
	override func setUp() {
		super.setUp()
		// Put setup code here. This method is called before the invocation of each test method in the class.
	}
	
	override func tearDown() {
		// Put teardown code here. This method is called after the invocation of each test method in the class.
		super.tearDown()
	}
	
	func testAddAction() {

		let alertController = UIAlertController(title: "Title", message: "Message", preferredStyle: .alert)
		let discardedResult = alertController.addAction(title: "ActionTitle", style: .destructive, isEnabled: false, handler: nil)
		
		XCTAssertNotNil(discardedResult)
		
		XCTAssert(alertController.actions.count == 1)
		
		let action = alertController.actions.first
		
		XCTAssertEqual(action?.title, "ActionTitle")
		XCTAssertEqual(action?.style, .destructive)
		XCTAssertEqual(action?.isEnabled, false)
	}
	
	func testSelector() {}
	
	func testAddTextField() {
		
		let alertController = UIAlertController(title: "Title", message: "Message", preferredStyle: .alert)
		
		let selector = #selector(testSelector)
		
		alertController.addTextField(text: "TextField", placeholder: "PlaceHolder", editingChangedTarget: self, editingChangedSelector: selector)
		
		XCTAssert(alertController.textFields?.count == 1)
		
		let textField = alertController.textFields?.first
		
		XCTAssertEqual(textField?.text, "TextField")
		XCTAssertEqual(textField?.placeholder, "PlaceHolder")
		XCTAssertNotNil(textField?.allTargets)
		XCTAssertNotNil(textField?.actions(forTarget: self, forControlEvent: .editingChanged))
		
	}
	
	func testMessageInit() {
		
		let alertController = UIAlertController(title: "Title", message: "Message", defaultActionButtonTitle: "Ok", tintColor: .blue)
		
		XCTAssertNotNil(alertController)
		
		XCTAssertEqual(alertController.title, "Title")
		XCTAssertEqual(alertController.message, "Message")
		XCTAssertEqual(alertController.view.tintColor, .blue)
		
		XCTAssert(alertController.actions.count == 1)
		
		let defaultAction = alertController.actions.first
		
		XCTAssertEqual(defaultAction?.title, "Ok")
		XCTAssertEqual(defaultAction?.style, .default)
	}
	
	func testErrorInit() {
		
		enum TestError: Error { case error }
		let error = TestError.error
		
		let alertController = UIAlertController(title: "Title", error: error, defaultActionButtonTitle: "Ok", tintColor: .red)
		
		XCTAssertNotNil(alertController)
		
		XCTAssertEqual(alertController.title, "Title")
		XCTAssertEqual(alertController.message, error.localizedDescription)
		XCTAssertEqual(alertController.view.tintColor, .red)
		
		XCTAssert(alertController.actions.count == 1)
		
		let defaultAction = alertController.actions.first
		
		XCTAssertEqual(defaultAction?.title, "Ok")
		XCTAssertEqual(defaultAction?.style, .default)
	}
}
#endif
