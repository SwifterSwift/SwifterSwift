// UIColor+Darkened.swift - Copyright 2026 SwifterSwift

#if canImport(UIKit)
import UIKit

public extension UIColor {
    /// SwifterSwift: Returns the color mixed with black by the given amount.
    ///
    /// Each red, green and blue component is scaled toward 0 by `amount`, so the hue stays the same and nothing is
    /// clipped. An amount of 0 returns the same color and 1 returns black. The amount is clamped to `0...1`, and NaN
    /// counts as 0. The alpha component is kept.
    ///
    /// The components come from `getRed(_:green:blue:alpha:)`, so grayscale colors work too. Colors with no RGB
    /// representation, such as pattern colors, return `nil`. Dynamic colors, such as `UIColor.label`, are resolved with
    /// `UITraitCollection.current`, and the result is a static color.
    ///
    /// ```swift
    /// UIColor.blue.darkened(by: 0.25)  // (0.0, 0.0, 0.75)
    /// UIColor.white.darkened(by: 0.5)  // (0.5, 0.5, 0.5)
    /// UIColor.black.darkened(by: 0.5)  // black
    /// ```
    ///
    /// - Parameter amount: How far to move each component toward 0, from 0 (unchanged) to 1 (black).
    /// - Returns: The darkened color, or `nil` if the color has no RGB representation.
    func darkened(by amount: CGFloat) -> UIColor? {
        var red: CGFloat = 0
        var green: CGFloat = 0
        var blue: CGFloat = 0
        var alpha: CGFloat = 0
        guard getRed(&red, green: &green, blue: &blue, alpha: &alpha) else { return nil }
        let fraction = CGFloat.minimum(CGFloat.maximum(amount, 0), 1)
        return UIColor(
            red: red * (1 - fraction),
            green: green * (1 - fraction),
            blue: blue * (1 - fraction),
            alpha: alpha
        )
    }
}
#endif
