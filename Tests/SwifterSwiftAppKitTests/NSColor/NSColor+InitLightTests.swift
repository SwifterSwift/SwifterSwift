// NSColor+InitLightTests.swift - Copyright 2026 SwifterSwift

#if canImport(AppKit) && !targetEnvironment(macCatalyst)
import AppKit
import SwifterSwiftAppKit
import Testing

@MainActor
struct NSColorInitLightTests {
    @Test(arguments: [
        (NSAppearance.Name.aqua, false),
        (.darkAqua, true),
        (.vibrantLight, false),
        (.vibrantDark, true),
        (.accessibilityHighContrastAqua, false),
        (.accessibilityHighContrastDarkAqua, true),
        (.accessibilityHighContrastVibrantLight, false),
        (.accessibilityHighContrastVibrantDark, true)
    ])
    func picksTheColorForTheAppearance(_ name: NSAppearance.Name, isDark: Bool) throws {
        let appearance = try #require(NSAppearance(named: name))
        let color = NSColor(light: .red, dark: .blue)
        var resolved: NSColor?
        appearance.performAsCurrentDrawingAppearance { resolved = color.usingColorSpace(.sRGB) }
        let components = try #require(resolved)
        #expect(components.redComponent == (isDark ? 0 : 1))
        #expect(components.blueComponent == (isDark ? 1 : 0))
    }

    @Test
    func resolvesNestedDynamicColors() throws {
        let light = try #require(NSAppearance(named: .aqua))
        let dark = try #require(NSAppearance(named: .darkAqua))
        let color = NSColor(light: .textColor, dark: .textBackgroundColor)
        var lightRed: CGFloat?
        var darkRed: CGFloat?
        light.performAsCurrentDrawingAppearance { lightRed = color.usingColorSpace(.sRGB)?.redComponent }
        dark.performAsCurrentDrawingAppearance { darkRed = color.usingColorSpace(.sRGB)?.redComponent }
        // `textColor` is black in light mode, and `textBackgroundColor` is near black in dark mode.
        #expect(lightRed == 0)
        #expect(try #require(darkRed) < 0.5)
    }

    @Test
    func keepsTheAlphaOfEachColor() throws {
        let dark = try #require(NSAppearance(named: .darkAqua))
        let color = NSColor(light: .white, dark: NSColor.black.withAlphaComponent(0.25))
        var alpha: CGFloat?
        dark.performAsCurrentDrawingAppearance { alpha = color.usingColorSpace(.sRGB)?.alphaComponent }
        #expect(alpha == 0.25)
    }
}
#endif
