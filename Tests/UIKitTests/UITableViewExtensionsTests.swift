//
//  UITableViewExtensionsTests.swift
//  SwifterSwift
//
//  Created by Omar Albeik on 2/24/17.
//  Copyright © 2017 SwifterSwift
//

import XCTest
@testable import SwifterSwift

#if canImport(UIKit) && !os(watchOS)
import UIKit

final class UITableViewExtensionsTests: XCTestCase {

    let tableView = UITableView()
    let emptyTableView = UITableView()

    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        tableView.dataSource = self
        emptyTableView.dataSource = self
        tableView.reloadData()
    }

    func testIndexPathForLastRow() {
        XCTAssertEqual(tableView.indexPathForLastRow, IndexPath(row: 7, section: 1))
    }

    func testLastSection() {
        XCTAssertEqual(tableView.lastSection, 1)
        XCTAssertEqual(emptyTableView.lastSection, 0)
    }

    func testNumberOfRows() {
        XCTAssertEqual(tableView.numberOfRows(), 13)
        XCTAssertEqual(emptyTableView.numberOfRows(), 0)
    }

    func testIndexPathForLastRowInSection() {
        XCTAssertNil(tableView.indexPathForLastRow(inSection: -1))
        XCTAssertEqual(tableView.indexPathForLastRow(inSection: 0), IndexPath(row: 4, section: 0))
        XCTAssertEqual(UITableView().indexPathForLastRow(inSection: 0), IndexPath(row: 0, section: 0))
    }

    func testReloadData() {
        let exp = expectation(description: "reloadCallback")
        tableView.reloadData {
            XCTAssert(true)
            exp.fulfill()
        }
        waitForExpectations(timeout: 5, handler: nil)
    }

    func testRemoveTableFooterView() {
        tableView.tableFooterView = UIView()
        XCTAssertNotNil(tableView.tableFooterView)
        tableView.removeTableFooterView()
        XCTAssertNil(tableView.tableFooterView)
    }

    func testRemoveTableHeaderView() {
        tableView.tableHeaderView = UIView()
        XCTAssertNotNil(tableView.tableHeaderView)
        tableView.removeTableHeaderView()
        XCTAssertNil(tableView.tableHeaderView)
    }

    func testScrollToBottom() {
        let bottomOffset = CGPoint(x: 0, y: tableView.contentSize.height - tableView.bounds.size.height)
        tableView.scrollToBottom()
        XCTAssertEqual(bottomOffset, tableView.contentOffset)
    }

    func testScrollToTop() {
        tableView.scrollToTop()
        XCTAssertEqual(CGPoint.zero, tableView.contentOffset)
    }

    func testDequeueReusableCellWithClass() {
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "UITableViewCell")
        let cell = tableView.dequeueReusableCell(withClass: UITableViewCell.self)
        XCTAssertNotNil(cell)
    }

    func testDequeueReusableCellWithClassForIndexPath() {
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "UITableViewCell")
        let indexPath = tableView.indexPathForLastRow!
        let cell = tableView.dequeueReusableCell(withClass: UITableViewCell.self, for: indexPath)
        XCTAssertNotNil(cell)
    }

    func testDequeueReusableHeaderFooterView() {
        tableView.register(UITableViewHeaderFooterView.self,
                           forHeaderFooterViewReuseIdentifier: "UITableViewHeaderFooterView")
        let headerFooterView = tableView.dequeueReusableHeaderFooterView(withClass: UITableViewHeaderFooterView.self)
        XCTAssertNotNil(headerFooterView)
    }

    func testIsValidIndexPath() {
        let validIndexPath = IndexPath(row: 0, section: 0)
        XCTAssertTrue(tableView.isValidIndexPath(validIndexPath))
        let invalidIndexPath = IndexPath(row: 10, section: 0)
        XCTAssertFalse(tableView.isValidIndexPath(invalidIndexPath))
    }

    func testSafeScrollToIndexPath() {
        let validIndexPathTop = IndexPath(row: 0, section: 0)

        tableView.contentOffset = .init(x: 0, y: 100)
        XCTAssertNotEqual(tableView.contentOffset, .zero)

        tableView.safeScrollToRow(at: validIndexPathTop, at: .top, animated: false)
        XCTAssertEqual(tableView.contentOffset, .zero)

        let validIndexPathBottom = IndexPath(row: 7, section: 1)
        let bottomOffset = CGPoint(x: 0, y: tableView.contentSize.height - tableView.bounds.size.height)

        tableView.contentOffset = .init(x: 0, y: 200)
        XCTAssertNotEqual(tableView.contentOffset, bottomOffset)

        tableView.safeScrollToRow(at: validIndexPathBottom, at: .bottom, animated: false)
        #if os(tvOS)
        XCTAssertEqual(bottomOffset.y, tableView.contentOffset.y, accuracy: 15.0)
        #else
        XCTAssertEqual(bottomOffset.y, tableView.contentOffset.y, accuracy: 2.0)
        #endif

        let invalidIndexPath = IndexPath(row: 213, section: 21)
        tableView.contentOffset = .zero

        tableView.safeScrollToRow(at: invalidIndexPath, at: .bottom, animated: false)
        XCTAssertEqual(tableView.contentOffset, .zero)
    }

    #if os(iOS)
    func testRegisterReusableViewWithClassAndNib() {
        let nib = UINib(nibName: "UITableViewHeaderFooterView", bundle: Bundle(for: UITableViewExtensionsTests.self))
        tableView.register(nib: nib, withHeaderFooterViewClass: UITableViewHeaderFooterView.self)
        let view = tableView.dequeueReusableHeaderFooterView(withClass: UITableViewHeaderFooterView.self)
        XCTAssertNotNil(view)
    }
    #endif

    func testRegisterReusableViewWithClass() {
        tableView.register(headerFooterViewClassWith: UITableViewHeaderFooterView.self)
        let view = tableView.dequeueReusableHeaderFooterView(withClass: UITableViewHeaderFooterView.self)
        XCTAssertNotNil(view)
    }

    func testRegisterCellWithClass() {
        tableView.register(cellWithClass: UITableViewCell.self)
        let cell = tableView.dequeueReusableCell(withClass: UITableViewCell.self)
        XCTAssertNotNil(cell)
    }

    #if os(iOS)
    func testRegisterCellWithClassAndNib() {
        let nib = UINib(nibName: "UITableViewCell", bundle: Bundle(for: UITableViewExtensionsTests.self))
        tableView.register(nib: nib, withCellClass: UITableViewCell.self)
        let cell = tableView.dequeueReusableCell(withClass: UITableViewCell.self)
        XCTAssertNotNil(cell)
    }
    #endif

    #if os(iOS)
    func testRegisterCellWithNibUsingClass() {
        tableView.register(nibWithCellClass: UITableViewCell.self, at: UITableViewExtensionsTests.self)
        let cell = tableView.dequeueReusableCell(withClass: UITableViewCell.self)
        XCTAssertNotNil(cell)
    }
    #endif

}

extension UITableViewExtensionsTests: UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        return tableView == self.emptyTableView ? 0 : 2
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == self.emptyTableView {
            return 0
        } else {
            return section == 0 ? 5 : 8
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }

}

#endif
