// NSColor+HexValue.swift - Copyright 2026 SwifterSwift

#if canImport(AppKit) && !targetEnvironment(macCatalyst)
import AppKit

public extension NSColor {
    /// SwifterSwift: The color's red, green and blue components packed into a `0xRRGGBB` integer.
    ///
    /// This is the inverse of `NSColor(hex:alpha:)`. The alpha component isn't included; read it from
    /// `alphaComponent`. The color is converted with `usingColorSpace(.sRGB)` first, so grayscale, CMYK and catalog
    /// colors such as `NSColor.labelColor` work instead of raising an exception. Wide-gamut colors are clipped to the
    /// sRGB gamut, and each component is rounded to the nearest of 256 steps. Pattern colors, and colors with a NaN
    /// component, return `nil`.
    ///
    /// ```swift
    /// NSColor.orange.hexValue  // 0xFF8000
    /// NSColor(hex: 0x1F2D3C).hexValue  // 0x1F2D3C
    /// NSColor(patternImage: image).hexValue  // nil
    /// ```
    var hexValue: UInt32? {
        guard let color = usingColorSpace(.sRGB) else { return nil }
        let components = [color.redComponent, color.greenComponent, color.blueComponent]
        guard !components.contains(where: \.isNaN) else { return nil }
        return components.reduce(0) { result, component in
            result << 8 | UInt32((min(max(component, 0), 1) * 255).rounded())
        }
    }
}
#endif
