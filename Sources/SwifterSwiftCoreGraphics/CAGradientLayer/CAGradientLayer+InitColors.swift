// CAGradientLayer+InitColors.swift - Copyright 2026 SwifterSwift

#if canImport(QuartzCore) && !os(watchOS)
import CoreGraphics
import Foundation
import QuartzCore

public extension CAGradientLayer {
    /// SwifterSwift: Creates a gradient layer with the given colors, stop locations, direction and type.
    ///
    /// `CAGradientLayer.colors` is an `[Any]?` that only renders `CGColor` values: assigning `UIColor` or `NSColor`
    /// objects compiles but draws nothing. This initializer takes `[CGColor]`, so that mistake can't happen, and takes
    /// the stop locations as `CGFloat` values instead of `NSNumber` objects.
    ///
    /// The locations should increase from 0 to 1, with one location per color. Core Animation doesn't validate them,
    /// so other values don't crash but give an undefined gradient. Pass `nil` to spread the colors evenly.
    ///
    /// The default start and end points are the ones of a new `CAGradientLayer`: a vertical gradient from `y = 0` to
    /// `y = 1` in the layer's unit coordinate space, which runs from top to bottom on iOS, tvOS and visionOS, and from
    /// bottom to top in a macOS layer that isn't flipped.
    ///
    /// Core Animation isn't available on watchOS, so neither is this initializer.
    ///
    /// ```swift
    /// let gradient = CAGradientLayer(
    ///     colors: [UIColor.systemTeal.cgColor, UIColor.systemBlue.cgColor],
    ///     startPoint: CGPoint(x: 0, y: 0.5),
    ///     endPoint: CGPoint(x: 1, y: 0.5)
    /// )
    /// gradient.frame = view.bounds
    /// gradient.colors?.count  // 2
    /// gradient.type  // .axial
    /// ```
    ///
    /// - Parameters:
    ///   - colors: The color of each gradient stop.
    ///   - locations: The location of each gradient stop, from 0 to 1, or `nil` to spread the stops evenly.
    ///   - startPoint: The point where the gradient starts, in the layer's unit coordinate space.
    ///   - endPoint: The point where the gradient ends, in the layer's unit coordinate space.
    ///   - type: The kind of gradient to draw, such as `.axial`, `.radial` or `.conic`.
    convenience init(
        colors: [CGColor],
        locations: [CGFloat]? = nil,
        startPoint: CGPoint = CGPoint(x: 0.5, y: 0),
        endPoint: CGPoint = CGPoint(x: 0.5, y: 1),
        type: CAGradientLayerType = .axial
    ) {
        self.init()
        self.colors = colors
        self.locations = locations?.map { NSNumber(value: Double($0)) }
        self.startPoint = startPoint
        self.endPoint = endPoint
        self.type = type
    }
}
#endif
