//
//  UIButtonExtensionsTests.swift
//  SwifterSwift
//
//  Created by Steven on 2/14/17.
//  Copyright © 2017 omaralbeik. All rights reserved.
//

#if os(iOS) || os(tvOS)
	
	import XCTest
	@testable import SwifterSwift
	
	class UIButtonExtensionsTests: XCTestCase {
		
		override func setUp() {
			super.setUp()
			// Put setup code here. This method is called before the invocation of each test method in the class.
		}
		
		override func tearDown() {
			// Put teardown code here. This method is called after the invocation of each test method in the class.
			super.tearDown()
		}
		
		func testImageForDisabled() {
			
			let button = UIButton()
			XCTAssertEqual(button.imageForDisabled, button.image(for: .disabled))
			
			let newImage = UIImage()
			button.imageForDisabled = newImage
			XCTAssertEqual(button.imageForDisabled, newImage)
		}
		
		func testImageForHighlighted() {
			
			let button = UIButton()
			XCTAssertEqual(button.imageForHighlighted, button.image(for: .highlighted))
			
			let newImage = UIImage()
			button.imageForHighlighted = newImage
			XCTAssertEqual(button.imageForHighlighted, newImage)
		}
		
		func testImageForNormal() {
			
			let button = UIButton()
			XCTAssertEqual(button.imageForNormal, button.image(for: .normal))
			
			let newImage = UIImage()
			button.imageForNormal = newImage
			XCTAssertEqual(button.imageForNormal, newImage)
		}
		
		func testImageForSelected() {
			
			let button = UIButton()
			XCTAssertEqual(button.imageForSelected, button.image(for: .selected))
			
			let newImage = UIImage()
			button.imageForSelected = newImage
			XCTAssertEqual(button.imageForSelected, newImage)
		}
		
		func testTitleColorForDisabled() {
			
			let button = UIButton()
			XCTAssertEqual(button.titleColorForDisabled, button.titleColor(for: .disabled))
			
			button.titleColorForDisabled = .black
			XCTAssertEqual(button.titleColorForDisabled, .black)
		}
		
		func testTitleColorForHighlighted() {
			
			let button = UIButton()
			XCTAssertEqual(button.titleColorForHighlighted, button.titleColor(for: .highlighted))
			
			button.titleColorForHighlighted = .black
			XCTAssertEqual(button.titleColorForHighlighted, .black)
		}
		
		func testTitleColorForNormal() {
			
			let button = UIButton()
			XCTAssertEqual(button.titleColorForNormal, button.titleColor(for: .normal))
			
			button.titleColorForNormal = .black
			XCTAssertEqual(button.titleColorForNormal, .black)
		}
		
		func testTitleColorForSelected() {
			
			let button = UIButton()
			XCTAssertEqual(button.titleColorForSelected, button.titleColor(for: .selected))
			
			button.titleColorForSelected = .black
			XCTAssertEqual(button.titleColorForSelected, .black)
		}
		
		func testTitleForDisabled() {
			
			let button = UIButton()
			XCTAssertEqual(button.titleForDisabled, button.title(for: .disabled))
			
			let title = "Disabled"
			button.titleForDisabled = title
			XCTAssertEqual(button.titleForDisabled, title)
		}
		
		func testTitleForHighlighted() {
			
			let button = UIButton()
			XCTAssertEqual(button.titleForHighlighted, button.title(for: .highlighted))
			
			let title = "Highlighted"
			button.titleForHighlighted = title
			XCTAssertEqual(button.titleForHighlighted, title)
		}
		
		func testTitleForNormal() {
			
			let button = UIButton()
			XCTAssertEqual(button.titleForNormal, button.title(for: .normal))
			
			let title = "Normal"
			button.titleForNormal = title
			XCTAssertEqual(button.titleForNormal, title)
		}
		
		func testTitleForSelected() {
			
			let button = UIButton()
			XCTAssertEqual(button.titleForSelected, button.title(for: .selected))
			
			let title = "Selected"
			button.titleForSelected = title
			XCTAssertEqual(button.titleForSelected, title)
		}
		
		func testSetImageForAllStates() {
			
			let button = UIButton()
			let image = UIImage()
			button.setImageForAllStates(image)
			
			XCTAssertEqual(button.imageForDisabled, image)
			XCTAssertEqual(button.imageForHighlighted, image)
			XCTAssertEqual(button.imageForNormal, image)
			XCTAssertEqual(button.imageForSelected, image)
		}
		
		func testSetTitleColorForAllStates() {
			
			let button = UIButton()
			let color = UIColor.white
			button.setTitleColorForAllStates(color)
			
			XCTAssertEqual(button.titleColorForDisabled, color)
			XCTAssertEqual(button.titleColorForHighlighted, color)
			XCTAssertEqual(button.titleColorForNormal, color)
			XCTAssertEqual(button.titleColorForSelected, color)
		}
		
		func testSetTitleForAllStates() {
			
			let button = UIButton()
			let title = "Title"
			button.setTitleForAllStates(title)
			
			XCTAssertEqual(button.titleForDisabled, title)
			XCTAssertEqual(button.titleForHighlighted, title)
			XCTAssertEqual(button.titleForNormal, title)
			XCTAssertEqual(button.titleForSelected, title)
		}
	}
#endif
