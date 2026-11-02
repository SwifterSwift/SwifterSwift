// UIColor+HexString.swift - Copyright 2026 SwifterSwift

#if canImport(UIKit)
import UIKit

public extension UIColor {
    /// SwifterSwift: Returns the color as a `#RRGGBB` or `#RRGGBBAA` hex string, or `nil` if it can't be converted.
    ///
    /// The components come from `getRed(_:green:blue:alpha:)`, so grayscale colors work too. Wide-gamut components
    /// outside `0...1` are clamped to the sRGB range. Each component is rounded to the nearest of 256 steps, so 0.5
    /// becomes `80`. The digits are uppercase. Pattern colors, and colors with a NaN component, return `nil`.
    ///
    /// The result can be passed back to `UIColor(hexString:)`. Dynamic colors, such as `UIColor.label`, are resolved
    /// with `UITraitCollection.current`; call `resolvedColor(with:)` first to pick an appearance.
    ///
    /// ```swift
    /// UIColor.orange.hexString()  // "#FF8000"
    /// UIColor.white.hexString()  // "#FFFFFF"
    /// UIColor.red.withAlphaComponent(0.5).hexString(includingAlpha: true)  // "#FF000080"
    /// UIColor(patternImage: image).hexString()  // nil
    /// ```
    ///
    /// - Parameter includingAlpha: Whether to append the alpha component as a fourth pair of digits. The default is
    ///   `false`.
    /// - Returns: The hexadecimal string, starting with `#`, or `nil` if the color has no RGB representation.
    func hexString(includingAlpha: Bool = false) -> String? {
        var red: CGFloat = 0
        var green: CGFloat = 0
        var blue: CGFloat = 0
        var alpha: CGFloat = 0
        guard getRed(&red, green: &green, blue: &blue, alpha: &alpha) else { return nil }
        let components = includingAlpha ? [red, green, blue, alpha] : [red, green, blue]
        guard !components.contains(where: \.isNaN) else { return nil }
        return components.reduce(into: "#") { result, component in
            let digits = String(Int((min(max(component, 0), 1) * 255).rounded()), radix: 16, uppercase: true)
            result += digits.count == 1 ? "0" + digits : digits
        }
    }
}
#endif
