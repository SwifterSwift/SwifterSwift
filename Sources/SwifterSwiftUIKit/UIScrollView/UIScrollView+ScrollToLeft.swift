// UIScrollView+ScrollToLeft.swift - Copyright 2026 SwifterSwift

#if canImport(UIKit) && !os(watchOS)
import CoreGraphics
import UIKit

public extension UIScrollView {
    /// SwifterSwift: Scrolls to the left edge of the content, keeping the vertical offset.
    ///
    /// The left offset is `-adjustedContentInset.left`, so safe area and content insets are respected, exactly where
    /// the scroll view rests when the user scrolls all the way to the left. The edge is always the physical left one,
    /// also in right-to-left layouts.
    ///
    /// ```swift
    /// scrollView.contentOffset  // (300.0, 0.0)
    /// scrollView.scrollToLeft(animated: false)
    /// scrollView.contentOffset  // (-adjustedContentInset.left, 0.0)
    /// ```
    ///
    /// - Parameter animated: `true` to animate the scroll at a constant velocity, `false` to jump there immediately.
    ///   The default is `true`.
    func scrollToLeft(animated: Bool = true) {
        setContentOffset(CGPoint(x: -adjustedContentInset.left, y: contentOffset.y), animated: animated)
    }
}
#endif
