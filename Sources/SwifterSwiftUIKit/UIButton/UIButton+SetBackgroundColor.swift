// UIButton+SetBackgroundColor.swift - Copyright 2026 SwifterSwift

#if canImport(UIKit) && !os(watchOS)
import CoreGraphics
import UIKit

public extension UIButton {
    /// SwifterSwift: Sets the background of the button to a solid color for the given state.
    ///
    /// `UIButton` has per-state background images but no per-state background color. This method draws the color into
    /// a 1×1 image and passes it to `setBackgroundImage(_:for:)`, and the button stretches that image to fill its
    /// bounds. A translucent color keeps its alpha. A dynamic color is resolved with the button's current trait
    /// collection, so call the method again when the appearance changes.
    ///
    /// Buttons that have a `configuration` ignore background images, so the color has no effect on them; use
    /// `configuration?.background.backgroundColor` and a `configurationUpdateHandler` instead. The method doesn't
    /// change `clipsToBounds`, so the color isn't clipped to `layer.cornerRadius` unless you turn it on.
    ///
    /// ```swift
    /// let button = UIButton(type: .custom)
    /// button.setBackgroundColor(.systemBlue, for: .normal)
    /// button.setBackgroundColor(.systemBlue.withAlphaComponent(0.5), for: .highlighted)
    /// button.backgroundImage(for: .highlighted)?.size  // (1.0, 1.0)
    /// ```
    ///
    /// - Parameters:
    ///   - color: The background color to use for the state.
    ///   - state: The state that uses the color.
    func setBackgroundColor(_ color: UIColor, for state: UIControl.State) {
        let resolvedColor = color.resolvedColor(with: traitCollection)
        let format = UIGraphicsImageRendererFormat(for: traitCollection)
        format.scale = 1
        format.opaque = false
        let bounds = CGRect(x: 0, y: 0, width: 1, height: 1)
        let image = UIGraphicsImageRenderer(bounds: bounds, format: format).image { context in
            resolvedColor.setFill()
            context.fill(bounds)
        }
        setBackgroundImage(image, for: state)
    }
}
#endif
