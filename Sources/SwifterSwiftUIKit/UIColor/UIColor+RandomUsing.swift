// UIColor+RandomUsing.swift - Copyright 2026 SwifterSwift

#if canImport(UIKit)
import UIKit

public extension UIColor {
    /// SwifterSwift: Returns a random sRGB color, using the given random number generator.
    ///
    /// The red, green and blue components are picked independently and uniformly from `0...1`, so every sRGB color
    /// can be returned. The alpha is fixed rather than random, and it doesn't use the generator. It's clamped to
    /// `0...1`, and NaN counts as 0.
    ///
    /// Pass a seeded generator to get the same color every time, for example in tests or snapshots. The colors for a
    /// given seed can differ between platforms where `CGFloat` has a different size, such as 32-bit Apple Watch models.
    ///
    /// ```swift
    /// var generator = SystemRandomNumberGenerator()
    /// UIColor.random(using: &generator)  // (0.12, 0.85, 0.47), for example
    /// UIColor.random(alpha: 0.5, using: &generator)  // (0.63, 0.09, 0.91), alpha 0.5, for example
    /// ```
    ///
    /// - Parameters:
    ///   - alpha: The opacity, from 0 (transparent) to 1 (opaque). The default is 1.
    ///   - generator: The random number generator to use when picking the components.
    /// - Returns: A color with random red, green and blue components, and the given alpha.
    static func random(alpha: CGFloat = 1, using generator: inout some RandomNumberGenerator) -> Self {
        Self(
            red: .random(in: 0...1, using: &generator),
            green: .random(in: 0...1, using: &generator),
            blue: .random(in: 0...1, using: &generator),
            alpha: CGFloat.minimum(CGFloat.maximum(alpha, 0), 1)
        )
    }
}
#endif
