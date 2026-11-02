// NSColor+HSBAComponents.swift - Copyright 2026 SwifterSwift

#if canImport(AppKit) && !targetEnvironment(macCatalyst)
import AppKit

public extension NSColor {
    /// SwifterSwift: The color's hue, saturation, brightness and alpha in sRGB, or `nil` if it can't be converted.
    ///
    /// Calling `getHue(_:saturation:brightness:alpha:)` directly raises an exception for grayscale, CMYK and catalog
    /// colors such as `NSColor.black` or `NSColor.labelColor`. This property converts the color with
    /// `usingColorSpace(.sRGB)` first, so it works for any color that has an sRGB equivalent. Pattern colors return
    /// `nil`.
    ///
    /// Every component is in `0...1`. The hue is a fraction of a full turn and is always less than 1, so pure red has a
    /// hue of 0 (AppKit itself reports 1 for it). Grays, including black and white, have a hue and saturation of 0.
    ///
    /// Dynamic system colors are resolved with the current drawing appearance. To read them for a specific appearance,
    /// access this property inside that appearance's `performAsCurrentDrawingAppearance(_:)`.
    ///
    /// ```swift
    /// NSColor.green.hsbaComponents  // (hue: 0.333, saturation: 1.0, brightness: 1.0, alpha: 1.0)
    /// NSColor.black.hsbaComponents  // (hue: 0.0, saturation: 0.0, brightness: 0.0, alpha: 1.0)
    /// NSColor(patternImage: image).hsbaComponents  // nil
    /// ```
    var hsbaComponents: (hue: CGFloat, saturation: CGFloat, brightness: CGFloat, alpha: CGFloat)? {
        guard let color = usingColorSpace(.sRGB) else { return nil }
        var hue: CGFloat = 0
        var saturation: CGFloat = 0
        var brightness: CGFloat = 0
        var alpha: CGFloat = 0
        color.getHue(&hue, saturation: &saturation, brightness: &brightness, alpha: &alpha)
        return (hue >= 1 ? hue - 1 : hue, saturation, brightness, alpha)
    }
}
#endif
