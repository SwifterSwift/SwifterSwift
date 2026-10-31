// UIColor+RGBAComponents.swift - Copyright 2026 SwifterSwift

#if canImport(UIKit)
import UIKit

public extension UIColor {
    /// SwifterSwift: The color's red, green, blue and alpha components, or `nil` if it can't be converted to RGB.
    ///
    /// The components come from `getRed(_:green:blue:alpha:)`, which converts grayscale and other compatible colors to
    /// extended sRGB. Components of wide-gamut colors, such as Display P3 colors outside sRGB, can fall outside
    /// `0...1`. Colors with no RGB representation, such as pattern colors, return `nil`.
    ///
    /// Dynamic colors, such as `UIColor.label`, are resolved with `UITraitCollection.current`. To read them for a
    /// specific appearance, call `resolvedColor(with:)` first.
    ///
    /// ```swift
    /// UIColor.red.rgbaComponents  // (red: 1.0, green: 0.0, blue: 0.0, alpha: 1.0)
    /// UIColor(white: 0.5, alpha: 0.2).rgbaComponents  // (red: 0.5, green: 0.5, blue: 0.5, alpha: 0.2)
    /// UIColor(patternImage: image).rgbaComponents  // nil
    /// ```
    var rgbaComponents: (red: CGFloat, green: CGFloat, blue: CGFloat, alpha: CGFloat)? {
        var red: CGFloat = 0
        var green: CGFloat = 0
        var blue: CGFloat = 0
        var alpha: CGFloat = 0
        guard getRed(&red, green: &green, blue: &blue, alpha: &alpha) else { return nil }
        return (red, green, blue, alpha)
    }
}
#endif
