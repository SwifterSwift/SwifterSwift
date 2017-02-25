//
//  UITableViewExtensionsTests.swift
//  SwifterSwift
//
//  Created by Omar Albeik on 2/24/17.
//  Copyright © 2017 omaralbeik. All rights reserved.
//

#if os(iOS) || os(tvOS)
	
	import XCTest
	@testable import SwifterSwift
	
	class UITableViewExtensionsTests: XCTestCase {
		
		let tableView = UITableView()
		let emptyTableView = UITableView()
		
		override func setUp() {
			super.setUp()
			// Put setup code here. This method is called before the invocation of each test method in the class.
			tableView.dataSource = self
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
			XCTAssertEqual(tableView.numberOfRows, 13)
			XCTAssertEqual(emptyTableView.numberOfRows, 0)
		}
		
		func testIndexPathForLastRowInSection() {
			XCTAssertNil(tableView.indexPathForLastRow(inSection: -1))
			XCTAssertEqual(tableView.indexPathForLastRow(inSection: 0), IndexPath(row: 4, section: 0))
			XCTAssertEqual(emptyTableView.indexPathForLastRow(inSection: 0), IndexPath(row: 0, section: 0))
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
		
	}
	
	extension UITableViewExtensionsTests: UITableViewDataSource {
		
		func numberOfSections(in tableView: UITableView) -> Int {
			return 2
		}
		
		func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
			return section == 0 ? 5 : 8
		}
		
		func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
			return UITableViewCell()
		}
		
	}
	
#endif
