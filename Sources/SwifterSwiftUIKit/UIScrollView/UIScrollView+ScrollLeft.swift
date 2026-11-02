// UIScrollView+ScrollLeft.swift - Copyright 2026 SwifterSwift

#if canImport(UIKit) && !os(watchOS)
import CoreGraphics
import UIKit

public extension UIScrollView {
    /// SwifterSwift: Scrolls left by one page, the width of the scroll view, without going past the left edge.
    ///
    /// The scroll stops at the left edge of the content, `-adjustedContentInset.left`, so safe area and content insets
    /// are respected. The vertical offset doesn't change, and left is always the physical left, also in right-to-left
    /// layouts.
    ///
    /// When `isPagingEnabled` is `true`, it scrolls to the start of the previous page instead, so the offset stays on a
    /// page boundary. Pages start at the left edge of the content and repeat every `bounds.width` points; an offset
    /// between two boundaries, such as the end of content whose width isn't a whole number of pages, goes to the
    /// boundary left of it. An offset within a point of a boundary counts as on it, because UIKit rounds offsets to the
    /// pixel grid.
    ///
    /// A scroll view with a width of `0` has no pages, so it only moves back to the left edge if it's past it.
    ///
    /// ```swift
    /// let scrollView = UIScrollView(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
    /// scrollView.contentSize = CGSize(width: 500, height: 100)
    /// scrollView.contentOffset = CGPoint(x: 250, y: 0)
    /// scrollView.scrollLeft(animated: false)
    /// scrollView.contentOffset  // (150.0, 0.0)
    /// scrollView.scrollLeft(animated: false)
    /// scrollView.scrollLeft(animated: false)
    /// scrollView.contentOffset  // (0.0, 0.0)
    /// ```
    ///
    /// - Parameter animated: `true` to animate the scroll at a constant velocity, `false` to jump there immediately.
    ///   The default is `true`.
    func scrollLeft(animated: Bool = true) {
        let left = -adjustedContentInset.left
        let pageWidth = bounds.width
        var x = max(left, contentOffset.x - pageWidth)
        #if !os(tvOS)
        if isPagingEnabled, pageWidth > 0 {
            // An offset within a point of a page boundary, such as one rounded to the pixel grid, is on the boundary.
            var page = (contentOffset.x - left) / pageWidth
            if abs(page.rounded() - page) * pageWidth < 1 {
                page = page.rounded()
            }
            x = max(left, left + (page.rounded(.up) - 1) * pageWidth)
        }
        #endif
        setContentOffset(CGPoint(x: x, y: contentOffset.y), animated: animated)
    }
}
#endif
