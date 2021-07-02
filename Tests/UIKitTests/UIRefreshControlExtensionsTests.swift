// UIRefreshControlExtensionsTests.swift - Copyright 2020 SwifterSwift

@testable import SwifterSwift
import XCTest

#if canImport(UIKit) && os(iOS)
import UIKit

final class UIRefreshControlExtensionTests: XCTestCase {
    func testBeginRefreshAsRefreshControlSubview() {
        let tableView = UITableView()
        XCTAssertEqual(tableView.contentOffset, .zero)
        let refreshControl = UIRefreshControl()
        tableView.addSubview(refreshControl)
        refreshControl.beginRefreshing(in: tableView, animated: true)

        XCTAssert(refreshControl.isRefreshing)
        XCTAssertEqual(tableView.contentOffset.y, -refreshControl.frame.height)

        let anotherTableview = UITableView()
        XCTAssertEqual(anotherTableview.contentOffset, .zero)
        anotherTableview.refreshControl = UIRefreshControl()
        anotherTableview.refreshControl?.beginRefreshing(in: anotherTableview, animated: true, sendAction: true)

        XCTAssert(anotherTableview.refreshControl!.isRefreshing)
        XCTAssertEqual(anotherTableview.contentOffset.y, -anotherTableview.refreshControl!.frame.height)
    }

    func testBeginRefreshAsScrollViewSubview() {
        let scrollView = UIScrollView()
        XCTAssertEqual(scrollView.contentOffset, .zero)
        let refreshControl = UIRefreshControl()
        scrollView.addSubview(refreshControl)
        refreshControl.beginRefreshing(animated: true)

        XCTAssert(refreshControl.isRefreshing)
        XCTAssertEqual(scrollView.contentOffset.y, -refreshControl.frame.height)

        let anotherScrollView = UIScrollView()
        XCTAssertEqual(anotherScrollView.contentOffset, .zero)
        anotherScrollView.refreshControl = UIRefreshControl()
        anotherScrollView.refreshControl?.beginRefreshing(animated: true, sendAction: true)

        XCTAssert(anotherScrollView.refreshControl!.isRefreshing)
        XCTAssertEqual(anotherScrollView.contentOffset.y, -anotherScrollView.refreshControl!.frame.height)
    }
}

#endif
