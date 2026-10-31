// UIRefreshControl+BeginRefreshingAnimatedTests.swift - Copyright 2026 SwifterSwift

#if canImport(UIKit) && !os(watchOS) && !os(tvOS)
import SwifterSwiftUIKit
import Testing
import UIKit

@MainActor
struct UIRefreshControlBeginRefreshingAnimatedTests {
    /// A scroll view under a navigation bar: its adjusted content inset adds `barInsets` to its content inset.
    final class BarInsetScrollView: UIScrollView {
        var barInsets = UIEdgeInsets.zero

        override var adjustedContentInset: UIEdgeInsets {
            UIEdgeInsets(
                top: contentInset.top + barInsets.top,
                left: contentInset.left + barInsets.left,
                bottom: contentInset.bottom + barInsets.bottom,
                right: contentInset.right + barInsets.right
            )
        }
    }

    // Tests run without a window, where UIKit ignores `beginRefreshing()` for an off-screen refresh control, so they
    // check the scroll and the actions rather than `isRefreshing`.

    @Test
    func scrollsTableViewToTop() {
        let tableView = UITableView(frame: CGRect(x: 0, y: 0, width: 320, height: 480))
        tableView.contentSize = CGSize(width: 320, height: 2_000)
        tableView.contentOffset = CGPoint(x: 0, y: 700)
        let refreshControl = UIRefreshControl()
        tableView.refreshControl = refreshControl
        refreshControl.beginRefreshing(animated: false)
        #expect(tableView.contentOffset.y == -tableView.adjustedContentInset.top)
    }

    @Test
    func respectsContentInsetAboveTheSpinner() {
        let scrollView = UIScrollView(frame: CGRect(x: 0, y: 0, width: 320, height: 480))
        scrollView.contentSize = CGSize(width: 320, height: 2_000)
        scrollView.contentInset.top = 50
        let refreshControl = UIRefreshControl()
        scrollView.refreshControl = refreshControl
        refreshControl.beginRefreshing(animated: false)
        #expect(scrollView.contentOffset.y == -scrollView.adjustedContentInset.top)
        #expect(scrollView.contentOffset.y <= -50)
    }

    @Test
    func showsSpinnerBelowBars() {
        let scrollView = BarInsetScrollView(frame: CGRect(x: 0, y: 0, width: 320, height: 480))
        scrollView.contentSize = CGSize(width: 320, height: 2_000)
        scrollView.contentInset.top = 20
        scrollView.barInsets.top = 103
        scrollView.contentOffset = CGPoint(x: 0, y: 500)
        let refreshControl = UIRefreshControl()
        scrollView.refreshControl = refreshControl
        refreshControl.beginRefreshing(animated: false)
        #expect(scrollView.contentOffset == CGPoint(x: 0, y: -123))
    }

    @Test
    func includesRoomMadeForSpinnerInAdjustedInset() {
        // While refreshing in a window, UIKit adds the spinner's height (60 points here) to the adjusted content inset.
        let scrollView = BarInsetScrollView(frame: CGRect(x: 0, y: 0, width: 320, height: 480))
        scrollView.contentSize = CGSize(width: 320, height: 2_000)
        scrollView.contentInset.top = 60
        scrollView.barInsets.top = 100
        let refreshControl = UIRefreshControl()
        scrollView.refreshControl = refreshControl
        refreshControl.beginRefreshing(animated: false)
        #expect(scrollView.contentOffset == CGPoint(x: 0, y: -160))
    }

    @Test
    func keepsHorizontalOffset() {
        let scrollView = UIScrollView(frame: CGRect(x: 0, y: 0, width: 320, height: 480))
        scrollView.contentSize = CGSize(width: 1_000, height: 2_000)
        scrollView.contentOffset = CGPoint(x: 200, y: 300)
        let refreshControl = UIRefreshControl()
        scrollView.refreshControl = refreshControl
        refreshControl.beginRefreshing(animated: false)
        #expect(scrollView.contentOffset.x == 200)
    }

    @Test(arguments: [true, false])
    func sendsValueChangedOnlyWhenAsked(_ sendAction: Bool) {
        let scrollView = UIScrollView(frame: CGRect(x: 0, y: 0, width: 320, height: 480))
        let refreshControl = UIRefreshControl()
        scrollView.refreshControl = refreshControl
        var actionCalls = 0
        refreshControl.addAction(UIAction { _ in actionCalls += 1 }, for: .valueChanged)
        refreshControl.beginRefreshing(animated: false, sendAction: sendAction)
        #expect(actionCalls == (sendAction ? 1 : 0))
    }

    @Test
    func sendsActionWithoutScrollView() {
        let refreshControl = UIRefreshControl()
        var actionCalls = 0
        refreshControl.addAction(UIAction { _ in actionCalls += 1 }, for: .valueChanged)
        refreshControl.beginRefreshing(animated: true, sendAction: true)
        #expect(actionCalls == 1)
    }
}
#endif
