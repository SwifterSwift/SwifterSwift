// UIWindow+SwitchRootViewController.swift - Copyright 2026 SwifterSwift

#if canImport(UIKit) && !os(watchOS)
import Foundation
import UIKit

public extension UIWindow {
    /// SwifterSwift: Replaces the window's root view controller, with an optional transition.
    ///
    /// When `animated` is `true`, the change runs inside `UIView.transition(with:duration:options:animations:)` on the
    /// window, so `options` should contain a transition such as `.transitionCrossDissolve` or `.transitionFlipFromLeft`.
    /// The new view controller's initial layout isn't animated, so its views don't slide in from their initial frames.
    /// When `animated` is `false`, the root view controller is replaced at once and `completion` runs before the method
    /// returns.
    ///
    /// The old root view controller is released by the window once the change is done, unless something else keeps a
    /// reference to it.
    ///
    /// ```swift
    /// window.switchRootViewController(to: homeViewController, options: .transitionCrossDissolve) {
    ///     window.rootViewController === homeViewController  // true
    /// }
    /// ```
    ///
    /// - Parameters:
    ///   - viewController: The new root view controller.
    ///   - animated: Whether to animate the change.
    ///   - duration: The duration of the transition, in seconds. It's ignored when `animated` is `false`.
    ///   - options: The transition and other animation options. They're ignored when `animated` is `false`.
    ///   - completion: A closure to run after the root view controller is replaced.
    func switchRootViewController(
        to viewController: UIViewController,
        animated: Bool = true,
        duration: TimeInterval = 0.5,
        options: UIView.AnimationOptions = .transitionFlipFromRight,
        completion: (() -> Void)? = nil
    ) {
        guard animated else {
            rootViewController = viewController
            completion?()
            return
        }
        UIView.transition(
            with: self,
            duration: duration,
            options: options,
            animations: {
                UIView.performWithoutAnimation {
                    self.rootViewController = viewController
                }
            },
            completion: { _ in completion?() }
        )
    }
}
#endif
