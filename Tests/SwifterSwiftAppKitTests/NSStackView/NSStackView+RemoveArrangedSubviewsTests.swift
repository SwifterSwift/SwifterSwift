// NSStackView+RemoveArrangedSubviewsTests.swift - Copyright 2026 SwifterSwift

#if canImport(AppKit) && !targetEnvironment(macCatalyst)
import AppKit
import SwifterSwiftAppKit
import Testing

@MainActor
struct NSStackViewRemoveArrangedSubviewsTests {
    @Test
    func removesArrangedSubviewsFromTheStack() {
        let views = [NSView(), NSView()]
        let stack = NSStackView(views: views)
        stack.removeArrangedSubviews()
        #expect(stack.arrangedSubviews.isEmpty)
    }

    @Test
    func removesArrangedSubviewsFromTheViewHierarchy() {
        let views = [NSView(), NSView()]
        let stack = NSStackView(views: views)
        stack.removeArrangedSubviews()
        #expect(stack.subviews.isEmpty)
        #expect(views.allSatisfy { $0.superview == nil })
    }

    @Test
    func keepsSubviewsThatAreNotArranged() {
        let arranged = NSView()
        let decoration = NSView()
        let stack = NSStackView(views: [arranged])
        stack.addSubview(decoration)
        stack.removeArrangedSubviews()
        #expect(stack.arrangedSubviews.isEmpty)
        #expect(stack.subviews == [decoration])
        #expect(arranged.superview == nil)
    }

    @Test
    func doesNothingForAnEmptyStack() {
        let stack = NSStackView()
        stack.removeArrangedSubviews()
        #expect(stack.arrangedSubviews.isEmpty)
        #expect(stack.subviews.isEmpty)
    }

    @Test
    func letsRemovedViewsBeArrangedAgain() {
        let view = NSView()
        let stack = NSStackView(views: [view])
        stack.removeArrangedSubviews()
        stack.addArrangedSubview(view)
        #expect(stack.arrangedSubviews == [view])
        #expect(stack.subviews == [view])
    }
}
#endif
