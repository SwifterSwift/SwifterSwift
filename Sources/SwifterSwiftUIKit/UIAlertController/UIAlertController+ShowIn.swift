// UIAlertController+ShowIn.swift - Copyright 2026 SwifterSwift

#if canImport(UIKit) && !os(watchOS)
import UIKit

public extension UIAlertController {
    /// SwifterSwift: Presents the alert controller from the top-most view controller of a window scene.
    ///
    /// This is for code that isn't a view controller, such as a coordinator or an error handler, but knows the scene
    /// to show the alert in. The method starts at the root view controller of the scene's `keyWindow`, follows
    /// `presentedViewController` to the view controller presented last, and presents the alert from there, because a
    /// view controller that's already presenting another one can't present a second one.
    ///
    /// It returns `false` and presents nothing when the scene has no key window, when the key window has no root view
    /// controller, or when the alert is already presented or is the child of another view controller. A scene that
    /// isn't in the foreground usually has no key window. As with any presentation, UIKit can still refuse it, for
    /// example while another view controller is being presented or dismissed. An alert with the `.actionSheet` style
    /// also needs a `popoverPresentationController` source on iPad.
    ///
    /// ```swift
    /// let alert = UIAlertController(title: "Upload failed", message: nil, preferredStyle: .alert)
    /// alert.addAction(UIAlertAction(title: "OK", style: .default))
    /// alert.show(in: windowScene)  // true
    /// alert.show(in: windowScene)  // false, because it's already presented
    /// ```
    ///
    /// - Parameters:
    ///   - windowScene: The window scene to present the alert in.
    ///   - animated: Whether to animate the presentation. The default is `true`.
    ///   - completion: The closure to call after the presentation finishes, or `nil`.
    /// - Returns: `true` if the alert was handed to a view controller to present; otherwise, `false`.
    @discardableResult
    func show(in windowScene: UIWindowScene, animated: Bool = true, completion: (() -> Void)? = nil) -> Bool {
        guard presentingViewController == nil, parent == nil,
            var presenter = windowScene.keyWindow?.rootViewController
        else {
            return false
        }
        while let presented = presenter.presentedViewController {
            presenter = presented
        }
        guard presenter !== self else {
            return false
        }
        presenter.present(self, animated: animated, completion: completion)
        return true
    }
}
#endif
