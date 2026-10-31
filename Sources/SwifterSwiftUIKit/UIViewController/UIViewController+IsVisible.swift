// UIViewController+IsVisible.swift - Copyright 2026 SwifterSwift

#if canImport(UIKit) && !os(watchOS)
import UIKit

public extension UIViewController {
    /// SwifterSwift: Whether the view controller's view is loaded and in a window.
    ///
    /// Reading this property never loads the view: a view controller whose view isn't loaded yet isn't visible. Unlike
    /// `view.window != nil`, which would load the view as a side effect, it checks `viewIfLoaded`.
    ///
    /// Being in a window doesn't mean the user can see the view: it can still be hidden, fully transparent, covered by
    /// another view or presented view controller, or in a window that isn't shown.
    ///
    /// ```swift
    /// let viewController = UIViewController()
    /// viewController.isVisible  // false, and the view is still not loaded
    /// window.rootViewController = viewController
    /// viewController.isVisible  // true
    /// ```
    var isVisible: Bool {
        viewIfLoaded?.window != nil
    }
}
#endif
