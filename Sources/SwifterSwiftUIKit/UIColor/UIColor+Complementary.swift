// UIColor+Complementary.swift - Copyright 2026 SwifterSwift

#if canImport(UIKit)
import UIKit

public extension UIColor {
    /// SwifterSwift: The color on the opposite side of the color wheel, or `nil` if it can't be converted to RGB.
    ///
    /// The complement has the hue rotated by 180°, with the same saturation, brightness and alpha. It's computed from
    /// the extended sRGB components by replacing each component `c` with `max + min - c`, where `max` and `min` are the
    /// largest and smallest of the red, green and blue components. Grays, including black and white, have no hue, so
    /// they are their own complement. To get the inverted color instead, subtract each component from 1.
    ///
    /// Colors with no RGB representation, such as pattern colors, return `nil`. Dynamic colors, such as
    /// `UIColor.label`, are resolved with `UITraitCollection.current`, and the result is a static color.
    ///
    /// ```swift
    /// UIColor.red.complementary  // cyan, (0, 1, 1)
    /// UIColor(hex: 0x123456).complementary  // #563412
    /// UIColor.gray.complementary  // gray, (0.5, 0.5, 0.5)
    /// ```
    var complementary: UIColor? {
        var red: CGFloat = 0
        var green: CGFloat = 0
        var blue: CGFloat = 0
        var alpha: CGFloat = 0
        guard getRed(&red, green: &green, blue: &blue, alpha: &alpha) else { return nil }
        let sum = max(red, green, blue) + min(red, green, blue)
        return UIColor(red: sum - red, green: sum - green, blue: sum - blue, alpha: alpha)
    }
}
#endif
