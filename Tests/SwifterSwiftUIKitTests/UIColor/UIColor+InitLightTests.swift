// UIColor+InitLightTests.swift - Copyright 2026 SwifterSwift

#if canImport(UIKit) && !os(watchOS)
import SwifterSwiftUIKit
import Testing
import UIKit

@MainActor
struct UIColorInitLightTests {
    @Test(arguments: [
        (UIUserInterfaceStyle.light, UIColor.red),
        (.dark, .blue),
        (.unspecified, .red)
    ])
    func picksTheColorForTheInterfaceStyle(_ style: UIUserInterfaceStyle, expected: UIColor) {
        let color = UIColor(light: .red, dark: .blue)
        #expect(color.resolvedColor(with: UITraitCollection(userInterfaceStyle: style)) == expected)
    }

    @Test
    func resolvesWithTheCurrentTraits() {
        let color = UIColor(light: .red, dark: .blue)
        var resolved: UIColor?
        UITraitCollection(userInterfaceStyle: .dark).performAsCurrent { resolved = color.resolvedColor(with: .current) }
        #expect(resolved == .blue)
    }

    @Test
    func resolvesNestedDynamicColorsWithTheSameTraits() {
        let color = UIColor(light: .systemBlue, dark: .label)
        let lightHighContrast = UITraitCollection {
            $0.userInterfaceStyle = .light
            $0.accessibilityContrast = .high
        }
        let darkElevated = UITraitCollection {
            $0.userInterfaceStyle = .dark
            #if !os(tvOS)
            $0.userInterfaceLevel = .elevated
            #endif
        }
        let highContrastBlue = UIColor.systemBlue.resolvedColor(with: lightHighContrast)
        let standardBlue = UIColor.systemBlue.resolvedColor(with: UITraitCollection(userInterfaceStyle: .light))
        #expect(color.resolvedColor(with: lightHighContrast) == highContrastBlue)
        #expect(highContrastBlue != standardBlue)
        #expect(color.resolvedColor(with: darkElevated) == UIColor.label.resolvedColor(with: darkElevated))
    }

    @Test
    func keepsTheAlphaOfEachColor() {
        let color = UIColor(light: .white, dark: UIColor.black.withAlphaComponent(0.25))
        let dark = color.resolvedColor(with: UITraitCollection(userInterfaceStyle: .dark))
        #expect(dark.cgColor.alpha == 0.25)
    }
}
#endif
