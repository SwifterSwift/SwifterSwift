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
        
        func testReloadData() {
            var completionCalled = false
            tableView.reloadData {
                completionCalled = true
                XCTAssert(completionCalled)
            }
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

        func testDequeReusableCellWithClass() {
            tableView.register(UITableViewCell.self, forCellReuseIdentifier: "UITableViewCell")
            let cell = tableView.dequeReusableCell(withClass: UITableViewCell.self)
            XCTAssertNotNil(cell)
        }
        
        func testDequeReusableCellWithClassForIndexPath() {
            tableView.register(UITableViewCell.self, forCellReuseIdentifier: "UITableViewCell")
            let indexPath = tableView.indexPathForLastRow!
            let cell = tableView.dequeReusableCell(withClass: UITableViewCell.self, for: indexPath)
            XCTAssertNotNil(cell)
        }
        
        func testDequeReusableHeaderFooterView() {
            tableView.register(UITableViewHeaderFooterView.self, forHeaderFooterViewReuseIdentifier: "UITableViewHeaderFooterView")
            let headerFooterView = tableView.dequeReusableHeaderFooterView(withClass: UITableViewHeaderFooterView.self)
            XCTAssertNotNil(headerFooterView)
        }
        
        func testRegisterReusableViewWithClassAndNib() {
            let nilView = tableView.dequeReusableHeaderFooterView(withClass: UITableViewHeaderFooterView.self)
            XCTAssertNil(nilView)
            let nib = UINib(nibName: "UITableViewHeaderFooterView", bundle: Bundle(for: UITableViewExtensionsTests.self))
            tableView.register(nib: nib, withHeaderFooterViewClass: UITableViewHeaderFooterView.self)
            let view = tableView.dequeReusableHeaderFooterView(withClass: UITableViewHeaderFooterView.self)
            XCTAssertNotNil(view)
        }
        
        func testRegisterReusableViewWithClass() {
            let nilView = tableView.dequeReusableHeaderFooterView(withClass: UITableViewHeaderFooterView.self)
            XCTAssertNil(nilView)
            tableView.register(headerFooterViewClassWith: UITableViewHeaderFooterView.self)
            let view = tableView.dequeReusableHeaderFooterView(withClass: UITableViewHeaderFooterView.self)
            XCTAssertNotNil(view)
        }
        
        func testRegisterCellWithClass() {
            let nilCell = tableView.dequeReusableCell(withClass: UITableViewCell.self)
            XCTAssertNil(nilCell)
            tableView.register(cellWithClass: UITableViewCell.self)
            let cell = tableView.dequeReusableCell(withClass: UITableViewCell.self)
            XCTAssertNotNil(cell)
        }
        
        func testRegisterCellWithClassAndNib() {
            let nilCell = tableView.dequeReusableCell(withClass: UITableViewCell.self)
            XCTAssertNil(nilCell)
            let nib = UINib(nibName: "UITableViewCell", bundle: Bundle(for: UITableViewExtensionsTests.self))
            tableView.register(nib: nib, withCellClass: UITableViewCell.self)
            let cell = tableView.dequeReusableCell(withClass: UITableViewCell.self)
            XCTAssertNotNil(cell)
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
