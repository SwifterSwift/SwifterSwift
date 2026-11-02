// UIView+AddSubviewsTests.swift - Copyright 2026 SwifterSwift

#if canImport(UIKit) && !os(watchOS)
import SwifterSwiftUIKit
import Testing
import UIKit

@MainActor
struct UIViewAddSubviewsTests {
    @Test
    func addsViewsInOrder() {
        let container = UIView()
        let views = [UIView(), UIView(), UIView()]
        container.addSubviews(views)
        #expect(container.subviews == views)
        #expect(views.allSatisfy { $0.superview === container })
    }

    @Test
    func appendsAfterExistingSubviews() {
        let container = UIView()
        let existing = UIView()
        container.addSubview(existing)
        let views = [UIView(), UIView()]
        container.addSubviews(views)
        #expect(container.subviews == [existing] + views)
    }

    @Test
    func doesNothingForEmptyArray() {
        let container = UIView()
        let existing = UIView()
        container.addSubview(existing)
        container.addSubviews([])
        #expect(container.subviews == [existing])
    }

    @Test
    func movesViewFromPreviousSuperview() {
        let oldContainer = UIView()
        let newContainer = UIView()
        let view = UIView()
        oldContainer.addSubview(view)
        newContainer.addSubviews([view])
        #expect(oldContainer.subviews.isEmpty)
        #expect(newContainer.subviews == [view])
    }

    @Test
    func movesExistingSubviewToFront() {
        let container = UIView()
        let first = UIView()
        let second = UIView()
        container.addSubviews([first, second])
        container.addSubviews([first])
        #expect(container.subviews == [second, first])
    }
}
#endif
