// NSColor+InitLight.swift - Copyright 2026 SwifterSwift

#if canImport(AppKit) && !targetEnvironment(macCatalyst)
import AppKit

public extension NSColor {
    /// SwifterSwift: Creates a dynamic color that uses one color in light appearances and another in dark appearances.
    ///
    /// AppKit resolves the color each time it's drawn, using the appearance in effect at that moment. The appearance is
    /// matched with `bestMatch(from: [.aqua, .darkAqua])`, so the dark color is also used for `.vibrantDark` and the
    /// high-contrast dark appearances, and the light color for `.vibrantLight` and the high-contrast light ones. Either
    /// color can itself be dynamic, such as `NSColor.labelColor`.
    ///
    /// ```swift
    /// let background = NSColor(light: .white, dark: NSColor(white: 0.1, alpha: 1))
    /// view.layer?.backgroundColor = background.cgColor  // resolved for the current drawing appearance
    /// ```
    ///
    /// - Parameters:
    ///   - light: The color to use in light appearances.
    ///   - dark: The color to use in dark appearances.
    convenience init(light: NSColor, dark: NSColor) {
        self.init(name: nil) { appearance in
            appearance.bestMatch(from: [.aqua, .darkAqua]) == .darkAqua ? dark : light
        }
    }
}
#endif
