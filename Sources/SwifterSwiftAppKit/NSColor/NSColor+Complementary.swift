// NSColor+Complementary.swift - Copyright 2026 SwifterSwift

#if canImport(AppKit) && !targetEnvironment(macCatalyst)
import AppKit

public extension NSColor {
    /// SwifterSwift: The color on the opposite side of the color wheel, or `nil` if it can't be converted to sRGB.
    ///
    /// The complement has the hue rotated by 180°, with the same saturation, brightness and alpha. It's computed in the
    /// sRGB color space by replacing each component `c` with `max + min - c`, where `max` and `min` are the largest and
    /// smallest of the red, green and blue components. Grays, including black and white, have no hue, so they are their
    /// own complement. To get the inverted color instead, subtract each component from 1.
    ///
    /// The color is converted with `usingColorSpace(.sRGB)` first, so grayscale, CMYK and catalog colors such as
    /// `NSColor.labelColor` work instead of raising an exception. Pattern colors return `nil`. Dynamic system colors
    /// are resolved with the current drawing appearance, and the result is a static sRGB color.
    ///
    /// ```swift
    /// NSColor.red.complementary  // cyan, (0, 1, 1)
    /// NSColor(hex: 0x123456).complementary  // #563412
    /// NSColor.gray.complementary  // gray, (0.5, 0.5, 0.5)
    /// ```
    var complementary: NSColor? {
        guard let color = usingColorSpace(.sRGB) else { return nil }
        let red = color.redComponent
        let green = color.greenComponent
        let blue = color.blueComponent
        let sum = max(red, green, blue) + min(red, green, blue)
        return NSColor(srgbRed: sum - red, green: sum - green, blue: sum - blue, alpha: color.alphaComponent)
    }
}
#endif
