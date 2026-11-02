// UINavigationBar+MakeTransparent.swift - Copyright 2026 SwifterSwift

#if canImport(UIKit) && !os(watchOS) && !os(tvOS)
import UIKit

public extension UINavigationBar {
    /// SwifterSwift: Makes the background of the navigation bar transparent in every state.
    ///
    /// A navigation bar picks one of four appearances, depending on its height and on whether content is scrolled to
    /// its edge. Setting only some of them is the usual mistake, and the bar turns opaque again when it's compact or
    /// when content scrolls under it. This method copies `standardAppearance`, calls
    /// `configureWithTransparentBackground()` on the copy, which removes the background color, blur, background image
    /// and shadow, and assigns that one appearance to `standardAppearance`, `compactAppearance`,
    /// `scrollEdgeAppearance` and `compactScrollEdgeAppearance`.
    ///
    /// The title attributes and button appearances of `standardAppearance` are kept, but separate customizations of
    /// the other three appearances are replaced. The appearances of a `UINavigationItem` take precedence over the
    /// bar's, so a view controller whose navigation item has its own appearances keeps them.
    ///
    /// Not available on tvOS: tvOS raises an exception when a navigation bar's appearance properties are set.
    ///
    /// With a tint, the method also sets the bar's `tintColor`, which colors its bar button items, and the color of the
    /// title and the large title. Without one, the colors are left as they are.
    ///
    /// ```swift
    /// let navigationBar = navigationController.navigationBar
    /// navigationBar.makeTransparent(withTint: .white)
    /// navigationBar.scrollEdgeAppearance?.backgroundEffect  // nil
    /// navigationBar.tintColor  // .white
    /// ```
    ///
    /// - Parameter tint: The color of the bar button items and titles, or `nil` to leave the colors as they are.
    func makeTransparent(withTint tint: UIColor? = nil) {
        let appearance = standardAppearance.copy()
        appearance.configureWithTransparentBackground()
        if let tint {
            appearance.titleTextAttributes[.foregroundColor] = tint
            appearance.largeTitleTextAttributes[.foregroundColor] = tint
            tintColor = tint
        }
        standardAppearance = appearance
        compactAppearance = appearance
        scrollEdgeAppearance = appearance
        compactScrollEdgeAppearance = appearance
    }
}
#endif
