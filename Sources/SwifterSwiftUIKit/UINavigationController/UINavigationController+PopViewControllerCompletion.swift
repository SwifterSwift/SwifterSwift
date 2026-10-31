// UINavigationController+PopViewControllerCompletion.swift - Copyright 2026 SwifterSwift

#if canImport(UIKit) && !os(watchOS)
import UIKit

public extension UINavigationController {
    /// SwifterSwift: Pops the top view controller off the stack and calls a closure when the transition finishes.
    ///
    /// The closure runs from the completion of the pop's transition coordinator, so for an animated pop it fires once
    /// the previous view controller is fully on screen, after its `viewDidAppear(_:)`. When UIKit runs no transition
    /// coordinator, for example because the pop isn't animated, the stack holds only the root view controller, or the
    /// navigation controller isn't in a window, the closure is called right away, before this method returns.
    ///
    /// ```swift
    /// navigationController.popViewController(animated: true) {
    ///     listViewController.reloadData()
    /// }
    /// ```
    ///
    /// - Parameters:
    ///   - animated: Whether to animate the transition. The default is `true`.
    ///   - completion: The closure to call after the transition finishes.
    /// - Returns: The view controller that was popped, or `nil` if the stack holds only the root view controller.
    @discardableResult
    func popViewController(animated: Bool = true, completion: @escaping () -> Void) -> UIViewController? {
        let poppedViewController = popViewController(animated: animated)
        guard let transitionCoordinator else {
            completion()
            return poppedViewController
        }
        transitionCoordinator.animate(alongsideTransition: nil) { _ in
            completion()
        }
        return poppedViewController
    }
}
#endif
