// UIScrollView+ScrollToTop.swift - Copyright 2026 SwifterSwift

#if canImport(UIKit) && !os(watchOS)
import CoreGraphics
import UIKit

public extension UIScrollView {
    /// SwifterSwift: Scrolls to the top of the content, keeping the horizontal offset.
    ///
    /// The top offset is `-adjustedContentInset.top`, so the content stays below the navigation bar, the status bar
    /// and any other safe area or content inset, exactly where the scroll view rests when the user scrolls all the way
    /// up. Using `contentInset.top` instead would hide the top of the content under the bars.
    ///
    /// ```swift
    /// tableView.contentOffset  // (0.0, 840.0)
    /// tableView.scrollToTop(animated: false)
    /// tableView.contentOffset  // (0.0, -adjustedContentInset.top)
    /// ```
    ///
    /// - Parameter animated: `true` to animate the scroll at a constant velocity, `false` to jump there immediately.
    ///   The default is `true`.
    func scrollToTop(animated: Bool = true) {
        setContentOffset(CGPoint(x: contentOffset.x, y: -adjustedContentInset.top), animated: animated)
    }
}
#endif
