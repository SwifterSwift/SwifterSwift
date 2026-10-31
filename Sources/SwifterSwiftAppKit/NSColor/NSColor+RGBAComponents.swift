// NSColor+RGBAComponents.swift - Copyright 2026 SwifterSwift

#if canImport(AppKit) && !targetEnvironment(macCatalyst)
import AppKit

public extension NSColor {
    /// SwifterSwift: The color's red, green, blue and alpha components in sRGB, or `nil` if it can't be converted.
    ///
    /// Reading `redComponent` or calling `getRed(_:green:blue:alpha:)` directly raises an exception for grayscale, CMYK
    /// and catalog colors such as `NSColor.white` or `NSColor.labelColor`. This property converts the color with
    /// `usingColorSpace(.sRGB)` first, so it works for any color that has an sRGB equivalent. Wide-gamut colors, such
    /// as Display P3 colors outside sRGB, are clipped to the sRGB gamut, so every component is in `0...1`. Pattern
    /// colors return `nil`.
    ///
    /// Dynamic system colors are resolved with the current drawing appearance. To read them for a specific appearance,
    /// access this property inside that appearance's `performAsCurrentDrawingAppearance(_:)`.
    ///
    /// ```swift
    /// NSColor.red.rgbaComponents  // (red: 1.0, green: 0.0, blue: 0.0, alpha: 1.0)
    /// NSColor(white: 0.5, alpha: 0.2).rgbaComponents  // (red: 0.5, green: 0.5, blue: 0.5, alpha: 0.2)
    /// NSColor(patternImage: image).rgbaComponents  // nil
    /// ```
    var rgbaComponents: (red: CGFloat, green: CGFloat, blue: CGFloat, alpha: CGFloat)? {
        guard let color = usingColorSpace(.sRGB) else { return nil }
        return (color.redComponent, color.greenComponent, color.blueComponent, color.alphaComponent)
    }
}
#endif
