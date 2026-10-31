// UIColor+InitLight.swift - Copyright 2026 SwifterSwift

#if canImport(UIKit) && !os(watchOS)
import UIKit

public extension UIColor {
    /// SwifterSwift: Creates a dynamic color that uses one color in light mode and another in dark mode.
    ///
    /// UIKit resolves the color each time it's used, with the trait collection in effect at that moment. The dark color
    /// is used when `userInterfaceStyle` is `.dark`, and the light color otherwise, including `.unspecified`. Either
    /// color can itself be dynamic, such as `UIColor.label`; it's resolved with the same traits, so its high-contrast
    /// and elevated variants still apply.
    ///
    /// ```swift
    /// let background = UIColor(light: .white, dark: UIColor(white: 0.1, alpha: 1))
    /// background.resolvedColor(with: UITraitCollection(userInterfaceStyle: .dark))  // UIColor(white: 0.1, alpha: 1)
    /// ```
    ///
    /// - Parameters:
    ///   - light: The color to use in light mode.
    ///   - dark: The color to use in dark mode.
    convenience init(light: UIColor, dark: UIColor) {
        self.init { traits in
            traits.userInterfaceStyle == .dark ? dark.resolvedColor(with: traits) : light.resolvedColor(with: traits)
        }
    }
}
#endif
