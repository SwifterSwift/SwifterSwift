// UINavigationControllerExtensions.swift - Copyright 2020 SwifterSwift

#if canImport(UIKit) && !os(watchOS)
import UIKit

// MARK: - Methods

public extension UINavigationController {
    /// SwifterSwift: Pop ViewController with completion handler.
    ///
    /// - Parameters:
    ///   - animated: Set this value to true to animate the transition (default is true).
    ///   - completion: optional completion handler (default is nil).
    func popViewController(animated: Bool = true, _ completion: (() -> Void)? = nil) {
        // https://github.com/cotkjaer/UserInterface/blob/master/UserInterface/UIViewController.swift
        CATransaction.begin()
        CATransaction.setCompletionBlock(completion)
        popViewController(animated: animated)
        CATransaction.commit()
    }
    
    /// SwifterSwift: Pop ViewController to a specific ViewController.
    ///
    /// - Parameters:
    ///   - ofClass: your destination class to pop.
    ///   - animated: Set this value to true to animate the transition (default is true).
    func popTo(ViewController ofClass: AnyClass, animated: Bool) {
        if let vc = viewControllers.last(where: { $0.isKind(of: ofClass) }) {
            popToViewController(vc, animated: animated)
        }
    }
    
    /// SwifterSwift: Pop ViewController to a specific ViewController with completion handler.
    ///
    /// - Parameters:
    ///   - ofClass: your destination class to pop.
    ///   - animated: Set this value to true to animate the transition (default is true).
    ///   - completion: optional completion handler (default is nil).
    func popTo(ViewController ofClass: AnyClass, animated: Bool,  _ completion: (() -> Void)? = nil) {
        if let vc = viewControllers.last(where: { $0.isKind(of: ofClass) }) {
            CATransaction.begin()
            CATransaction.setCompletionBlock(completion)
            popToViewController(vc, animated: animated)
            CATransaction.commit()
        }
    }

    /// SwifterSwift: Push ViewController with completion handler.
    ///
    /// - Parameters:
    ///   - viewController: viewController to push.
    ///   - completion: optional completion handler (default is nil).
    func pushViewController(_ viewController: UIViewController, completion: (() -> Void)? = nil) {
        // https://github.com/cotkjaer/UserInterface/blob/master/UserInterface/UIViewController.swift
        CATransaction.begin()
        CATransaction.setCompletionBlock(completion)
        pushViewController(viewController, animated: true)
        CATransaction.commit()
    }

    /// SwifterSwift: Make navigation controller's navigation bar transparent.
    ///
    /// - Parameter tint: tint color (default is .white).
    func makeTransparent(withTint tint: UIColor = .white) {
        navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationBar.shadowImage = UIImage()
        navigationBar.isTranslucent = true
        navigationBar.tintColor = tint
        navigationBar.titleTextAttributes = [.foregroundColor: tint]
    }
}

#endif
