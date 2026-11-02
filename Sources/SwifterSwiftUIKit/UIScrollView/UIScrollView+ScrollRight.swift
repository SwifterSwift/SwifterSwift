// UIScrollView+ScrollRight.swift - Copyright 2026 SwifterSwift

#if canImport(UIKit) && !os(watchOS)
import CoreGraphics
import UIKit

public extension UIScrollView {
    /// SwifterSwift: Scrolls right by one page, the width of the scroll view, without going past the right edge.
    ///
    /// The scroll stops at the right edge of the content, `contentSize.width + adjustedContentInset.right -
    /// bounds.width`, so safe area and content insets are respected. When the content and its insets are narrower than
    /// the scroll view, it stays at the left edge. The vertical offset doesn't change, and right is always the physical
    /// right, also in right-to-left layouts.
    ///
    /// When `isPagingEnabled` is `true`, it scrolls to the start of the next page instead, so the offset stays on a
    /// page boundary. Pages start at the left edge of the content (`-adjustedContentInset.left`) and repeat every
    /// `bounds.width` points; when the content's width isn't a whole number of pages, the last page ends at the right
    /// edge of the content, so you can always reach it. An offset within a point of a boundary counts as on it, because
    /// UIKit rounds offsets to the pixel grid.
    ///
    /// ```swift
    /// let scrollView = UIScrollView(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
    /// scrollView.contentSize = CGSize(width: 500, height: 100)
    /// scrollView.contentOffset = CGPoint(x: 250, y: 0)
    /// scrollView.scrollRight(animated: false)
    /// scrollView.contentOffset  // (350.0, 0.0)
    /// scrollView.scrollRight(animated: false)
    /// scrollView.contentOffset  // (400.0, 0.0)
    /// ```
    ///
    /// - Parameter animated: `true` to animate the scroll at a constant velocity, `false` to jump there immediately.
    ///   The default is `true`.
    func scrollRight(animated: Bool = true) {
        let insets = adjustedContentInset
        let left = -insets.left
        let pageWidth = bounds.width
        let right = max(left, contentSize.width + insets.right - pageWidth)
        var x = min(right, contentOffset.x + pageWidth)
        #if !os(tvOS)
        if isPagingEnabled, pageWidth > 0 {
            // An offset within a point of a page boundary, such as one rounded to the pixel grid, is on the boundary.
            var page = (contentOffset.x - left) / pageWidth
            if abs(page.rounded() - page) * pageWidth < 1 {
                page = page.rounded()
            }
            x = min(right, left + (page.rounded(.down) + 1) * pageWidth)
        }
        #endif
        setContentOffset(CGPoint(x: x, y: contentOffset.y), animated: animated)
    }
}
#endif
