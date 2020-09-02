// NSColorExtensions.swift - Copyright 2020 SwifterSwift

#if canImport(AppKit) && !targetEnvironment(macCatalyst)
import AppKit

public extension NSColor {
    /// SwifterSwift: Create an NSColor with different colors for light and dark mode.
    ///
    /// - Parameters:
    ///     - light: Color to use in light/unspecified mode.
    ///     - dark: Color to use in dark mode.
    @available(OSX 10.15, *)
    convenience init(light: NSColor, dark: NSColor) {
        self.init(name: nil, dynamicProvider: { $0.name == .darkAqua ? dark : light })
    }
}

#endif
