// UIView+AddShadowTests.swift - Copyright 2026 SwifterSwift

#if canImport(UIKit) && !os(watchOS)
import CoreGraphics
import QuartzCore
import SwifterSwiftUIKit
import Testing
import UIKit

@MainActor
struct UIViewAddShadowTests {
    @Test
    func setsAllShadowProperties() {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        view.addShadow(ofColor: .red, radius: 8, offset: CGSize(width: 0, height: 4), opacity: 0.2)
        #expect(view.layer.shadowColor == UIColor.red.cgColor)
        #expect(view.layer.shadowRadius == 8)
        #expect(view.layer.shadowOffset == CGSize(width: 0, height: 4))
        #expect(view.layer.shadowOpacity == 0.2)
        #expect(view.layer.shadowPath == nil)
        #expect(!view.layer.masksToBounds)
    }

    @Test
    func usesDefaults() {
        let view = UIView()
        view.addShadow()
        #expect(view.layer.shadowColor == UIColor.black.cgColor)
        #expect(view.layer.shadowRadius == 3)
        #expect(view.layer.shadowOffset == .zero)
        #expect(view.layer.shadowOpacity == 0.5)
    }

    @Test
    func setsAndClearsShadowPath() {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: 100, height: 50))
        let path = UIBezierPath(roundedRect: view.bounds, cornerRadius: 12).cgPath
        view.addShadow(path: path)
        #expect(view.layer.shadowPath == path)
        view.addShadow()
        #expect(view.layer.shadowPath == nil)
    }

    @Test
    func turnsOffClipping() {
        let view = UIView()
        view.clipsToBounds = true
        view.addShadow()
        #expect(!view.clipsToBounds)
        #expect(!view.layer.masksToBounds)
    }

    @Test(arguments: [
        (Float(-1), Float(0)),
        (0, 0),
        (0.75, 0.75),
        (1, 1),
        (2, 1),
        (.infinity, 1),
        (-.infinity, 0),
        (.nan, 0)
    ])
    func clampsOpacity(_ opacity: Float, _ expected: Float) {
        let view = UIView()
        view.addShadow(opacity: opacity)
        #expect(view.layer.shadowOpacity == expected)
    }

    @Test
    func resolvesDynamicColorWithViewTraits() {
        let dynamic = UIColor { $0.userInterfaceStyle == .dark ? .white : .black }
        let darkView = UIView()
        darkView.traitOverrides.userInterfaceStyle = .dark
        darkView.updateTraitsIfNeeded()
        darkView.addShadow(ofColor: dynamic)
        #expect(darkView.layer.shadowColor == UIColor.white.cgColor)

        let lightView = UIView()
        lightView.traitOverrides.userInterfaceStyle = .light
        lightView.updateTraitsIfNeeded()
        lightView.addShadow(ofColor: dynamic)
        #expect(lightView.layer.shadowColor == UIColor.black.cgColor)
    }
}
#endif
