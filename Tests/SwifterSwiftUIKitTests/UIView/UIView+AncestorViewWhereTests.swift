// UIView+AncestorViewWhereTests.swift - Copyright 2026 SwifterSwift

#if canImport(UIKit) && !os(watchOS)
import Foundation
import SwifterSwiftUIKit
import Testing
import UIKit

@MainActor
struct UIViewAncestorViewWhereTests {
    @Test
    func returnsClosestMatchingAncestor() {
        let root = UIView()
        let card = UIView()
        let button = UIButton()
        let icon = UIView()
        root.addSubview(card)
        card.addSubview(button)
        button.addSubview(icon)
        root.tag = 7
        card.tag = 7
        #expect(icon.ancestorView { $0.tag == 7 } === card)
        #expect(icon.ancestorView { $0 is UIButton } === button)
        #expect(icon.ancestorView { $0.superview == nil } === root)
    }

    @Test
    func neverReturnsTheViewItself() {
        let container = UIView()
        let view = UIView()
        container.addSubview(view)
        view.tag = 1
        #expect(view.ancestorView { $0.tag == 1 } == nil)
    }

    @Test
    func returnsNilWhenNoAncestorMatches() {
        let container = UIView()
        let view = UIView()
        container.addSubview(view)
        #expect(view.ancestorView { $0.tag == 99 } == nil)
    }

    @Test
    func doesNotCallPredicateWithoutSuperview() {
        var calls = 0
        let result = UIView().ancestorView { _ in
            calls += 1
            return true
        }
        #expect(result == nil)
        #expect(calls == 0)
    }

    @Test
    func visitsAncestorsFromClosestToRoot() {
        let root = UIView()
        let middle = UIView()
        let view = UIView()
        root.addSubview(middle)
        middle.addSubview(view)
        var visited: [UIView] = []
        _ = view.ancestorView { ancestor in
            visited.append(ancestor)
            return false
        }
        #expect(visited == [middle, root])
    }

    @Test
    func rethrowsPredicateError() {
        let container = UIView()
        let view = UIView()
        container.addSubview(view)
        #expect(throws: CocoaError.self) {
            try view.ancestorView { _ in throw CocoaError(.userCancelled) }
        }
    }
}
#endif
