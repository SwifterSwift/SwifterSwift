// UIViewController+RemoveViewAndControllerFromParent.swift - Copyright 2026 SwifterSwift

#if canImport(UIKit) && !os(watchOS)
import UIKit

public extension UIViewController {
    /// SwifterSwift: Removes the view controller from its parent and its view from its superview.
    ///
    /// This performs the full containment sequence for removing a child: `willMove(toParent: nil)`, removing the view
    /// from its superview, then `removeFromParent()`. It undoes `addChild(_:toContainerView:)`.
    ///
    /// A view controller with no parent is left unchanged, so calling it on a root or presented view controller never
    /// takes its view out of the window. The view is never loaded just to be removed.
    ///
    /// ```swift
    /// player.removeViewAndControllerFromParent()
    /// player.parent  // nil
    /// player.view.superview  // nil
    /// ```
    func removeViewAndControllerFromParent() {
        guard parent != nil else { return }
        willMove(toParent: nil)
        viewIfLoaded?.removeFromSuperview()
        removeFromParent()
    }
}
#endif
