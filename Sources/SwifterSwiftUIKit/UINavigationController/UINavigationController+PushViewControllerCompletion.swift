// UINavigationController+PushViewControllerCompletion.swift - Copyright 2026 SwifterSwift

#if canImport(UIKit) && !os(watchOS)
import UIKit

public extension UINavigationController {
    /// SwifterSwift: Pushes a view controller onto the stack and calls a closure when the transition finishes.
    ///
    /// The closure runs from the completion of the push's transition coordinator, so for an animated push it fires
    /// once the new view controller is fully on screen, after its `viewDidAppear(_:)`. When UIKit runs no transition
    /// coordinator, for example because the push isn't animated or the navigation controller isn't in a window, the
    /// closure is called right away, before this method returns and before the new view controller appears.
    ///
    /// The push itself is UIKit's `pushViewController(_:animated:)`, with the same rules about which view controllers
    /// you can push.
    ///
    /// ```swift
    /// navigationController.pushViewController(detailViewController, animated: true) {
    ///     detailViewController.highlightSelection()
    /// }
    /// ```
    ///
    /// - Parameters:
    ///   - viewController: The view controller to push onto the stack.
    ///   - animated: Whether to animate the transition. The default is `true`.
    ///   - completion: The closure to call after the transition finishes.
    func pushViewController(
        _ viewController: UIViewController,
        animated: Bool = true,
        completion: @escaping () -> Void
    ) {
        pushViewController(viewController, animated: animated)
        guard let transitionCoordinator else {
            completion()
            return
        }
        transitionCoordinator.animate(alongsideTransition: nil) { _ in
            completion()
        }
    }
}
#endif
