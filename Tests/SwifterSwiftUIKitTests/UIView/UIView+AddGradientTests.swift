// UIView+AddGradientTests.swift - Copyright 2026 SwifterSwift

#if canImport(UIKit) && !os(watchOS)
import CoreGraphics
import QuartzCore
import SwifterSwiftUIKit
import Testing
import UIKit

@MainActor
struct UIViewAddGradientTests {
    @Test
    func insertsGradientBelowExistingContent() throws {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: 100, height: 50))
        let label = UILabel()
        view.addSubview(label)
        let gradient = view.addGradient(colors: [.red, .blue])
        let sublayers = try #require(view.layer.sublayers)
        #expect(sublayers.first === gradient)
        #expect(sublayers.last === label.layer)
        #expect(gradient.frame == view.bounds)
    }

    @Test
    func setsColorsAndDefaultPoints() throws {
        let view = UIView()
        let gradient = view.addGradient(colors: [.red, .orange, .green])
        let colors = try #require(gradient.colors as? [CGColor])
        #expect(colors == [UIColor.red.cgColor, UIColor.orange.cgColor, UIColor.green.cgColor])
        #expect(gradient.startPoint == CGPoint(x: 0.5, y: 0))
        #expect(gradient.endPoint == CGPoint(x: 0.5, y: 1))
        #expect(gradient.locations == nil)
    }

    @Test(arguments: [
        (CGPoint(x: 0, y: 0.5), CGPoint(x: 1, y: 0.5)),
        (CGPoint(x: 1, y: 0.5), CGPoint(x: 0, y: 0.5)),
        (CGPoint(x: 0.5, y: 1), CGPoint(x: 0.5, y: 0)),
        (CGPoint(x: 0, y: 0), CGPoint(x: 1, y: 1))
    ])
    func setsStartAndEndPoints(_ start: CGPoint, _ end: CGPoint) {
        let view = UIView()
        let gradient = view.addGradient(colors: [.red, .blue], startPoint: start, endPoint: end)
        #expect(gradient.startPoint == start)
        #expect(gradient.endPoint == end)
    }

    @Test
    func setsLocationsWhenThereIsOnePerColor() throws {
        let view = UIView()
        let gradient = view.addGradient(colors: [.red, .orange, .blue], locations: [0, 0.333, 1])
        let locations = try #require(gradient.locations)
        #expect(locations.map(\.doubleValue) == [0, 0.333, 1])
    }

    @Test(arguments: [[CGFloat](), [0.5], [0, 0.5, 1]])
    func ignoresLocationsThatDoNotMatchTheColors(_ locations: [CGFloat]) {
        let view = UIView()
        let gradient = view.addGradient(colors: [.red, .blue], locations: locations)
        #expect(gradient.locations == nil)
    }

    @Test
    func updatesTheSameLayerOnRepeatedCalls() throws {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: 100, height: 50))
        let first = view.addGradient(colors: [.red, .blue])
        view.frame.size = CGSize(width: 300, height: 20)
        let second = view.addGradient(colors: [.green, .yellow], locations: [0.2, 0.8])
        #expect(first === second)
        #expect(view.layer.sublayers?.count { $0 is CAGradientLayer } == 1)
        #expect(second.frame == CGRect(x: 0, y: 0, width: 300, height: 20))
        let colors = try #require(second.colors as? [CGColor])
        #expect(colors == [UIColor.green.cgColor, UIColor.yellow.cgColor])
        #expect(second.locations?.map(\.doubleValue) == [0.2, 0.8])
    }

    @Test
    func keepsGradientLayersAddedByOthers() {
        let view = UIView()
        let other = CAGradientLayer()
        view.layer.addSublayer(other)
        let gradient = view.addGradient(colors: [.red, .blue])
        #expect(gradient !== other)
        #expect(view.layer.sublayers?.count == 2)
    }

    @Test
    func resolvesDynamicColorsWithViewTraits() throws {
        let dynamic = UIColor { $0.userInterfaceStyle == .dark ? .white : .black }
        let view = UIView()
        view.traitOverrides.userInterfaceStyle = .dark
        view.updateTraitsIfNeeded()
        let gradient = view.addGradient(colors: [dynamic, .red])
        let colors = try #require(gradient.colors as? [CGColor])
        #expect(colors.first == UIColor.white.cgColor)
    }

    @Test
    func acceptsEmptyColors() throws {
        let view = UIView()
        let gradient = view.addGradient(colors: [])
        let colors = try #require(gradient.colors as? [CGColor])
        #expect(colors.isEmpty)
    }
}
#endif
