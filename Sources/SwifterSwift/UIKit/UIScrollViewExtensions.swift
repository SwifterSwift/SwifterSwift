// UIScrollViewExtensions.swift - Copyright 2023 SwifterSwift

#if canImport(UIKit) && !os(watchOS)
import UIKit

// MARK: - Methods

public extension UIScrollView {
    /// SwifterSwift: Takes a snapshot of an entire ScrollView.
    ///
    ///    AnySubclassOfUIScrollView().snapshot
    ///    UITableView().snapshot
    ///
    /// - Returns: Snapshot as UIImage for rendered ScrollView.
    var snapshot: UIImage? {
        let size = contentSize
        guard size != .zero else { return nil }

        // Original Source: https://gist.github.com/thestoics/1204051
        return UIGraphicsImageRenderer(size: size).image { context in
            let previousFrame = frame
            frame = CGRect(origin: frame.origin, size: size)
            layer.render(in: context.cgContext)
            frame = previousFrame
        }
    }

    /// SwifterSwift: The currently visible region of the scroll view.
    var visibleRect: CGRect {
        let contentWidth = contentSize.width - contentOffset.x
        let contentHeight = contentSize.height - contentOffset.y
        return CGRect(origin: contentOffset,
                      size: CGSize(width: min(min(bounds.size.width, contentSize.width), contentWidth),
                                   height: min(min(bounds.size.height, contentSize.height), contentHeight)))
    }
}

public extension UIScrollView {
    /// SwifterSwift: Scroll to the top-most content offset.
    /// - Parameter animated: `true` to animate the transition at a constant velocity to the new offset, `false` to make
    /// the transition immediate.
    func scrollToTop(animated: Bool = true) {
        setContentOffset(CGPoint(x: contentOffset.x, y: -contentInset.top), animated: animated)
    }

    /// SwifterSwift: Scroll to the left-most content offset.
    /// - Parameter animated: `true` to animate the transition at a constant velocity to the new offset, `false` to make
    /// the transition immediate.
    func scrollToLeft(animated: Bool = true) {
        setContentOffset(CGPoint(x: -contentInset.left, y: contentOffset.y), animated: animated)
    }

    /// SwifterSwift: Scroll to the bottom-most content offset.
    /// - Parameter animated: `true` to animate the transition at a constant velocity to the new offset, `false` to make
    /// the transition immediate.
    func scrollToBottom(animated: Bool = true) {
        setContentOffset(
            CGPoint(x: contentOffset.x, y: max(0, contentSize.height - bounds.height) + contentInset.bottom),
            animated: animated)
    }

    /// SwifterSwift: Scroll to the right-most content offset.
    /// - Parameter animated: `true` to animate the transition at a constant velocity to the new offset, `false` to make
    /// the transition immediate.
    func scrollToRight(animated: Bool = true) {
        setContentOffset(
            CGPoint(x: max(0, contentSize.width - bounds.width) + contentInset.right, y: contentOffset.y),
            animated: animated)
    }

    /// SwifterSwift: Scroll up one page of the scroll view.
    /// If `isPagingEnabled` is `true`, the previous page location is used.
    /// - Parameter animated: `true` to animate the transition at a constant velocity to the new offset, `false` to make
    /// the transition immediate.
    func scrollUp(animated: Bool = true) {
        let minY = -contentInset.top
        var y = max(minY, contentOffset.y - bounds.height)
        #if !os(tvOS)
        if isPagingEnabled,
           bounds.height != 0 {
            let page = max(0, ((y + contentInset.top) / bounds.height).rounded(.down))
            y = max(minY, page * bounds.height - contentInset.top)
        }
        #endif
        setContentOffset(CGPoint(x: contentOffset.x, y: y), animated: animated)
    }

    /// SwifterSwift: Scroll left one page of the scroll view.
    /// If `isPagingEnabled` is `true`, the previous page location is used.
    /// - Parameter animated: `true` to animate the transition at a constant velocity to the new offset, `false` to make
    /// the transition immediate.
    func scrollLeft(animated: Bool = true) {
        let minX = -contentInset.left
        var x = max(minX, contentOffset.x - bounds.width)
        #if !os(tvOS)
        if isPagingEnabled,
           bounds.width != 0 {
            let page = ((x + contentInset.left) / bounds.width).rounded(.down)
            x = max(minX, page * bounds.width - contentInset.left)
        }
        #endif
        setContentOffset(CGPoint(x: x, y: contentOffset.y), animated: animated)
    }

    /// SwifterSwift: Scroll down one page of the scroll view.
    /// If `isPagingEnabled` is `true`, the next page location is used.
    /// - Parameter animated: `true` to animate the transition at a constant velocity to the new offset, `false` to make
    /// the transition immediate.
    func scrollDown(animated: Bool = true) {
        let maxY = max(0, contentSize.height - bounds.height) + contentInset.bottom
        var y = min(maxY, contentOffset.y + bounds.height)
        #if !os(tvOS)
        if isPagingEnabled,
           bounds.height != 0 {
            let page = ((y + contentInset.top) / bounds.height).rounded(.down)
            y = min(maxY, page * bounds.height - contentInset.top)
        }
        #endif
        setContentOffset(CGPoint(x: contentOffset.x, y: y), animated: animated)
    }

    /// SwifterSwift: Scroll right one page of the scroll view.
    /// If `isPagingEnabled` is `true`, the next page location is used.
    /// - Parameter animated: `true` to animate the transition at a constant velocity to the new offset, `false` to make
    /// the transition immediate.
    func scrollRight(animated: Bool = true) {
        let maxX = max(0, contentSize.width - bounds.width) + contentInset.right
        var x = min(maxX, contentOffset.x + bounds.width)
        #if !os(tvOS)
        if isPagingEnabled,
           bounds.width != 0 {
            let page = ((x + contentInset.left) / bounds.width).rounded(.down)
            x = min(maxX, page * bounds.width - contentInset.left)
        }
        #endif
        setContentOffset(CGPoint(x: x, y: contentOffset.y), animated: animated)
    }
}

#endif
