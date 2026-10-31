// NSView+SetLayerBorderColor.swift - Copyright 2026 SwifterSwift

#if canImport(AppKit) && !targetEnvironment(macCatalyst)
import AppKit
import Foundation
import QuartzCore

public extension NSView {
    /// SwifterSwift: Sets the color of the layer's border, and keeps it up to date when the appearance changes.
    ///
    /// `CALayer` takes a `CGColor`, so `layer?.borderColor = color.cgColor` freezes a dynamic color such as
    /// `NSColor.separatorColor` in whatever appearance is current at that moment. This method sets `wantsLayer` to
    /// `true`, resolves the color with the view's `effectiveAppearance`, and resolves it again each time
    /// `effectiveAppearance` changes: when the system switches between light and dark mode, when the view or one of its
    /// ancestors gets a different `appearance`, or when the view moves to a window with a different appearance. It
    /// observes `effectiveAppearance` with key-value observing.
    ///
    /// Calling the method again replaces the color and the observation, so observations don't pile up. Pass `nil` to
    /// set `layer.borderColor` to `nil`, which draws no border, and to stop following appearance changes; that doesn't
    /// change `wantsLayer`. While a color is set, a value you assign to `layer.borderColor` yourself is overwritten at
    /// the next appearance change. The observation is kept on the view's layer, under a key-value coding key of its
    /// own, so it ends with that layer, for example when you turn `wantsLayer` off.
    ///
    /// The border is only drawn while `layer.borderWidth` is greater than `0`. The name keeps clear of
    /// `NSBox.borderColor`, which draws a border of its own.
    ///
    /// ```swift
    /// let cardView = NSView()
    /// cardView.setLayerBorderColor(.separatorColor)
    /// cardView.layer?.borderWidth = 1
    /// cardView.appearance = NSAppearance(named: .darkAqua)  // The border switches to the dark variant.
    /// ```
    ///
    /// - Parameter color: The color of the border, or `nil` to remove it.
    func setLayerBorderColor(_ color: NSColor?) {
        let observationKey = "SwifterSwiftLayerBorderColorObservation"
        if color != nil {
            wantsLayer = true
        }
        guard let layer else {
            return
        }
        (layer.value(forKey: observationKey) as? NSKeyValueObservation)?.invalidate()
        guard let color else {
            layer.setValue(nil, forKey: observationKey)
            layer.borderColor = nil
            return
        }
        effectiveAppearance.performAsCurrentDrawingAppearance {
            layer.borderColor = color.cgColor
        }
        let observation = observe(\.effectiveAppearance) { view, _ in
            MainActor.assumeIsolated {
                view.effectiveAppearance.performAsCurrentDrawingAppearance {
                    view.layer?.borderColor = color.cgColor
                }
            }
        }
        layer.setValue(observation, forKey: observationKey)
    }
}
#endif
