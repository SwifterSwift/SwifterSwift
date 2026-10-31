// UIScrollView+ScrollUp.swift - Copyright 2026 SwifterSwift

#if canImport(UIKit) && !os(watchOS)
import CoreGraphics
import UIKit

public extension UIScrollView {
    /// SwifterSwift: Scrolls up by one page, the height of the scroll view, without going past the top.
    ///
    /// The scroll stops at the top of the content, `-adjustedContentInset.top`, so safe area and content insets are
    /// respected. The horizontal offset doesn't change.
    ///
    /// When `isPagingEnabled` is `true`, it scrolls to the start of the previous page instead, so the offset stays on a
    /// page boundary. Pages start at the top of the content and repeat every `bounds.height` points; an offset between
    /// two boundaries, such as the end of content whose height isn't a whole number of pages, goes to the boundary
    /// above it. An offset within a point of a boundary counts as on it, because UIKit rounds offsets to the pixel
    /// grid.
    ///
    /// A scroll view with a height of `0` has no pages, so it only moves back to the top if it's above it.
    ///
    /// ```swift
    /// let scrollView = UIScrollView(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
    /// scrollView.contentSize = CGSize(width: 100, height: 500)
    /// scrollView.contentOffset = CGPoint(x: 0, y: 250)
    /// scrollView.scrollUp(animated: false)
    /// scrollView.contentOffset  // (0.0, 150.0)
    /// scrollView.scrollUp(animated: false)
    /// scrollView.scrollUp(animated: false)
    /// scrollView.contentOffset  // (0.0, 0.0)
    /// ```
    ///
    /// - Parameter animated: `true` to animate the scroll at a constant velocity, `false` to jump there immediately.
    ///   The default is `true`.
    func scrollUp(animated: Bool = true) {
        let top = -adjustedContentInset.top
        let pageHeight = bounds.height
        var y = max(top, contentOffset.y - pageHeight)
        #if !os(tvOS)
        if isPagingEnabled, pageHeight > 0 {
            // An offset within a point of a page boundary, such as one rounded to the pixel grid, is on the boundary.
            var page = (contentOffset.y - top) / pageHeight
            if abs(page.rounded() - page) * pageHeight < 1 {
                page = page.rounded()
            }
            y = max(top, top + (page.rounded(.up) - 1) * pageHeight)
        }
        #endif
        setContentOffset(CGPoint(x: contentOffset.x, y: y), animated: animated)
    }
}
#endif
