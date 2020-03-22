//
//  UISearchBarExtensionsTests.swift
//  SwifterSwift
//
//  Created by Omar Albeik on 2/15/17.
//  Copyright © 2017 SwifterSwift
//

import XCTest
@testable import SwifterSwift

#if os(iOS)
import UIKit

final class UISearchBarExtensionsTests: XCTestCase {

    func testSearchBar() {
        let searchBar = UISearchBar()
        XCTAssert(searchBar.textField?.text?.isEmpty != false)

        let frame = CGRect(x: 0, y: 0, width: 100, height: 30)
        let aSearchBar = UISearchBar(frame: frame)
        aSearchBar.text = "Hello"
        XCTAssertNotNil(aSearchBar.textField)
        XCTAssertEqual(aSearchBar.textField?.text, "Hello")
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
