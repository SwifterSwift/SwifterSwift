// NSView+SetLayerBackgroundColorTests.swift - Copyright 2026 SwifterSwift

#if canImport(AppKit) && !targetEnvironment(macCatalyst)
import AppKit
import CoreGraphics
import QuartzCore
import SwifterSwiftAppKit
import Testing

@MainActor
struct NSViewSetLayerBackgroundColorTests {
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
        view.setLayerBackgroundColor(.red)
        #expect(view.wantsLayer)
        #expect(view.layer != nil)
    }

    @Test
    func setsStaticColors() {
        let view = NSView()
        let color = NSColor(srgbRed: 0.2, green: 0.4, blue: 0.6, alpha: 0.5)
        view.setLayerBackgroundColor(color)
        #expect(view.layer?.backgroundColor == color.cgColor)
    }

    @Test
    func resolvesTheColorWithTheEffectiveAppearance() {
        let view = NSView()
        view.appearance = darkAqua
        view.setLayerBackgroundColor(dynamicColor)
        #expect(view.layer?.backgroundColor == Self.darkColor.cgColor)
    }

    @Test
    func followsAppearanceChangesOfTheView() {
        let view = NSView()
        view.appearance = aqua
        view.setLayerBackgroundColor(dynamicColor)
        #expect(view.layer?.backgroundColor == Self.lightColor.cgColor)
        view.appearance = darkAqua
        #expect(view.layer?.backgroundColor == Self.darkColor.cgColor)
        view.appearance = aqua
        #expect(view.layer?.backgroundColor == Self.lightColor.cgColor)
    }

    @Test
    func followsAppearanceChangesOfAnAncestor() {
        let grandparent = NSView()
        let parent = NSView()
        let view = NSView()
        grandparent.addSubview(parent)
        parent.addSubview(view)
        grandparent.appearance = aqua
        view.setLayerBackgroundColor(dynamicColor)
        #expect(view.layer?.backgroundColor == Self.lightColor.cgColor)
        grandparent.appearance = darkAqua
        #expect(view.layer?.backgroundColor == Self.darkColor.cgColor)
    }

    @Test
    func followsMovesToAnotherAppearance() {
        let lightContainer = NSView()
        lightContainer.appearance = aqua
        let darkContainer = NSView()
        darkContainer.appearance = darkAqua
        let view = NSView()
        lightContainer.addSubview(view)
        view.setLayerBackgroundColor(dynamicColor)
        #expect(view.layer?.backgroundColor == Self.lightColor.cgColor)
        darkContainer.addSubview(view)
        #expect(view.layer?.backgroundColor == Self.darkColor.cgColor)
    }

    @Test
    func followsTheAppearanceOfTheWindow() throws {
        let window = NSWindow(
            contentRect: NSRect(x: 0, y: 0, width: 100, height: 100),
            styleMask: [.titled],
            backing: .buffered,
            defer: true
        )
        window.isReleasedWhenClosed = false
        window.appearance = aqua
        let view = NSView()
        try #require(window.contentView).addSubview(view)
        view.setLayerBackgroundColor(dynamicColor)
        #expect(view.layer?.backgroundColor == Self.lightColor.cgColor)
        window.appearance = darkAqua
        #expect(view.layer?.backgroundColor == Self.darkColor.cgColor)
    }

    @Test(arguments: [
        NSAppearance.Name.aqua, .darkAqua, .accessibilityHighContrastAqua, .accessibilityHighContrastDarkAqua
    ])
    func resolvesSystemColorsLikeAppKit(_ name: NSAppearance.Name) throws {
        let appearance = try #require(NSAppearance(named: name))
        let view = NSView()
        view.appearance = appearance
        view.setLayerBackgroundColor(.windowBackgroundColor)
        var expected: CGColor?
        appearance.performAsCurrentDrawingAppearance {
            expected = NSColor.windowBackgroundColor.cgColor
        }
        #expect(view.layer?.backgroundColor == expected)
    }

    @Test
    func followsTheLatestColor() {
        let view = NSView()
        view.appearance = aqua
        view.setLayerBackgroundColor(dynamicColor)
        let green = NSColor(srgbRed: 0, green: 1, blue: 0, alpha: 1)
        let gray = NSColor(srgbRed: 0.5, green: 0.5, blue: 0.5, alpha: 1)
        view.setLayerBackgroundColor(
            NSColor(name: nil) { $0.bestMatch(from: [.aqua, .darkAqua]) == .darkAqua ? green : gray })
        #expect(view.layer?.backgroundColor == gray.cgColor)
        view.appearance = darkAqua
        #expect(view.layer?.backgroundColor == green.cgColor)
    }

    @Test
    func removesTheColorAndStopsFollowingAppearanceWithNil() {
        let view = NSView()
        view.appearance = aqua
        view.setLayerBackgroundColor(dynamicColor)
        view.setLayerBackgroundColor(nil)
        #expect(view.layer?.backgroundColor == nil)
        #expect(view.wantsLayer)
        let manualColor = NSColor(srgbRed: 0, green: 1, blue: 0, alpha: 1).cgColor
        view.layer?.backgroundColor = manualColor
        view.appearance = darkAqua
        #expect(view.layer?.backgroundColor == manualColor)
    }

    @Test
    func doesNotStackObservations() {
        let view = NSView()
        view.appearance = aqua
        for _ in 0..<3 {
            view.setLayerBackgroundColor(dynamicColor)
        }
        view.setLayerBackgroundColor(.blue)
        view.setLayerBackgroundColor(nil)
        let manualColor = NSColor(srgbRed: 0, green: 1, blue: 0, alpha: 1).cgColor
        view.layer?.backgroundColor = manualColor
        view.appearance = darkAqua
        view.appearance = aqua
        #expect(view.layer?.backgroundColor == manualColor)
    }

    @Test
    func doesNotAddALayerToRemoveAColor() {
        let view = NSView()
        view.setLayerBackgroundColor(nil)
        #expect(!view.wantsLayer)
        #expect(view.layer == nil)
    }

    @Test
    func leavesTheRestOfTheLayerAlone() {
        let view = NSView()
        view.wantsLayer = true
        view.layer?.borderWidth = 2
        view.layer?.cornerRadius = 4
        view.setLayerBackgroundColor(dynamicColor)
        #expect(view.layer?.borderWidth == 2)
        #expect(view.layer?.cornerRadius == 4)
    }

    @Test
    func doesNotRetainTheView() {
        weak var weakView: NSView?
        autoreleasepool {
            let view = NSView()
            view.appearance = aqua
            view.setLayerBackgroundColor(dynamicColor)
            weakView = view
        }
        #expect(weakView == nil)
    }
}
#endif
