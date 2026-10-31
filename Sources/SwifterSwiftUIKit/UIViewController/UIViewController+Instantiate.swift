// UIViewController+Instantiate.swift - Copyright 2026 SwifterSwift

#if canImport(UIKit) && !os(watchOS) && !os(visionOS)
import Foundation
import UIKit

public extension UIViewController {
    /// SwifterSwift: Instantiates this view controller class from a storyboard.
    ///
    /// Call it on your own view controller class. Unless you pass an identifier, the storyboard identifier is the
    /// class name, `String(describing: self)`, so give the scene its class name as Storyboard ID.
    ///
    /// The result is `nil` when the bundle has no compiled storyboard with that name, or when the scene doesn't create
    /// an instance of this class, for example when its custom class isn't set. As with
    /// `instantiateViewController(withIdentifier:)`, UIKit raises an exception when the storyboard has no scene with
    /// that identifier.
    ///
    /// Interface Builder files are deprecated on visionOS, so this method isn't available there.
    ///
    /// ```swift
    /// let profile = ProfileViewController.instantiate(from: "Profile")
    /// profile  // a ProfileViewController from Profile.storyboard, or nil
    /// let settings = SettingsViewController.instantiate(identifier: "Settings")
    /// settings  // the "Settings" scene of Main.storyboard, if it's a SettingsViewController
    /// ```
    ///
    /// - Parameters:
    ///   - storyboard: The name of the storyboard file, without its extension. The default is "Main".
    ///   - bundle: The bundle that contains the storyboard. The default is the main bundle.
    ///   - identifier: The storyboard identifier of the scene, or `nil` to use the class name.
    /// - Returns: A new instance of this class, or `nil` if the storyboard is missing or the scene creates another
    ///   class.
    static func instantiate(
        from storyboard: String = "Main",
        bundle: Bundle = .main,
        identifier: String? = nil
    ) -> Self? {
        guard bundle.url(forResource: storyboard, withExtension: "storyboardc") != nil else { return nil }
        let identifier = identifier ?? String(describing: self)
        return UIStoryboard(name: storyboard, bundle: bundle).instantiateViewController(withIdentifier: identifier)
            as? Self
    }
}
#endif
