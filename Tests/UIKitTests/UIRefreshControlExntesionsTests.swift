//
//  UIRefreshControlExntesionsTests.swift
//  SwifterSwift
//
//  Created by ratul sharker on 7/24/18.
//  Copyright © 2018 SwifterSwift
//

#if os(iOS)

import XCTest
@testable import SwifterSwift

final class UIRefreshControlExtensionTests: XCTestCase {

    func testBeginRefreshAsRefreshControlSubview() {
        let tableView = UITableView()
        XCTAssertEqual(tableView.contentOffset, .zero)
        let refreshControl = UIRefreshControl()
        tableView.addSubview(refreshControl)
        refreshControl.beginRefreshing(in: tableView, animated: true)

        XCTAssertTrue(refreshControl.isRefreshing)
        XCTAssertEqual(tableView.contentOffset.y, -refreshControl.frame.height)
    }

    func testBeginRefreshAsRefreshControlProperty() {
        if #available(iOS 10.0, *) {
            let tableview = UITableView()
            XCTAssertEqual(tableview.contentOffset, .zero)
            tableview.refreshControl = UIRefreshControl()
            tableview.refreshControl?.beginRefreshing(in: tableview, animated: true, sendAction: true)

            XCTAssertTrue(tableview.refreshControl!.isRefreshing)
            XCTAssertEqual(tableview.contentOffset.y, -tableview.refreshControl!.frame.height)
        }
    }

}

#endif
