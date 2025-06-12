// UIRefreshControlExtensionsTests.swift - Copyright 2025 SwifterSwift

@testable import SwifterSwift
import XCTest

#if canImport(UIKit) && os(iOS) && !targetEnvironment(macCatalyst)
import UIKit

@MainActor
final class UIRefreshControlExtensionTests: XCTestCase {
    func testBeginRefreshAsRefreshControlSubview() {
        let window = UIWindow()
        let viewController = UIViewController()
        window.rootViewController = viewController
        window.makeKeyAndVisible()

        let tableView = UITableView()
        viewController.view.addSubview(tableView)
        let refreshControl = UIRefreshControl()
        tableView.addSubview(refreshControl)
        refreshControl.beginRefreshing(in: tableView, animated: false)

        XCTAssert(refreshControl.isRefreshing)
        XCTAssertEqual(tableView.contentOffset.y, -refreshControl.frame.height)

        let anotherTableview = UITableView()
        viewController.view.addSubview(anotherTableview)
        anotherTableview.refreshControl = UIRefreshControl()
        anotherTableview.refreshControl!.beginRefreshing(in: anotherTableview, animated: false, sendAction: true)

        XCTAssert(anotherTableview.refreshControl!.isRefreshing)
        XCTAssertEqual(anotherTableview.contentOffset.y, -anotherTableview.refreshControl!.frame.height)
    }

    func testBeginRefreshAsScrollViewSubview() {
        let window = UIWindow()
        let viewController = UIViewController()
        window.rootViewController = viewController
        window.makeKeyAndVisible()

        let scrollView = UIScrollView()
        viewController.view.addSubview(scrollView)
        XCTAssertEqual(scrollView.contentOffset, .zero)
        let refreshControl = UIRefreshControl()
        scrollView.addSubview(refreshControl)
        refreshControl.beginRefreshing(animated: false)

        XCTAssert(refreshControl.isRefreshing)
        XCTAssertEqual(scrollView.contentOffset.y, -refreshControl.frame.height)

        let anotherScrollView = UIScrollView()
        viewController.view.addSubview(anotherScrollView)
        XCTAssertEqual(anotherScrollView.contentOffset, .zero)
        anotherScrollView.refreshControl = UIRefreshControl()
        anotherScrollView.refreshControl!.beginRefreshing(animated: false, sendAction: true)

        XCTAssert(anotherScrollView.refreshControl!.isRefreshing)
        XCTAssertEqual(anotherScrollView.contentOffset.y, -anotherScrollView.refreshControl!.frame.height)
    }
}

#endif
