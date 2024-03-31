// UISearchBarExtensionsTests.swift - Copyright 2024 SwifterSwift

@testable import SwifterSwift
import XCTest

#if os(iOS)
import UIKit

final class UISearchBarExtensionsTests: XCTestCase {
    func testSearchBar() {
        let searchBar = UISearchBar()
        XCTAssertNotEqual(searchBar.textField?.text?.isEmpty, false)

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
