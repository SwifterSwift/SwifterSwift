// NSStackView+AddArrangedSubviewsTests.swift - Copyright 2026 SwifterSwift

#if canImport(AppKit) && !targetEnvironment(macCatalyst)
import AppKit
import SwifterSwiftAppKit
import Testing

@MainActor
struct NSStackViewAddArrangedSubviewsTests {
    @Test
    func arrangesViewsInOrder() {
        let stack = NSStackView()
        let views = [NSView(), NSView(), NSView()]
        stack.addArrangedSubviews(views)
        #expect(stack.arrangedSubviews == views)
        #expect(views.allSatisfy { $0.superview === stack })
    }

    @Test
    func appendsAfterExistingArrangedSubviews() {
        let existing = NSView()
        let stack = NSStackView(views: [existing])
        let views = [NSView(), NSView()]
        stack.addArrangedSubviews(views)
        #expect(stack.arrangedSubviews == [existing] + views)
    }

    @Test
    func doesNothingForEmptyArray() {
        let existing = NSView()
        let stack = NSStackView(views: [existing])
        stack.addArrangedSubviews([])
        #expect(stack.arrangedSubviews == [existing])
        #expect(stack.subviews == [existing])
    }

    @Test
    func movesViewsFromTheirPreviousSuperview() {
        let oldContainer = NSView()
        let view = NSView()
        oldContainer.addSubview(view)
        let stack = NSStackView()
        stack.addArrangedSubviews([view])
        #expect(oldContainer.subviews.isEmpty)
        #expect(view.superview === stack)
        #expect(stack.arrangedSubviews == [view])
    }
}
#endif
