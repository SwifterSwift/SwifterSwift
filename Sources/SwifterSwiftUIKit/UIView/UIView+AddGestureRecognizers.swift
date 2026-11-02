// UIView+AddGestureRecognizers.swift - Copyright 2026 SwifterSwift

#if canImport(UIKit) && !os(watchOS)
import UIKit

public extension UIView {
    /// SwifterSwift: Attaches the given gesture recognizers to the view, in order.
    ///
    /// Each recognizer is added with `addGestureRecognizer(_:)`, and the view keeps a strong reference to it. A gesture
    /// recognizer belongs to one view at a time, so a recognizer that's attached to another view is moved here.
    ///
    /// ```swift
    /// let tap = UITapGestureRecognizer(target: self, action: #selector(didTap))
    /// let pan = UIPanGestureRecognizer(target: self, action: #selector(didPan))
    /// cardView.addGestureRecognizers([tap, pan])
    /// cardView.gestureRecognizers  // [tap, pan]
    /// ```
    ///
    /// - Parameter recognizers: The gesture recognizers to attach.
    /// - Complexity: O(*n*), where *n* is the number of recognizers.
    func addGestureRecognizers(_ recognizers: [UIGestureRecognizer]) {
        for recognizer in recognizers {
            addGestureRecognizer(recognizer)
        }
    }
}
#endif
