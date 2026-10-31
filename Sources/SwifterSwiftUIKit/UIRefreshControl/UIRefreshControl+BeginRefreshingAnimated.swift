// UIRefreshControl+BeginRefreshingAnimated.swift - Copyright 2026 SwifterSwift

#if canImport(UIKit) && !os(watchOS) && !os(tvOS)
import CoreGraphics
import UIKit

public extension UIRefreshControl {
    /// SwifterSwift: Starts refreshing and scrolls the refresh control's scroll view so the spinner is visible.
    ///
    /// UIKit's `beginRefreshing()` only starts the spinner: unless the user pulled to refresh, the spinner stays hidden
    /// above the content. This method also scrolls the scroll view that hosts the refresh control, such as the table
    /// view whose `refreshControl` it is, to the top of its adjusted content inset, which accounts for the navigation
    /// bar and other bars, the content inset, and the room UIKit makes for the spinner while it refreshes. The spinner
    /// then shows below the bars, where pulling to refresh would show it. The horizontal offset doesn't change.
    ///
    /// When the refresh control isn't in a scroll view yet, it only starts refreshing.
    ///
    /// UIKit ignores `beginRefreshing()` for a refresh control that isn't on screen, for example before its view
    /// controller's view appears, and `isRefreshing` stays `false`; the scroll and the action still happen. Call this
    /// method from `viewDidAppear(_:)` or later to show the spinner.
    ///
    /// Like `beginRefreshing()`, this doesn't send `.valueChanged` actions by default, so your refresh handler doesn't
    /// run. Pass `true` for `sendAction` to run it, for example to load data the first time a screen appears.
    ///
    /// ```swift
    /// tableView.refreshControl = refreshControl
    /// refreshControl.beginRefreshing(animated: true, sendAction: true)
    /// refreshControl.isRefreshing  // true
    /// ```
    ///
    /// - Parameters:
    ///   - animated: Whether to animate the scroll.
    ///   - sendAction: Whether to send the control's `.valueChanged` actions. The default is `false`.
    func beginRefreshing(animated: Bool, sendAction: Bool = false) {
        beginRefreshing()
        if let scrollView = superview as? UIScrollView {
            let top = CGPoint(x: scrollView.contentOffset.x, y: -scrollView.adjustedContentInset.top)
            scrollView.setContentOffset(top, animated: animated)
        }
        if sendAction {
            sendActions(for: .valueChanged)
        }
    }
}
#endif
