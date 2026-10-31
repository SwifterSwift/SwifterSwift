// UIScrollView+ScrollToBottom.swift - Copyright 2026 SwifterSwift

#if canImport(UIKit) && !os(watchOS)
import CoreGraphics
import UIKit

public extension UIScrollView {
    /// SwifterSwift: Scrolls to the bottom of the content, keeping the horizontal offset.
    ///
    /// The bottom offset is `contentSize.height + adjustedContentInset.bottom - bounds.height`, so the end of the
    /// content stays above the home indicator, a toolbar and any other safe area or content inset, exactly where the
    /// scroll view rests when the user scrolls all the way down.
    ///
    /// When the content and its insets are shorter than the scroll view, there's nothing to scroll, so it scrolls to
    /// the top (`-adjustedContentInset.top`) instead of moving the content down.
    ///
    /// ```swift
    /// let scrollView = UIScrollView(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
    /// scrollView.contentSize = CGSize(width: 100, height: 500)
    /// scrollView.contentInset.bottom = 30
    /// scrollView.scrollToBottom(animated: false)
    /// scrollView.contentOffset  // (0.0, 430.0)
    /// ```
    ///
    /// - Parameter animated: `true` to animate the scroll at a constant velocity, `false` to jump there immediately.
    ///   The default is `true`.
    func scrollToBottom(animated: Bool = true) {
        let insets = adjustedContentInset
        let bottom = max(-insets.top, contentSize.height + insets.bottom - bounds.height)
        setContentOffset(CGPoint(x: contentOffset.x, y: bottom), animated: animated)
    }
}
#endif
