// UIColor+HexValue.swift - Copyright 2026 SwifterSwift

#if canImport(UIKit)
import UIKit

public extension UIColor {
    /// SwifterSwift: The color's red, green and blue components packed into a `0xRRGGBB` integer.
    ///
    /// This is the inverse of `UIColor(hex:alpha:)`. The alpha component isn't included; read it from `cgColor.alpha`.
    /// The components come from `getRed(_:green:blue:alpha:)`, so grayscale colors work too. Wide-gamut components
    /// outside `0...1` are clamped to the sRGB range, and each component is rounded to the nearest of 256 steps.
    /// Pattern colors, and colors with a NaN component, return `nil`. Dynamic colors are resolved with
    /// `UITraitCollection.current`.
    ///
    /// ```swift
    /// UIColor.orange.hexValue  // 0xFF8000
    /// UIColor(hex: 0x1F2D3C).hexValue  // 0x1F2D3C
    /// UIColor(patternImage: image).hexValue  // nil
    /// ```
    var hexValue: UInt32? {
        var red: CGFloat = 0
        var green: CGFloat = 0
        var blue: CGFloat = 0
        guard getRed(&red, green: &green, blue: &blue, alpha: nil) else { return nil }
        let components = [red, green, blue]
        guard !components.contains(where: \.isNaN) else { return nil }
        return components.reduce(0) { result, component in
            result << 8 | UInt32((min(max(component, 0), 1) * 255).rounded())
        }
    }
}
#endif
