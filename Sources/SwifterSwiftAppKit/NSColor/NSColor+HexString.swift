// NSColor+HexString.swift - Copyright 2026 SwifterSwift

#if canImport(AppKit) && !targetEnvironment(macCatalyst)
import AppKit

public extension NSColor {
    /// SwifterSwift: Returns the color as a `#RRGGBB` or `#RRGGBBAA` hex string, or `nil` if it can't be converted.
    ///
    /// The color is converted with `usingColorSpace(.sRGB)` first, so grayscale, CMYK and catalog colors such as
    /// `NSColor.labelColor` work instead of raising an exception. Wide-gamut colors are clipped to the sRGB gamut. Each
    /// component is rounded to the nearest of 256 steps, so 0.5 becomes `80`. The digits are uppercase. Pattern colors,
    /// and colors with a NaN component, return `nil`.
    ///
    /// The result can be passed back to `NSColor(hexString:)`. Dynamic system colors are resolved with the current
    /// drawing appearance.
    ///
    /// ```swift
    /// NSColor.orange.hexString()  // "#FF8000"
    /// NSColor.white.hexString()  // "#FFFFFF"
    /// NSColor.red.withAlphaComponent(0.5).hexString(includingAlpha: true)  // "#FF000080"
    /// NSColor(patternImage: image).hexString()  // nil
    /// ```
    ///
    /// - Parameter includingAlpha: Whether to append the alpha component as a fourth pair of digits. The default is
    ///   `false`.
    /// - Returns: The hexadecimal string, starting with `#`, or `nil` if the color has no sRGB representation.
    func hexString(includingAlpha: Bool = false) -> String? {
        guard let color = usingColorSpace(.sRGB) else { return nil }
        var components = [color.redComponent, color.greenComponent, color.blueComponent]
        if includingAlpha {
            components.append(color.alphaComponent)
        }
        guard !components.contains(where: \.isNaN) else { return nil }
        return components.reduce(into: "#") { result, component in
            let digits = String(Int((min(max(component, 0), 1) * 255).rounded()), radix: 16, uppercase: true)
            result += digits.count == 1 ? "0" + digits : digits
        }
    }
}
#endif
