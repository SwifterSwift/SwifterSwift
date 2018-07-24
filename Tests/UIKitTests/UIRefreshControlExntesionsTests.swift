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

    func testBeginRefreshProgramatically() {
        let tableFrame = CGRect(x: 0, y: 0, width: 400, height: 400)
        let tableView = UITableView.init(frame: tableFrame)
        XCTAssertEqual(tableView.contentOffset, .zero)
        let refreshControl = UIRefreshControl.init()
        tableView.addSubview(refreshControl)
        refreshControl.beginRefreshProgramatically(in: tableView)
        XCTAssertTrue(refreshControl.isRefreshing)
        XCTAssertEqual(tableView.contentOffset.y, -refreshControl.frame.height)
    }

}

#endif
