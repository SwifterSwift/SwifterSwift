// NSColor+InitRed255.swift - Copyright 2026 SwifterSwift

#if canImport(AppKit) && !targetEnvironment(macCatalyst)
import AppKit

public extension NSColor {
    /// SwifterSwift: Creates an sRGB color from components in `0...255`, such as a design spec's `(255, 128, 0)`.
    ///
    /// Each component is divided by 255, so 0 gives 0 and 255 gives 1. The `UInt8` components can't be out of range: a
    /// literal above 255 doesn't compile, and an `Int` read at runtime has to be converted first, for example with
    /// `UInt8(clamping:)` or `UInt8(exactly:)`. The alpha is clamped to `0...1`, and NaN counts as 0.
    ///
    /// The `red255:` labels keep this initializer apart from AppKit's `init(red:green:blue:alpha:)`, which takes
    /// components in `0...1`, so `NSColor(red: 1, green: 0, blue: 0, alpha: 1)` is still pure red.
    ///
    /// ```swift
    /// NSColor(red255: 255, green255: 128, blue255: 0)  // orange, (1.0, 0.502, 0.0)
    /// NSColor(red255: 31, green255: 45, blue255: 60, alpha: 0.5)  // (0.122, 0.176, 0.235), alpha 0.5
    /// ```
    ///
    /// - Parameters:
    ///   - red: The red component, from 0 to 255.
    ///   - green: The green component, from 0 to 255.
    ///   - blue: The blue component, from 0 to 255.
    ///   - alpha: The opacity, from 0 (transparent) to 1 (opaque). The default is 1.
    convenience init(red255 red: UInt8, green255 green: UInt8, blue255 blue: UInt8, alpha: CGFloat = 1) {
        self.init(
            srgbRed: CGFloat(red) / 255,
            green: CGFloat(green) / 255,
            blue: CGFloat(blue) / 255,
            alpha: CGFloat.minimum(CGFloat.maximum(alpha, 0), 1)
        )
    }
}
#endif
