// UINavigationBar+MakeTransparentTests.swift - Copyright 2026 SwifterSwift

#if canImport(UIKit) && !os(watchOS) && !os(tvOS)
import SwifterSwiftUIKit
import Testing
import UIKit

@MainActor
struct UINavigationBarMakeTransparentTests {
    /// The four appearances of the bar, in the order standard, compact, scroll edge and compact scroll edge.
    func appearances(of bar: UINavigationBar) throws -> [UINavigationBarAppearance] {
        [
            bar.standardAppearance,
            try #require(bar.compactAppearance),
            try #require(bar.scrollEdgeAppearance),
            try #require(bar.compactScrollEdgeAppearance)
        ]
    }

    /// Whether the background of the appearance matches the one `configureWithTransparentBackground()` gives.
    func isTransparent(_ appearance: UINavigationBarAppearance) -> Bool {
        let reference = UINavigationBarAppearance()
        reference.configureWithTransparentBackground()
        return appearance.backgroundEffect == reference.backgroundEffect
            && appearance.backgroundColor == reference.backgroundColor
            && appearance.backgroundImage == reference.backgroundImage
            && appearance.shadowColor == reference.shadowColor
            && appearance.shadowImage == reference.shadowImage
    }

    @Test
    func makesEveryAppearanceTransparent() throws {
        let bar = UINavigationBar()
        bar.makeTransparent()
        let appearances = try appearances(of: bar)
        #expect(appearances.allSatisfy(isTransparent))
        #expect(appearances.allSatisfy { $0.backgroundEffect == nil })
    }

    @Test
    func replacesOpaqueAppearances() throws {
        let bar = UINavigationBar()
        let opaque = UINavigationBarAppearance()
        opaque.configureWithOpaqueBackground()
        opaque.backgroundColor = .red
        bar.standardAppearance = opaque
        bar.compactAppearance = opaque
        bar.scrollEdgeAppearance = opaque
        bar.compactScrollEdgeAppearance = opaque
        bar.makeTransparent()
        #expect(try appearances(of: bar).allSatisfy(isTransparent))
    }

    @Test
    func keepsTheTitleAttributesOfTheStandardAppearance() throws {
        let bar = UINavigationBar()
        let font = UIFont.systemFont(ofSize: 21, weight: .heavy)
        let appearance = UINavigationBarAppearance()
        appearance.titleTextAttributes = [.font: font, .foregroundColor: UIColor.green]
        appearance.largeTitleTextAttributes = [.font: font]
        bar.standardAppearance = appearance
        bar.makeTransparent()
        for appearance in try appearances(of: bar) {
            #expect(appearance.titleTextAttributes[.font] as? UIFont == font)
            #expect(appearance.titleTextAttributes[.foregroundColor] as? UIColor == .green)
            #expect(appearance.largeTitleTextAttributes[.font] as? UIFont == font)
        }
    }

    @Test
    func appliesTheTint() throws {
        let bar = UINavigationBar()
        let font = UIFont.systemFont(ofSize: 21, weight: .heavy)
        bar.standardAppearance.titleTextAttributes = [.font: font, .foregroundColor: UIColor.green]
        bar.makeTransparent(withTint: .red)
        #expect(bar.tintColor == .red)
        for appearance in try appearances(of: bar) {
            #expect(appearance.titleTextAttributes[.foregroundColor] as? UIColor == .red)
            #expect(appearance.titleTextAttributes[.font] as? UIFont == font)
            #expect(appearance.largeTitleTextAttributes[.foregroundColor] as? UIColor == .red)
            #expect(isTransparent(appearance))
        }
    }

    @Test
    func leavesTheColorsAloneWithoutATint() throws {
        let bar = UINavigationBar()
        bar.tintColor = .blue
        bar.standardAppearance.titleTextAttributes = [.foregroundColor: UIColor.green]
        let largeTitleColor = bar.standardAppearance.largeTitleTextAttributes[.foregroundColor] as? UIColor
        bar.makeTransparent()
        #expect(bar.tintColor == .blue)
        for appearance in try appearances(of: bar) {
            #expect(appearance.titleTextAttributes[.foregroundColor] as? UIColor == .green)
            #expect(appearance.largeTitleTextAttributes[.foregroundColor] as? UIColor == largeTitleColor)
        }
    }

    @Test
    func canBeCalledAgain() throws {
        let bar = UINavigationBar()
        bar.makeTransparent(withTint: .red)
        bar.makeTransparent(withTint: .blue)
        #expect(bar.tintColor == .blue)
        for appearance in try appearances(of: bar) {
            #expect(appearance.titleTextAttributes[.foregroundColor] as? UIColor == .blue)
            #expect(isTransparent(appearance))
        }
    }

    @Test
    func leavesTheNavigationItemsAppearancesAlone() throws {
        let bar = UINavigationBar()
        let item = UINavigationItem(title: "Title")
        let itemAppearance = UINavigationBarAppearance()
        itemAppearance.configureWithOpaqueBackground()
        itemAppearance.backgroundColor = .red
        item.standardAppearance = itemAppearance
        bar.setItems([item], animated: false)
        bar.makeTransparent()
        let appearance = try #require(item.standardAppearance)
        #expect(appearance.backgroundColor == .red)
        #expect(!isTransparent(appearance))
    }
}
#endif
