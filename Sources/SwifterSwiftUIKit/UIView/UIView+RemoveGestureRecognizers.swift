// UIView+RemoveGestureRecognizers.swift - Copyright 2026 SwifterSwift

#if canImport(UIKit) && !os(watchOS)
import UIKit

public extension UIView {
    /// SwifterSwift: Detaches the given gesture recognizers from the view.
    ///
    /// Each recognizer is removed with `removeGestureRecognizer(_:)`, which also releases the view's reference to it. A
    /// recognizer that isn't attached to this view is ignored, so it stays on whatever view it belongs to. To remove
    /// every recognizer, set `gestureRecognizers` to `nil` instead.
    ///
    /// ```swift
    /// cardView.addGestureRecognizers([tap, pan, swipe])
    /// cardView.removeGestureRecognizers([tap, pan])
    /// cardView.gestureRecognizers  // [swipe]
    /// ```
    ///
    /// - Parameter recognizers: The gesture recognizers to detach.
    /// - Complexity: O(*n*), where *n* is the number of recognizers.
    func removeGestureRecognizers(_ recognizers: [UIGestureRecognizer]) {
        for recognizer in recognizers {
            removeGestureRecognizer(recognizer)
        }
    }
}
#endif
