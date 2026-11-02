// UIScrollView+ScrollDown.swift - Copyright 2026 SwifterSwift

#if canImport(UIKit) && !os(watchOS)
import CoreGraphics
import UIKit

public extension UIScrollView {
    /// SwifterSwift: Scrolls down by one page, the height of the scroll view, without going past the bottom.
    ///
    /// The scroll stops at the bottom of the content, `contentSize.height + adjustedContentInset.bottom -
    /// bounds.height`, so safe area and content insets are respected. When the content and its insets are shorter than
    /// the scroll view, it stays at the top. The horizontal offset doesn't change.
    ///
    /// When `isPagingEnabled` is `true`, it scrolls to the start of the next page instead, so the offset stays on a
    /// page boundary. Pages start at the top of the content (`-adjustedContentInset.top`) and repeat every
    /// `bounds.height` points; when the content's height isn't a whole number of pages, the last page ends at the
    /// bottom of the content, so you can always reach it. An offset within a point of a boundary counts as on it,
    /// because UIKit rounds offsets to the pixel grid.
    ///
    /// ```swift
    /// let scrollView = UIScrollView(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
    /// scrollView.contentSize = CGSize(width: 100, height: 500)
    /// scrollView.contentOffset = CGPoint(x: 0, y: 250)
    /// scrollView.scrollDown(animated: false)
    /// scrollView.contentOffset  // (0.0, 350.0)
    /// scrollView.scrollDown(animated: false)
    /// scrollView.contentOffset  // (0.0, 400.0)
    /// ```
    ///
    /// - Parameter animated: `true` to animate the scroll at a constant velocity, `false` to jump there immediately.
    ///   The default is `true`.
    func scrollDown(animated: Bool = true) {
        let insets = adjustedContentInset
        let top = -insets.top
        let pageHeight = bounds.height
        let bottom = max(top, contentSize.height + insets.bottom - pageHeight)
        var y = min(bottom, contentOffset.y + pageHeight)
        #if !os(tvOS)
        if isPagingEnabled, pageHeight > 0 {
            // An offset within a point of a page boundary, such as one rounded to the pixel grid, is on the boundary.
            var page = (contentOffset.y - top) / pageHeight
            if abs(page.rounded() - page) * pageHeight < 1 {
                page = page.rounded()
            }
            y = min(bottom, top + (page.rounded(.down) + 1) * pageHeight)
        }
        #endif
        setContentOffset(CGPoint(x: contentOffset.x, y: y), animated: animated)
    }
}
#endif
