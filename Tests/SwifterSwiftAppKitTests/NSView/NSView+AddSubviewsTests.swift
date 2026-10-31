// NSView+AddSubviewsTests.swift - Copyright 2026 SwifterSwift

#if canImport(AppKit) && !targetEnvironment(macCatalyst)
import AppKit
import SwifterSwiftAppKit
import Testing

@MainActor
struct NSViewAddSubviewsTests {
    @Test
    func addsViewsInOrder() {
        let container = NSView()
        let views = [NSView(), NSView(), NSView()]
        container.addSubviews(views)
        #expect(container.subviews == views)
        #expect(views.allSatisfy { $0.superview === container })
    }

    @Test
    func appendsAfterExistingSubviews() {
        let container = NSView()
        let existing = NSView()
        container.addSubview(existing)
        let views = [NSView(), NSView()]
        container.addSubviews(views)
        #expect(container.subviews == [existing] + views)
    }

    @Test
    func doesNothingForEmptyArray() {
        let container = NSView()
        let existing = NSView()
        container.addSubview(existing)
        container.addSubviews([])
        #expect(container.subviews == [existing])
    }

    @Test
    func movesViewFromPreviousSuperview() {
        let oldContainer = NSView()
        let newContainer = NSView()
        let view = NSView()
        oldContainer.addSubview(view)
        newContainer.addSubviews([view])
        #expect(oldContainer.subviews.isEmpty)
        #expect(newContainer.subviews == [view])
    }

    @Test
    func movesExistingSubviewToFront() {
        let container = NSView()
        let first = NSView()
        let second = NSView()
        container.addSubviews([first, second])
        container.addSubviews([first])
        #expect(container.subviews == [second, first])
    }
}
#endif
