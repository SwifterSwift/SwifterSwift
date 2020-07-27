//
//  UIScrollViewExtensions.swift
//  SwifterSwift
//
//  Created by camila oliveira on 22/04/18.
//  Copyright © 2018 SwifterSwift
//

#if canImport(UIKit) && !os(watchOS)
import UIKit

// MARK: - Methods
public extension UIScrollView {

    /// SwifterSwift: Takes a snapshot of an entire ScrollView
    ///
    ///    AnySubclassOfUIScroolView().snapshot
    ///    UITableView().snapshot
    ///
    /// - Returns: Snapshot as UIimage for rendered ScrollView
    var snapshot: UIImage? {
        // Original Source: https://gist.github.com/thestoics/1204051
        UIGraphicsBeginImageContextWithOptions(contentSize, false, 0)
        defer {
            UIGraphicsEndImageContext()
        }
        guard let context = UIGraphicsGetCurrentContext() else { return nil }
        let previousFrame = frame
        frame = CGRect(origin: frame.origin, size: contentSize)
        layer.render(in: context)
        frame = previousFrame
        return UIGraphicsGetImageFromCurrentImageContext()
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

extension UIScrollView {

    /// SwifterSwift: Scroll to the top-most content offset.
    /// - Parameter animated: `true` to animate the transition at a constant velocity to the new offset, `false` to make the transition immediate.
    func scrollToTop(animated: Bool = true) {
        setContentOffset(CGPoint(x: contentOffset.x, y: 0), animated: animated)
    }

    /// SwifterSwift: Scroll to the left-most content offset.
    /// - Parameter animated: `true` to animate the transition at a constant velocity to the new offset, `false` to make the transition immediate.
    func scrollToLeft(animated: Bool = true) {
        setContentOffset(CGPoint(x: 0, y: contentOffset.y), animated: animated)
    }

    /// SwifterSwift: Scroll to the bottom-most content offset.
    /// - Parameter animated: `true` to animate the transition at a constant velocity to the new offset, `false` to make the transition immediate.
    func scrollToBottom(animated: Bool = true) {
        setContentOffset(CGPoint(x: contentOffset.x, y: max(0, contentSize.height - bounds.height)), animated: animated)
    }

    /// SwifterSwift: Scroll to the right-most content offset.
    /// - Parameter animated: `true` to animate the transition at a constant velocity to the new offset, `false` to make the transition immediate.
    func scrollToRight(animated: Bool = true) {
        setContentOffset(CGPoint(x: max(0, contentSize.width - bounds.width), y: contentOffset.y), animated: animated)
    }

    /// SwifterSwift: Scroll up one length of the scroll view.
    /// If `isPagingEnabled` is `true`, the previous page location is used.
    /// - Parameter animated: `true` to animate the transition at a constant velocity to the new offset, `false` to make the transition immediate.
    func scrollUp(animated: Bool = true) {
        let y = max(0, contentOffset.y - bounds.height)
        if isPagingEnabled {
            let height = bounds.height
            let page = (y / height).rounded(.down)
            setContentOffset(CGPoint(x: contentOffset.x, y: page * height), animated: animated)
        } else {
            setContentOffset(CGPoint(x: contentOffset.x, y: y), animated: animated)
        }
    }

    /// SwifterSwift: Scroll left one width of the scroll view.
    /// If `isPagingEnabled` is `true`, the previous page location is used.
    /// - Parameter animated: `true` to animate the transition at a constant velocity to the new offset, `false` to make the transition immediate.
    func scrollLeft(animated: Bool = true) {
        let x = max(0, contentOffset.x - bounds.width)
        if isPagingEnabled {
            let width = bounds.width
            let page = (x / width).rounded(.down)
            setContentOffset(CGPoint(x: page * width, y: contentOffset.y), animated: animated)
        } else {
            setContentOffset(CGPoint(x: x, y: contentOffset.y), animated: animated)
        }
    }

    /// SwifterSwift: Scroll down one length of the scroll view.
    /// If `isPagingEnabled` is `true`, the next page location is used.
    /// - Parameter animated: `true` to animate the transition at a constant velocity to the new offset, `false` to make the transition immediate.
    func scrollDown(animated: Bool = true) {
        let y = min(max(0, contentSize.height - bounds.height), contentOffset.y + bounds.height)
        if isPagingEnabled {
            let height = bounds.height
            let page = (y / height).rounded(.up)
            setContentOffset(CGPoint(x: contentOffset.x, y: page * height), animated: animated)
        } else {
            setContentOffset(CGPoint(x: contentOffset.x, y: y), animated: animated)
        }
    }

    /// SwifterSwift: Scroll right one length of the scroll view.
    /// If `isPagingEnabled` is `true`, the next page location is used.
    /// - Parameter animated: `true` to animate the transition at a constant velocity to the new offset, `false` to make the transition immediate.
    func scrollRight(animated: Bool = true) {
        let x = min(max(0, contentSize.width - bounds.width), contentOffset.x + bounds.width)
        if isPagingEnabled {
            let width = bounds.width
            let page = (x / width).rounded(.up)
            setContentOffset(CGPoint(x: page * width, y: contentOffset.y), animated: animated)
        } else {
            setContentOffset(CGPoint(x: x, y: contentOffset.y), animated: animated)
        }
    }

}

#endif
