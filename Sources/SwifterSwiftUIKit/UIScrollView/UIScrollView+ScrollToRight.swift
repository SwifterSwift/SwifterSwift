// UIScrollView+ScrollToRight.swift - Copyright 2026 SwifterSwift

#if canImport(UIKit) && !os(watchOS)
import CoreGraphics
import UIKit

public extension UIScrollView {
    /// SwifterSwift: Scrolls to the right edge of the content, keeping the vertical offset.
    ///
    /// The right offset is `contentSize.width + adjustedContentInset.right - bounds.width`, so safe area and content
    /// insets are respected, exactly where the scroll view rests when the user scrolls all the way to the right. The
    /// edge is always the physical right one, also in right-to-left layouts.
    ///
    /// When the content and its insets are narrower than the scroll view, there's nothing to scroll, so it scrolls to
    /// the left edge (`-adjustedContentInset.left`) instead of moving the content right.
    ///
    /// ```swift
    /// let scrollView = UIScrollView(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
    /// scrollView.contentSize = CGSize(width: 500, height: 100)
    /// scrollView.contentInset.right = 40
    /// scrollView.scrollToRight(animated: false)
    /// scrollView.contentOffset  // (440.0, 0.0)
    /// ```
    ///
    /// - Parameter animated: `true` to animate the scroll at a constant velocity, `false` to jump there immediately.
    ///   The default is `true`.
    func scrollToRight(animated: Bool = true) {
        let insets = adjustedContentInset
        let right = max(-insets.left, contentSize.width + insets.right - bounds.width)
        setContentOffset(CGPoint(x: right, y: contentOffset.y), animated: animated)
    }
}
#endif
