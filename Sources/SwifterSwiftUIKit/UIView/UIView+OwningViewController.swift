// UIView+OwningViewController.swift - Copyright 2026 SwifterSwift

#if canImport(UIKit) && !os(watchOS)
import UIKit

public extension UIView {
    /// SwifterSwift: The view controller that manages this view or its closest managed ancestor.
    ///
    /// The view walks up the responder chain and returns the first view controller it meets. For a view controller's
    /// root view that's the view controller itself, and for any other view it's the view controller of the closest
    /// ancestor that is a root view. This is different from `UIViewController.parent`, which returns the *container*
    /// of a view controller. The result is `nil` for a view that isn't in a view controller's hierarchy.
    ///
    /// ```swift
    /// let controller = UIViewController()
    /// let button = UIButton()
    /// controller.view.addSubview(button)
    /// button.owningViewController  // controller
    /// controller.view.owningViewController  // controller
    /// UIView().owningViewController  // nil
    /// ```
    ///
    /// - Complexity: O(*n*), where *n* is the number of responders between the view and its view controller.
    var owningViewController: UIViewController? {
        var responder = next
        while let current = responder {
            if let viewController = current as? UIViewController {
                return viewController
            }
            responder = current.next
        }
        return nil
    }
}
#endif
