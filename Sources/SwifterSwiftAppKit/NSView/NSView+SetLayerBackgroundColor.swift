// NSView+SetLayerBackgroundColor.swift - Copyright 2026 SwifterSwift

#if canImport(AppKit) && !targetEnvironment(macCatalyst)
import AppKit
import Foundation
import QuartzCore

public extension NSView {
    /// SwifterSwift: Fills the view's layer with a color, and keeps it up to date when the appearance changes.
    ///
    /// `NSView` has no background color of its own, and the usual workaround, `layer?.backgroundColor = color.cgColor`,
    /// freezes a dynamic color such as `NSColor.windowBackgroundColor` in whatever appearance is current at that
    /// moment. This method sets `wantsLayer` to `true`, resolves the color with the view's `effectiveAppearance`, and
    /// resolves it again each time `effectiveAppearance` changes: when the system switches between light and dark mode,
    /// when the view or one of its ancestors gets a different `appearance`, or when the view moves to a window with a
    /// different appearance. It observes `effectiveAppearance` with key-value observing.
    ///
    /// Calling the method again replaces the color and the observation, so observations don't pile up. Pass `nil` to
    /// set `layer.backgroundColor` to `nil` and to stop following appearance changes; that doesn't change
    /// `wantsLayer`. While a color is set, a value you assign to `layer.backgroundColor` yourself is overwritten at the
    /// next appearance change. The observation is kept on the view's layer, under a key-value coding key of its own, so
    /// it ends with that layer, for example when you turn `wantsLayer` off.
    ///
    /// The name keeps clear of the `backgroundColor` properties of `NSTextField`, `NSScrollView`, `NSClipView`,
    /// `NSTableView` and `NSBox`, which draw backgrounds of their own and are the better choice on those views.
    ///
    /// ```swift
    /// let headerView = NSView()
    /// headerView.setLayerBackgroundColor(.windowBackgroundColor)
    /// headerView.wantsLayer  // true
    /// headerView.appearance = NSAppearance(named: .darkAqua)  // The layer switches to the dark variant.
    /// ```
    ///
    /// - Parameter color: The background color, or `nil` to remove it.
    func setLayerBackgroundColor(_ color: NSColor?) {
        let observationKey = "SwifterSwiftLayerBackgroundColorObservation"
        if color != nil {
            wantsLayer = true
        }
        guard let layer else {
            return
        }
        (layer.value(forKey: observationKey) as? NSKeyValueObservation)?.invalidate()
        guard let color else {
            layer.setValue(nil, forKey: observationKey)
            layer.backgroundColor = nil
            return
        }
        effectiveAppearance.performAsCurrentDrawingAppearance {
            layer.backgroundColor = color.cgColor
        }
        let observation = observe(\.effectiveAppearance) { view, _ in
            MainActor.assumeIsolated {
                view.effectiveAppearance.performAsCurrentDrawingAppearance {
                    view.layer?.backgroundColor = color.cgColor
                }
            }
        }
        layer.setValue(observation, forKey: observationKey)
    }
}
#endif
