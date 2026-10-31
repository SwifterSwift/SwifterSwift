// UIView+SetLayerShadowColor.swift - Copyright 2026 SwifterSwift

#if canImport(UIKit) && !os(watchOS)
import QuartzCore
import UIKit

public extension UIView {
    /// SwifterSwift: Sets the color of the layer's shadow, and keeps it up to date when the appearance changes.
    ///
    /// `CALayer` takes a `CGColor`, which can't change with the appearance, so `layer.shadowColor = color.cgColor`
    /// freezes a dynamic color in whatever appearance is current at that moment, and a card's shadow keeps its light
    /// mode color in dark mode. This method resolves the color with the view's `traitCollection`, and resolves it
    /// again each time one of `UITraitCollection.systemTraitsAffectingColorAppearance` changes, for example when the
    /// view switches to dark mode or Increase Contrast is turned on. It uses `registerForTraitChanges(_:handler:)`.
    ///
    /// Calling the method again replaces the color and the trait registration, so registrations don't pile up. Pass
    /// `nil` to set `layer.shadowColor` to `nil`, which draws no shadow, and to stop following trait changes. While a
    /// color is set, a value you assign to `layer.shadowColor` yourself is overwritten at the next trait change. The
    /// registration is kept on the view's layer, under a key-value coding key of its own.
    ///
    /// The shadow is only drawn while `layer.shadowOpacity` is greater than `0`, which isn't the default.
    ///
    /// ```swift
    /// let shadow = UIColor { $0.userInterfaceStyle == .dark ? .white : .black }
    /// cardView.layer.shadowOpacity = 0.2
    /// cardView.setLayerShadowColor(shadow)
    /// cardView.overrideUserInterfaceStyle = .dark  // The shadow turns white.
    /// cardView.setLayerShadowColor(nil)
    /// cardView.layer.shadowColor  // nil
    /// ```
    ///
    /// - Parameter color: The color of the shadow, or `nil` to remove it.
    func setLayerShadowColor(_ color: UIColor?) {
        let registrationKey = "SwifterSwiftLayerShadowColorRegistration"
        if let registration = layer.value(forKey: registrationKey) as? any UITraitChangeRegistration {
            unregisterForTraitChanges(registration)
        }
        guard let color else {
            layer.setValue(nil, forKey: registrationKey)
            layer.shadowColor = nil
            return
        }
        layer.shadowColor = color.resolvedColor(with: traitCollection).cgColor
        let registration = registerForTraitChanges(UITraitCollection.systemTraitsAffectingColorAppearance) {
            (view: UIView, _: UITraitCollection) in
            view.layer.shadowColor = color.resolvedColor(with: view.traitCollection).cgColor
        }
        layer.setValue(registration, forKey: registrationKey)
    }
}
#endif
