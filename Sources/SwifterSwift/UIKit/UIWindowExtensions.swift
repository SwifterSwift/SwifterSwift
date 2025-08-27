// UIWindowExtensions.swift - Copyright 2025 SwifterSwift

#if canImport(UIKit) && os(iOS)
import UIKit

// MARK: - Methods

public extension UIWindow {
    /// SwifterSwift: Switch current root view controller with a new view controller.
    ///
    /// - Parameters:
    ///   - viewController: new view controller.
    ///   - animated: set to true to animate view controller change (default is true).
    ///   - duration: animation duration in seconds (default is 0.5).
    ///   - options: animation options (default is .transitionFlipFromRight).
    ///   - completion: optional completion handler called after view controller is changed.
    func switchRootViewController(
        to viewController: UIViewController,
        animated: Bool = true,
        duration: TimeInterval = 0.5,
        options: UIView.AnimationOptions = .transitionFlipFromRight,
        _ completion: (() -> Void)? = nil) {
        guard animated else {
            rootViewController = viewController
            completion?()
            return
        }

        UIView.transition(with: self, duration: duration, options: options, animations: {
            let oldState = UIView.areAnimationsEnabled
            UIView.setAnimationsEnabled(false)
            self.rootViewController = viewController
            UIView.setAnimationsEnabled(oldState)
        }, completion: { _ in
            completion?()
        })
    }
    
    /// SwifterSwift: The current key window of the application.
    ///
    /// Returns the key window that is currently receiving keyboard and other non-touch events.
    /// This property handles both iOS 13+ (using window scenes) and older iOS versions (using the deprecated keyWindow property).
    ///
    /// - Note: On iOS 13 and later, this searches through all connected window scenes to find the key window.
    /// - Note: On iOS 12 and earlier, this uses the deprecated `UIApplication.shared.keyWindow` property.
    static var keyWindow: UIWindow? {
        if #available(iOS 13.0, *) {
            return UIApplication.shared
                .connectedScenes
                .compactMap { $0 as? UIWindowScene }
                .flatMap { $0.windows }
                .first(where: \.isKeyWindow)
        } else {
            return UIApplication.shared.keyWindow
        }
    }
}

#endif
