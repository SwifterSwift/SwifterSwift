// UIRefreshControlExtensionsTests.swift - Copyright 2024 SwifterSwift

@testable import SwifterSwift
import XCTest

#if canImport(UIKit) && os(iOS)
import UIKit

final class UIRefreshControlExtensionTests: XCTestCase {
    func testBeginRefreshAsRefreshControlSubview() {
        let window = UIWindow()
        let tableView = UITableView()
        window.addSubview(tableView)
        let refreshControl = UIRefreshControl()
        tableView.addSubview(refreshControl)
        refreshControl.beginRefreshing(in: tableView, animated: false)

        XCTAssert(refreshControl.isRefreshing)
        XCTAssertEqual(tableView.contentOffset.y, -refreshControl.frame.height)

        let anotherTableview = UITableView()
        window.addSubview(anotherTableview)
        anotherTableview.refreshControl = UIRefreshControl()
        anotherTableview.refreshControl!.beginRefreshing(in: anotherTableview, animated: false, sendAction: true)

        XCTAssert(anotherTableview.refreshControl!.isRefreshing)
        XCTAssertEqual(anotherTableview.contentOffset.y, -anotherTableview.refreshControl!.frame.height)
    }

    func testBeginRefreshAsScrollViewSubview() {
        let window = UIWindow()
        let scrollView = UIScrollView()
        window.addSubview(scrollView)
        XCTAssertEqual(scrollView.contentOffset, .zero)
        let refreshControl = UIRefreshControl()
        scrollView.addSubview(refreshControl)
        refreshControl.beginRefreshing(animated: false)

        XCTAssert(refreshControl.isRefreshing)
        XCTAssertEqual(scrollView.contentOffset.y, -refreshControl.frame.height)

        let anotherScrollView = UIScrollView()
        window.addSubview(anotherScrollView)
        XCTAssertEqual(anotherScrollView.contentOffset, .zero)
        anotherScrollView.refreshControl = UIRefreshControl()
        anotherScrollView.refreshControl!.beginRefreshing(animated: false, sendAction: true)

        XCTAssert(anotherScrollView.refreshControl!.isRefreshing)
        XCTAssertEqual(anotherScrollView.contentOffset.y, -anotherScrollView.refreshControl!.frame.height)
    }
}

#endif
