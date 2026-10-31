// UIStoryboard+InstantiateViewControllerWithClass.swift - Copyright 2026 SwifterSwift

#if canImport(UIKit) && !os(watchOS) && !os(visionOS)
import UIKit

public extension UIStoryboard {
    /// SwifterSwift: Instantiates the view controller whose storyboard identifier is the name of the given class.
    ///
    /// The identifier is `String(describing: type)`, the unqualified type name, so `ProfileViewController.self` looks
    /// for a scene with the Storyboard ID "ProfileViewController". Give your scenes their class name as Storyboard ID
    /// to use this method.
    ///
    /// The result is `nil` when the instantiated view controller isn't a `T`, for example when the scene's custom
    /// class isn't set. As with `instantiateViewController(withIdentifier:)`, UIKit raises an exception when the
    /// storyboard has no scene with that identifier.
    ///
    /// Interface Builder files are deprecated on visionOS, so this method isn't available there.
    ///
    /// ```swift
    /// let storyboard = UIStoryboard(name: "Main", bundle: .main)
    /// let profile = storyboard.instantiateViewController(withClass: ProfileViewController.self)
    /// profile  // a ProfileViewController, or nil if the scene's class doesn't match
    /// ```
    ///
    /// - Parameter type: The class of the view controller, which is also its storyboard identifier.
    /// - Returns: A new instance of the view controller, or `nil` if the scene doesn't create a `T`.
    func instantiateViewController<T: UIViewController>(withClass type: T.Type) -> T? {
        instantiateViewController(withIdentifier: String(describing: type)) as? T
    }
}
#endif
