// NSColor+Random.swift - Copyright 2026 SwifterSwift

#if canImport(AppKit) && !targetEnvironment(macCatalyst)
import AppKit

public extension NSColor {
    /// SwifterSwift: Returns a random sRGB color.
    ///
    /// The red, green and blue components are picked independently and uniformly from `0...1`, using the system's
    /// random number generator, so every sRGB color can be returned. The alpha is fixed rather than random. It's
    /// clamped to `0...1`, and NaN counts as 0.
    ///
    /// Random colors are handy for debug backgrounds and placeholders, but they don't guarantee contrast with anything
    /// drawn on top. To get the same colors on every run, use `random(alpha:using:)` with a seeded generator.
    ///
    /// ```swift
    /// NSColor.random()  // (0.12, 0.85, 0.47), for example
    /// NSColor.random(alpha: 0.5)  // (0.63, 0.09, 0.91), alpha 0.5, for example
    /// ```
    ///
    /// - Parameter alpha: The opacity, from 0 (transparent) to 1 (opaque). The default is 1.
    /// - Returns: A color with random red, green and blue components, and the given alpha.
    static func random(alpha: CGFloat = 1) -> Self {
        Self(
            srgbRed: .random(in: 0...1),
            green: .random(in: 0...1),
            blue: .random(in: 0...1),
            alpha: CGFloat.minimum(CGFloat.maximum(alpha, 0), 1)
        )
    }
}
#endif
