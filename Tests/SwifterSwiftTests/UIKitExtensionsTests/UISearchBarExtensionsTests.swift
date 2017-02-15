//
//  UISearchBarExtensionsTests.swift
//  SwifterSwift
//
//  Created by Omar Albeik on 2/15/17.
//  Copyright © 2017 omaralbeik. All rights reserved.
//

import XCTest
@testable import SwifterSwift

#if os(iOS)
	class UISearchBarExtensionsTests: XCTestCase {
		
		override func setUp() {
			super.setUp()
			// Put setup code here. This method is called before the invocation of each test method in the class.
		}
		
		override func tearDown() {
			// Put teardown code here. This method is called after the invocation of each test method in the class.
			super.tearDown()
		}
		
		func testSearchBar() {
			let searchBar = UISearchBar()
			XCTAssertNil(searchBar.textField)
			
			let frame = CGRect(x: 0, y: 0, width: 100, height: 30)
			let aSearchBar = UISearchBar(frame: frame)
			aSearchBar.text = "Hello"
			XCTAssertNotNil(aSearchBar.textField)
		}
		
		func testTrimmedText() {
			let frame = CGRect(x: 0, y: 0, width: 100, height: 30)
			let aSearchBar = UISearchBar(frame: frame)
			aSearchBar.text = "Hello \n    \n"
			XCTAssertNotNil(aSearchBar.trimmedText)
			XCTAssertEqual(aSearchBar.trimmedText!, "Hello")
		}
		
		func testClear() {
			let frame = CGRect(x: 0, y: 0, width: 100, height: 30)
			let aSearchBar = UISearchBar(frame: frame)
			aSearchBar.text = "Hello"
			aSearchBar.clear()
			XCTAssertEqual(aSearchBar.text!, "")
		}
		
	}
#endif
