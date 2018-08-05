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

        if #available(iOS 10.0, *) {
            let anotherTableview = UITableView()
            XCTAssertEqual(anotherTableview.contentOffset, .zero)
            anotherTableview.refreshControl = UIRefreshControl()
            anotherTableview.refreshControl?.beginRefreshing(in: anotherTableview, animated: true, sendAction: true)

            XCTAssertTrue(anotherTableview.refreshControl!.isRefreshing)
            XCTAssertEqual(anotherTableview.contentOffset.y, -anotherTableview.refreshControl!.frame.height)
        }
    }

}

#endif
