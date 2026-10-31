// UIView+SetLayerBorderColorTests.swift - Copyright 2026 SwifterSwift

#if canImport(UIKit) && !os(watchOS)
import CoreGraphics
import QuartzCore
import SwifterSwiftUIKit
import Testing
import UIKit

@MainActor
struct UIViewSetLayerBorderColorTests {
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
        view.setLayerBorderColor(dynamicColor)
        #expect(view.layer.borderColor == UIColor.white.cgColor)
    }

    @Test
    func setsStaticColors() {
        let view = UIView()
        let color = UIColor(red: 0.2, green: 0.4, blue: 0.6, alpha: 0.5)
        view.setLayerBorderColor(color)
        #expect(view.layer.borderColor == color.cgColor)
    }

    @Test
    func followsInterfaceStyleChanges() {
        let view = UIView()
        setStyle(.light, of: view)
        view.setLayerBorderColor(dynamicColor)
        #expect(view.layer.borderColor == UIColor.black.cgColor)
        setStyle(.dark, of: view)
        #expect(view.layer.borderColor == UIColor.white.cgColor)
        setStyle(.light, of: view)
        #expect(view.layer.borderColor == UIColor.black.cgColor)
    }

    @Test
    func followsTraitsInheritedFromTheSuperview() {
        let superview = UIView()
        let view = UIView()
        superview.addSubview(view)
        setStyle(.light, of: superview)
        view.setLayerBorderColor(dynamicColor)
        #expect(view.layer.borderColor == UIColor.black.cgColor)
        setStyle(.dark, of: superview)
        view.updateTraitsIfNeeded()
        #expect(view.layer.borderColor == UIColor.white.cgColor)
    }

    @Test
    func followsContrastChanges() {
        let view = UIView()
        let color = UIColor { $0.accessibilityContrast == .high ? .red : .blue }
        view.traitOverrides.accessibilityContrast = .normal
        view.updateTraitsIfNeeded()
        view.setLayerBorderColor(color)
        #expect(view.layer.borderColor == UIColor.blue.cgColor)
        view.traitOverrides.accessibilityContrast = .high
        view.updateTraitsIfNeeded()
        #expect(view.layer.borderColor == UIColor.red.cgColor)
    }

    @Test
    func resolvesSystemColorsLikeUIKit() {
        let view = UIView()
        for style in [UIUserInterfaceStyle.dark, .light] {
            setStyle(style, of: view)
            view.setLayerBorderColor(.separator)
            #expect(view.layer.borderColor == UIColor.separator.resolvedColor(with: view.traitCollection).cgColor)
        }
    }

    @Test
    func followsTheLatestColor() {
        let view = UIView()
        setStyle(.light, of: view)
        view.setLayerBorderColor(dynamicColor)
        view.setLayerBorderColor(UIColor { $0.userInterfaceStyle == .dark ? .green : .red })
        #expect(view.layer.borderColor == UIColor.red.cgColor)
        setStyle(.dark, of: view)
        #expect(view.layer.borderColor == UIColor.green.cgColor)
    }

    @Test
    func removesTheColorAndStopsFollowingTraitsWithNil() {
        let view = UIView()
        setStyle(.light, of: view)
        view.setLayerBorderColor(dynamicColor)
        view.setLayerBorderColor(nil)
        #expect(view.layer.borderColor == nil)
        view.layer.borderColor = UIColor.red.cgColor
        setStyle(.dark, of: view)
        #expect(view.layer.borderColor == UIColor.red.cgColor)
    }

    @Test
    func doesNotStackRegistrations() {
        let view = UIView()
        setStyle(.light, of: view)
        for _ in 0..<3 {
            view.setLayerBorderColor(dynamicColor)
        }
        view.setLayerBorderColor(.blue)
        view.setLayerBorderColor(nil)
        view.layer.borderColor = UIColor.red.cgColor
        setStyle(.dark, of: view)
        setStyle(.light, of: view)
        #expect(view.layer.borderColor == UIColor.red.cgColor)
    }

    @Test
    func removesTheColorOfAViewWithoutOne() {
        let view = UIView()
        view.setLayerBorderColor(nil)
        #expect(view.layer.borderColor == nil)
    }

    @Test
    func leavesTheRestOfTheLayerAlone() {
        let view = UIView()
        view.layer.borderWidth = 2
        view.layer.shadowColor = UIColor.green.cgColor
        view.setLayerBorderColor(dynamicColor)
        #expect(view.layer.borderWidth == 2)
        #expect(view.layer.shadowColor == UIColor.green.cgColor)
        #expect(view.layer.mask == nil)
    }

    @Test
    func doesNotRetainTheView() {
        weak var weakView: UIView?
        autoreleasepool {
            let view = UIView()
            view.setLayerBorderColor(dynamicColor)
            weakView = view
        }
        #expect(weakView == nil)
    }
}
#endif
