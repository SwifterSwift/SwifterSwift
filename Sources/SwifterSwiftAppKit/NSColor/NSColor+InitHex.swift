// NSColor+InitHex.swift - Copyright 2026 SwifterSwift

#if canImport(AppKit) && !targetEnvironment(macCatalyst)
import AppKit

public extension NSColor {
    /// SwifterSwift: Creates an sRGB color from a `0xRRGGBB` integer and an alpha value.
    ///
    /// The highest byte holds red and the lowest holds blue, the same order as a CSS hex color. Only the lowest 24 bits
    /// are read, so a value above `0xFFFFFF` ignores its extra bits; to read an alpha channel from the value, use
    /// `NSColor(hexString:)` with an 8-digit string instead. The alpha is clamped to `0...1`, and NaN counts as 0.
    ///
    /// ```swift
    /// NSColor(hex: 0xFF8000)  // orange, (1.0, 0.502, 0.0)
    /// NSColor(hex: 0x1F2D3C, alpha: 0.5)  // (0.122, 0.176, 0.235), alpha 0.5
    /// ```
    ///
    /// - Parameters:
    ///   - hex: The red, green and blue components as an integer, such as `0xFF8000`.
    ///   - alpha: The opacity, from 0 (transparent) to 1 (opaque). The default is 1.
    convenience init(hex: UInt32, alpha: CGFloat = 1) {
        self.init(
            srgbRed: CGFloat((hex >> 16) & 0xFF) / 255,
            green: CGFloat((hex >> 8) & 0xFF) / 255,
            blue: CGFloat(hex & 0xFF) / 255,
            alpha: CGFloat.minimum(CGFloat.maximum(alpha, 0), 1)
        )
    }
}
#endif
