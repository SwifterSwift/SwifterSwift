// UIView+AddShadow.swift - Copyright 2026 SwifterSwift

#if canImport(UIKit) && !os(watchOS)
import CoreGraphics
import QuartzCore
import UIKit

public extension UIView {
    /// SwifterSwift: Configures the shadow of the view's layer in a single call.
    ///
    /// The method sets the layer's shadow color, radius, offset, opacity and path, and turns off `masksToBounds`
    /// (`clipsToBounds`), because a layer that clips its content also clips its shadow.
    ///
    /// Without a `path`, Core Animation derives the shadow from the alpha of everything the layer draws, which needs an
    /// extra offscreen pass on every frame and draws no shadow for a view with a clear background and no content. Pass
    /// a path, such as `UIBezierPath(roundedRect: bounds, cornerRadius: layer.cornerRadius).cgPath`, to avoid that, and
    /// update it when the view's size changes.
    ///
    /// A dynamic color, such as `UIColor.label`, is resolved with the view's current trait collection, so it doesn't
    /// update by itself when the appearance changes. The opacity is clamped to `0...1`, and NaN counts as `0`.
    ///
    /// ```swift
    /// cardView.addShadow(ofColor: .black, radius: 8, offset: CGSize(width: 0, height: 4), opacity: 0.2)
    /// cardView.layer.shadowRadius  // 8.0
    /// cardView.layer.masksToBounds  // false
    /// ```
    ///
    /// - Parameters:
    ///   - color: The color of the shadow.
    ///   - radius: The blur radius of the shadow, in points.
    ///   - offset: The offset of the shadow, in points.
    ///   - opacity: The opacity of the shadow, from `0` (invisible) to `1` (opaque).
    ///   - path: The shape of the shadow, or `nil` to derive it from the layer's content.
    func addShadow(
        ofColor color: UIColor = .black,
        radius: CGFloat = 3,
        offset: CGSize = .zero,
        opacity: Float = 0.5,
        path: CGPath? = nil
    ) {
        layer.shadowColor = color.resolvedColor(with: traitCollection).cgColor
        layer.shadowRadius = radius
        layer.shadowOffset = offset
        layer.shadowOpacity = opacity.isNaN ? 0 : min(max(opacity, 0), 1)
        layer.shadowPath = path
        layer.masksToBounds = false
    }
}
#endif
