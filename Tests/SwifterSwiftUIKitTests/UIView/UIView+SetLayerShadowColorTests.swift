// UIView+SetLayerShadowColorTests.swift - Copyright 2026 SwifterSwift

#if canImport(UIKit) && !os(watchOS)
import CoreGraphics
import QuartzCore
import SwifterSwiftUIKit
import Testing
import UIKit

@MainActor
struct UIViewSetLayerShadowColorTests {
    /// Black in light mode and white in dark mode.
    let dynamicColor = UIColor { $0.userInterfaceStyle == .dark ? .white : .black }

    /// Overrides the interface style of the view and applies the change right away.
    func setStyle(_ style: UIUserInterfaceStyle, of view: UIView) {
        view.traitOverrides.userInterfaceStyle = style
        view.updateTraitsIfNeeded()
    }

    @Test
    func resolvesTheColorWithTheViewsTraits() {
        let view = UIView()
        setStyle(.dark, of: view)
        view.setLayerShadowColor(dynamicColor)
        #expect(view.layer.shadowColor == UIColor.white.cgColor)
    }

    @Test
    func setsStaticColors() {
        let view = UIView()
        let color = UIColor(red: 0.2, green: 0.4, blue: 0.6, alpha: 0.5)
        view.setLayerShadowColor(color)
        #expect(view.layer.shadowColor == color.cgColor)
    }

    @Test
    func followsInterfaceStyleChanges() {
        let view = UIView()
        setStyle(.light, of: view)
        view.setLayerShadowColor(dynamicColor)
        #expect(view.layer.shadowColor == UIColor.black.cgColor)
        setStyle(.dark, of: view)
        #expect(view.layer.shadowColor == UIColor.white.cgColor)
        setStyle(.light, of: view)
        #expect(view.layer.shadowColor == UIColor.black.cgColor)
    }

    @Test
    func followsTraitsInheritedFromTheSuperview() {
        let superview = UIView()
        let view = UIView()
        superview.addSubview(view)
        setStyle(.light, of: superview)
        view.setLayerShadowColor(dynamicColor)
        #expect(view.layer.shadowColor == UIColor.black.cgColor)
        setStyle(.dark, of: superview)
        view.updateTraitsIfNeeded()
        #expect(view.layer.shadowColor == UIColor.white.cgColor)
    }

    @Test
    func resolvesSystemColorsLikeUIKit() {
        let view = UIView()
        for style in [UIUserInterfaceStyle.dark, .light] {
            setStyle(style, of: view)
            view.setLayerShadowColor(.label)
            #expect(view.layer.shadowColor == UIColor.label.resolvedColor(with: view.traitCollection).cgColor)
        }
    }

    @Test
    func followsTheLatestColor() {
        let view = UIView()
        setStyle(.light, of: view)
        view.setLayerShadowColor(dynamicColor)
        view.setLayerShadowColor(UIColor { $0.userInterfaceStyle == .dark ? .green : .red })
        #expect(view.layer.shadowColor == UIColor.red.cgColor)
        setStyle(.dark, of: view)
        #expect(view.layer.shadowColor == UIColor.green.cgColor)
    }

    @Test
    func removesTheColorAndStopsFollowingTraitsWithNil() {
        let view = UIView()
        setStyle(.light, of: view)
        view.setLayerShadowColor(dynamicColor)
        view.setLayerShadowColor(nil)
        #expect(view.layer.shadowColor == nil)
        view.layer.shadowColor = UIColor.red.cgColor
        setStyle(.dark, of: view)
        #expect(view.layer.shadowColor == UIColor.red.cgColor)
    }

    @Test
    func doesNotStackRegistrations() {
        let view = UIView()
        setStyle(.light, of: view)
        for _ in 0..<3 {
            view.setLayerShadowColor(dynamicColor)
        }
        view.setLayerShadowColor(.blue)
        view.setLayerShadowColor(nil)
        view.layer.shadowColor = UIColor.red.cgColor
        setStyle(.dark, of: view)
        setStyle(.light, of: view)
        #expect(view.layer.shadowColor == UIColor.red.cgColor)
    }

    @Test
    func worksAlongsideTheBorderColor() {
        let view = UIView()
        setStyle(.light, of: view)
        view.setLayerShadowColor(dynamicColor)
        view.layer.borderColor = UIColor.red.cgColor
        setStyle(.dark, of: view)
        #expect(view.layer.shadowColor == UIColor.white.cgColor)
        #expect(view.layer.borderColor == UIColor.red.cgColor)
    }

    @Test
    func leavesTheRestOfTheShadowAlone() {
        let view = UIView()
        view.layer.shadowOpacity = 0.3
        view.layer.shadowRadius = 6
        view.layer.shadowOffset = CGSize(width: 0, height: 2)
        view.setLayerShadowColor(dynamicColor)
        #expect(view.layer.shadowOpacity == 0.3)
        #expect(view.layer.shadowRadius == 6)
        #expect(view.layer.shadowOffset == CGSize(width: 0, height: 2))
    }

    @Test
    func doesNotRetainTheView() {
        weak var weakView: UIView?
        autoreleasepool {
            let view = UIView()
            view.setLayerShadowColor(dynamicColor)
            weakView = view
        }
        #expect(weakView == nil)
    }
}
#endif
