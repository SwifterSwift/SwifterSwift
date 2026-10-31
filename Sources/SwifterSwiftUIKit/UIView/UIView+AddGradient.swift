// UIView+AddGradient.swift - Copyright 2026 SwifterSwift

#if canImport(UIKit) && !os(watchOS)
import CoreGraphics
import Foundation
import QuartzCore
import UIKit

public extension UIView {
    /// SwifterSwift: Fills the view's background with a linear gradient.
    ///
    /// The gradient is drawn by a `CAGradientLayer` inserted below all of the view's other sublayers, so it covers the
    /// view's background color and sits behind its subviews. It still covers what a view draws in its own layer, such
    /// as the text of a `UILabel` or the image of a `UIImageView`, so add the gradient to a container view instead.
    ///
    /// Calling the method again doesn't stack another layer: it updates the gradient layer it added before, including
    /// its frame. That makes it safe to call from `layoutSubviews()`, which is the way to keep the gradient the size of
    /// the view, because a layer doesn't resize with its view.
    ///
    /// The start and end points are in the unit coordinate space of the layer, where `(0, 0)` is the top-left corner
    /// and `(1, 1)` the bottom-right one. The defaults draw the gradient from top to bottom. Locations are fractions
    /// from `0` to `1` and should increase. When `locations` is `nil`, or doesn't have one value per color, the colors
    /// are spread evenly. Dynamic colors are resolved with the view's current trait collection, so call the method
    /// again when the appearance changes.
    ///
    /// ```swift
    /// headerView.addGradient(colors: [.systemBlue, .systemPurple])
    /// headerView.addGradient(
    ///     colors: [.red, .orange, .yellow],
    ///     locations: [0, 0.2, 1],
    ///     startPoint: CGPoint(x: 0, y: 0.5),
    ///     endPoint: CGPoint(x: 1, y: 0.5)
    /// )
    /// headerView.layer.sublayers?.count { $0 is CAGradientLayer }  // 1
    /// ```
    ///
    /// - Parameters:
    ///   - colors: The colors of the gradient, from the start point to the end point.
    ///   - locations: The location of each color, or `nil` to spread them evenly.
    ///   - startPoint: The point where the gradient starts.
    ///   - endPoint: The point where the gradient ends.
    /// - Returns: The layer that draws the gradient.
    /// - Complexity: O(*n* + *m*), where *n* is the number of colors and *m* the number of sublayers.
    @discardableResult
    func addGradient(
        colors: [UIColor],
        locations: [CGFloat]? = nil,
        startPoint: CGPoint = CGPoint(x: 0.5, y: 0),
        endPoint: CGPoint = CGPoint(x: 0.5, y: 1)
    ) -> CAGradientLayer {
        let name = "SwifterSwift.addGradient"
        let existingLayer = layer.sublayers?.first { $0.name == name } as? CAGradientLayer
        let gradientLayer = existingLayer ?? CAGradientLayer()
        gradientLayer.name = name
        gradientLayer.frame = bounds
        gradientLayer.colors = colors.map { $0.resolvedColor(with: traitCollection).cgColor }
        if let locations, locations.count == colors.count {
            gradientLayer.locations = locations.map { NSNumber(value: Double($0)) }
        } else {
            gradientLayer.locations = nil
        }
        gradientLayer.startPoint = startPoint
        gradientLayer.endPoint = endPoint
        if existingLayer == nil {
            layer.insertSublayer(gradientLayer, at: 0)
        }
        return gradientLayer
    }
}
#endif
