// UIRefreshControlExtensionsTests.swift - Copyright 2026 SwifterSwift

@testable import SwifterSwift
import XCTest

#if canImport(UIKit) && os(iOS) && !targetEnvironment(macCatalyst)
import UIKit

@MainActor
final class UIRefreshControlExtensionTests: XCTestCase {
    func testBeginRefreshAsRefreshControlSubview() throws {
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
        anotherTableview.refreshControl?.beginRefreshing(in: anotherTableview, animated: false, sendAction: true)

        let anotherRefreshControl = try XCTUnwrap(anotherTableview.refreshControl)
        XCTAssert(anotherRefreshControl.isRefreshing)
        XCTAssertEqual(anotherTableview.contentOffset.y, -anotherRefreshControl.frame.height)
    }

    func testBeginRefreshAsScrollViewSubview() throws {
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
        anotherScrollView.refreshControl?.beginRefreshing(animated: false, sendAction: true)

        let anotherRefreshControl = try XCTUnwrap(anotherScrollView.refreshControl)
        XCTAssert(anotherRefreshControl.isRefreshing)
        XCTAssertEqual(anotherScrollView.contentOffset.y, -refreshControl.frame.height)
    }
}

#endif
