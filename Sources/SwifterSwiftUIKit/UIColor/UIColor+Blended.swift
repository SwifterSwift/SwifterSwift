// UIColor+Blended.swift - Copyright 2026 SwifterSwift

#if canImport(UIKit)
import UIKit

public extension UIColor {
    /// SwifterSwift: Returns a mix of this color and another color, or `nil` if either color can't be converted to RGB.
    ///
    /// The red, green, blue and alpha components are interpolated linearly in the extended sRGB color space: a
    /// `fraction` of 0 returns this color, 1 returns `color`, and 0.5 an even mix. The fraction is clamped to `0...1`,
    /// and NaN counts as 0. This is the UIKit counterpart of AppKit's `blended(withFraction:of:)`.
    ///
    /// The components come from `getRed(_:green:blue:alpha:)`, so grayscale colors work too. Colors with no RGB
    /// representation, such as pattern colors, return `nil`. Dynamic colors, such as `UIColor.label`, are resolved with
    /// `UITraitCollection.current`, and the result is a static color.
    ///
    /// ```swift
    /// UIColor.white.blended(with: .black)  // (0.5, 0.5, 0.5)
    /// UIColor.red.blended(with: .blue, fraction: 0.25)  // (0.75, 0.0, 0.25)
    /// UIColor.red.blended(with: .clear, fraction: 0.5)  // (0.5, 0.0, 0.0), alpha 0.5
    /// ```
    ///
    /// - Parameters:
    ///   - color: The color to mix in.
    ///   - fraction: How much of `color` to use, from 0 (only this color) to 1 (only `color`). The default is 0.5.
    /// - Returns: The mixed color, or `nil` if either color has no RGB representation.
    func blended(with color: UIColor, fraction: CGFloat = 0.5) -> UIColor? {
        var red1: CGFloat = 0
        var green1: CGFloat = 0
        var blue1: CGFloat = 0
        var alpha1: CGFloat = 0
        var red2: CGFloat = 0
        var green2: CGFloat = 0
        var blue2: CGFloat = 0
        var alpha2: CGFloat = 0
        guard getRed(&red1, green: &green1, blue: &blue1, alpha: &alpha1),
            color.getRed(&red2, green: &green2, blue: &blue2, alpha: &alpha2)
        else { return nil }
        let weight = CGFloat.minimum(CGFloat.maximum(fraction, 0), 1)
        return UIColor(
            red: red1 * (1 - weight) + red2 * weight,
            green: green1 * (1 - weight) + green2 * weight,
            blue: blue1 * (1 - weight) + blue2 * weight,
            alpha: alpha1 * (1 - weight) + alpha2 * weight
        )
    }
}
#endif
