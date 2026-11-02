// NSColor+Lightened.swift - Copyright 2026 SwifterSwift

#if canImport(AppKit) && !targetEnvironment(macCatalyst)
import AppKit

public extension NSColor {
    /// SwifterSwift: Returns the color mixed with white by the given amount.
    ///
    /// Each red, green and blue component moves toward 1 by `amount` of the remaining distance, so the hue stays the
    /// same and nothing is clipped. An amount of 0 returns the same color and 1 returns white. The amount is clamped to
    /// `0...1`, and NaN counts as 0. The alpha component is kept.
    ///
    /// Unlike `highlight(withLevel:)`, which mixes with the system highlight color, the result doesn't depend on the
    /// appearance. The color is converted with `usingColorSpace(.sRGB)` first, so grayscale, CMYK and catalog colors
    /// such as `NSColor.labelColor` work instead of raising an exception. Pattern colors return `nil`. Dynamic system
    /// colors are resolved with the current drawing appearance, and the result is a static sRGB color.
    ///
    /// ```swift
    /// NSColor.blue.lightened(by: 0.25)  // (0.25, 0.25, 1.0)
    /// NSColor.black.lightened(by: 0.5)  // (0.5, 0.5, 0.5)
    /// NSColor.white.lightened(by: 0.5)  // white
    /// ```
    ///
    /// - Parameter amount: How far to move each component toward 1, from 0 (unchanged) to 1 (white).
    /// - Returns: The lightened color in the sRGB color space, or `nil` if the color has no sRGB representation.
    func lightened(by amount: CGFloat) -> NSColor? {
        guard let color = usingColorSpace(.sRGB) else { return nil }
        let fraction = CGFloat.minimum(CGFloat.maximum(amount, 0), 1)
        return NSColor(
            srgbRed: color.redComponent * (1 - fraction) + fraction,
            green: color.greenComponent * (1 - fraction) + fraction,
            blue: color.blueComponent * (1 - fraction) + fraction,
            alpha: color.alphaComponent
        )
    }
}
#endif
