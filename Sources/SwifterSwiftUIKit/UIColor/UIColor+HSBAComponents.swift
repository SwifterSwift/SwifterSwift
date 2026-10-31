// UIColor+HSBAComponents.swift - Copyright 2026 SwifterSwift

#if canImport(UIKit)
import UIKit

public extension UIColor {
    /// SwifterSwift: The color's hue, saturation, brightness and alpha, or `nil` if it can't be converted to RGB.
    ///
    /// The components come from `getHue(_:saturation:brightness:alpha:)`, which works on the color's extended sRGB
    /// components. The hue is a fraction of a full turn in `0..<1`, so pure red has a hue of 0. Grays, including black
    /// and white, have a hue and saturation of 0. Wide-gamut colors, such as Display P3 colors outside sRGB, can have a
    /// saturation or brightness above 1. Colors with no RGB representation, such as pattern colors, return `nil`.
    ///
    /// Dynamic colors, such as `UIColor.label`, are resolved with `UITraitCollection.current`. To read them for a
    /// specific appearance, call `resolvedColor(with:)` first.
    ///
    /// ```swift
    /// UIColor.green.hsbaComponents  // (hue: 0.333, saturation: 1.0, brightness: 1.0, alpha: 1.0)
    /// UIColor.black.hsbaComponents  // (hue: 0.0, saturation: 0.0, brightness: 0.0, alpha: 1.0)
    /// UIColor(patternImage: image).hsbaComponents  // nil
    /// ```
    var hsbaComponents: (hue: CGFloat, saturation: CGFloat, brightness: CGFloat, alpha: CGFloat)? {
        var hue: CGFloat = 0
        var saturation: CGFloat = 0
        var brightness: CGFloat = 0
        var alpha: CGFloat = 0
        guard getHue(&hue, saturation: &saturation, brightness: &brightness, alpha: &alpha) else { return nil }
        return (hue, saturation, brightness, alpha)
    }
}
#endif
