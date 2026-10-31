// NSView+SetLayerBorderColorTests.swift - Copyright 2026 SwifterSwift

#if canImport(AppKit) && !targetEnvironment(macCatalyst)
import AppKit
import CoreGraphics
import QuartzCore
import SwifterSwiftAppKit
import Testing

@MainActor
struct NSViewSetLayerBorderColorTests {
    static let lightColor = NSColor(srgbRed: 0, green: 0, blue: 1, alpha: 1)
    static let darkColor = NSColor(srgbRed: 1, green: 0, blue: 0, alpha: 1)

    /// Blue (`lightColor`) in light appearances and red (`darkColor`) in dark ones.
    let dynamicColor = NSColor(name: nil) { appearance in
        appearance.bestMatch(from: [.aqua, .darkAqua]) == .darkAqua
            ? NSColor(srgbRed: 1, green: 0, blue: 0, alpha: 1) : NSColor(srgbRed: 0, green: 0, blue: 1, alpha: 1)
    }

    let aqua = NSAppearance(named: .aqua)
    let darkAqua = NSAppearance(named: .darkAqua)

    @Test
    func makesTheViewLayerBacked() {
        let view = NSView()
        #expect(!view.wantsLayer)
        view.setLayerBorderColor(.red)
        #expect(view.wantsLayer)
        #expect(view.layer != nil)
    }

    @Test
    func setsStaticColors() {
        let view = NSView()
        let color = NSColor(srgbRed: 0.2, green: 0.4, blue: 0.6, alpha: 0.5)
        view.setLayerBorderColor(color)
        #expect(view.layer?.borderColor == color.cgColor)
    }

    @Test
    func resolvesTheColorWithTheEffectiveAppearance() {
        let view = NSView()
        view.appearance = darkAqua
        view.setLayerBorderColor(dynamicColor)
        #expect(view.layer?.borderColor == Self.darkColor.cgColor)
    }

    @Test
    func followsAppearanceChangesOfTheView() {
        let view = NSView()
        view.appearance = aqua
        view.setLayerBorderColor(dynamicColor)
        #expect(view.layer?.borderColor == Self.lightColor.cgColor)
        view.appearance = darkAqua
        #expect(view.layer?.borderColor == Self.darkColor.cgColor)
        view.appearance = aqua
        #expect(view.layer?.borderColor == Self.lightColor.cgColor)
    }

    @Test
    func followsAppearanceChangesOfAnAncestor() {
        let grandparent = NSView()
        let parent = NSView()
        let view = NSView()
        grandparent.addSubview(parent)
        parent.addSubview(view)
        grandparent.appearance = aqua
        view.setLayerBorderColor(dynamicColor)
        #expect(view.layer?.borderColor == Self.lightColor.cgColor)
        grandparent.appearance = darkAqua
        #expect(view.layer?.borderColor == Self.darkColor.cgColor)
    }

    @Test
    func followsMovesToAnotherAppearance() {
        let lightContainer = NSView()
        lightContainer.appearance = aqua
        let darkContainer = NSView()
        darkContainer.appearance = darkAqua
        let view = NSView()
        lightContainer.addSubview(view)
        view.setLayerBorderColor(dynamicColor)
        #expect(view.layer?.borderColor == Self.lightColor.cgColor)
        darkContainer.addSubview(view)
        #expect(view.layer?.borderColor == Self.darkColor.cgColor)
    }

    @Test(arguments: [
        NSAppearance.Name.aqua, .darkAqua, .accessibilityHighContrastAqua, .accessibilityHighContrastDarkAqua
    ])
    func resolvesSystemColorsLikeAppKit(_ name: NSAppearance.Name) throws {
        let appearance = try #require(NSAppearance(named: name))
        let view = NSView()
        view.appearance = appearance
        view.setLayerBorderColor(.separatorColor)
        var expected: CGColor?
        appearance.performAsCurrentDrawingAppearance {
            expected = NSColor.separatorColor.cgColor
        }
        #expect(view.layer?.borderColor == expected)
    }

    @Test
    func removesTheColorAndStopsFollowingAppearanceWithNil() {
        let view = NSView()
        view.appearance = aqua
        view.setLayerBorderColor(dynamicColor)
        view.setLayerBorderColor(nil)
        #expect(view.layer?.borderColor == nil)
        #expect(view.wantsLayer)
        let manualColor = NSColor(srgbRed: 0, green: 1, blue: 0, alpha: 1).cgColor
        view.layer?.borderColor = manualColor
        view.appearance = darkAqua
        #expect(view.layer?.borderColor == manualColor)
    }

    @Test
    func doesNotStackObservations() {
        let view = NSView()
        view.appearance = aqua
        for _ in 0..<3 {
            view.setLayerBorderColor(dynamicColor)
        }
        view.setLayerBorderColor(.blue)
        view.setLayerBorderColor(nil)
        let manualColor = NSColor(srgbRed: 0, green: 1, blue: 0, alpha: 1).cgColor
        view.layer?.borderColor = manualColor
        view.appearance = darkAqua
        view.appearance = aqua
        #expect(view.layer?.borderColor == manualColor)
    }

    @Test
    func worksAlongsideTheBackgroundColor() {
        let view = NSView()
        view.appearance = aqua
        view.setLayerBorderColor(dynamicColor)
        let backgroundColor = NSColor(srgbRed: 0, green: 1, blue: 0, alpha: 1).cgColor
        view.layer?.backgroundColor = backgroundColor
        view.appearance = darkAqua
        #expect(view.layer?.borderColor == Self.darkColor.cgColor)
        #expect(view.layer?.backgroundColor == backgroundColor)
    }

    @Test
    func doesNotAddALayerToRemoveAColor() {
        let view = NSView()
        view.setLayerBorderColor(nil)
        #expect(!view.wantsLayer)
        #expect(view.layer == nil)
    }

    @Test
    func leavesTheBorderWidthAlone() {
        let view = NSView()
        view.wantsLayer = true
        view.layer?.borderWidth = 2
        view.setLayerBorderColor(dynamicColor)
        #expect(view.layer?.borderWidth == 2)
    }

    @Test
    func doesNotRetainTheView() {
        weak var weakView: NSView?
        autoreleasepool {
            let view = NSView()
            view.appearance = aqua
            view.setLayerBorderColor(dynamicColor)
            weakView = view
        }
        #expect(weakView == nil)
    }
}
#endif
