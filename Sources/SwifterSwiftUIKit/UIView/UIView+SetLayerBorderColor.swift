// UIView+SetLayerBorderColor.swift - Copyright 2026 SwifterSwift

#if canImport(UIKit) && !os(watchOS)
import QuartzCore
import UIKit

public extension UIView {
    /// SwifterSwift: Sets the color of the layer's border, and keeps it up to date when the appearance changes.
    ///
    /// `CALayer` takes a `CGColor`, which can't change with the appearance, so `layer.borderColor = color.cgColor`
    /// freezes a dynamic color such as `UIColor.separator` in whatever appearance is current at that moment. This
    /// method resolves the color with the view's `traitCollection`, and resolves it again each time one of
    /// `UITraitCollection.systemTraitsAffectingColorAppearance` changes, for example when the view switches to dark
    /// mode or Increase Contrast is turned on. It uses `registerForTraitChanges(_:handler:)`.
    ///
    /// Calling the method again replaces the color and the trait registration, so registrations don't pile up. Pass
    /// `nil` to set `layer.borderColor` to `nil`, which draws no border, and to stop following trait changes. While a
    /// color is set, a value you assign to `layer.borderColor` yourself is overwritten at the next trait change. The
    /// registration is kept on the view's layer, under a key-value coding key of its own.
    ///
    /// The border is only drawn while `layer.borderWidth` is greater than `0`.
    ///
    /// ```swift
    /// cardView.layer.borderWidth = 1
    /// cardView.setLayerBorderColor(.separator)
    /// cardView.overrideUserInterfaceStyle = .dark  // The border switches to the dark variant of .separator.
    /// cardView.setLayerBorderColor(nil)
    /// cardView.layer.borderColor  // nil
    /// ```
    ///
    /// - Parameter color: The color of the border, or `nil` to remove it.
    func setLayerBorderColor(_ color: UIColor?) {
        let registrationKey = "SwifterSwiftLayerBorderColorRegistration"
        if let registration = layer.value(forKey: registrationKey) as? any UITraitChangeRegistration {
            unregisterForTraitChanges(registration)
        }
        guard let color else {
            layer.setValue(nil, forKey: registrationKey)
            layer.borderColor = nil
            return
        }
        layer.borderColor = color.resolvedColor(with: traitCollection).cgColor
        let registration = registerForTraitChanges(UITraitCollection.systemTraitsAffectingColorAppearance) {
            (view: UIView, _: UITraitCollection) in
            view.layer.borderColor = color.resolvedColor(with: view.traitCollection).cgColor
        }
        layer.setValue(registration, forKey: registrationKey)
    }
}
#endif
