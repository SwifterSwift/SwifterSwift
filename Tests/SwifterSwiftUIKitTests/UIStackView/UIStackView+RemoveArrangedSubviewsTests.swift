// UIStackView+RemoveArrangedSubviewsTests.swift - Copyright 2026 SwifterSwift

#if canImport(UIKit) && !os(watchOS)
import SwifterSwiftUIKit
import Testing
import UIKit

@MainActor
struct UIStackViewRemoveArrangedSubviewsTests {
    @Test
    func removesViewsFromStackAndHierarchy() {
        let views = [UIView(), UILabel()]
        let stack = UIStackView(arrangedSubviews: views)
        stack.removeArrangedSubviews()
        #expect(stack.arrangedSubviews.isEmpty)
        #expect(stack.subviews.isEmpty)
        #expect(views.allSatisfy { $0.superview == nil })
    }

    @Test
    func keepsSubviewsThatAreNotArranged() {
        let background = UIView()
        let stack = UIStackView(arrangedSubviews: [UIView(), UIView()])
        stack.insertSubview(background, at: 0)
        stack.removeArrangedSubviews()
        #expect(stack.arrangedSubviews.isEmpty)
        #expect(stack.subviews == [background])
    }

    @Test
    func doesNothingForEmptyStackView() {
        let stack = UIStackView()
        stack.removeArrangedSubviews()
        #expect(stack.arrangedSubviews.isEmpty)
        #expect(stack.subviews.isEmpty)
    }

    @Test
    func allowsReusingRemovedViews() {
        let view = UIView()
        let stack = UIStackView(arrangedSubviews: [view])
        stack.removeArrangedSubviews()
        let otherStack = UIStackView()
        otherStack.addArrangedSubview(view)
        #expect(otherStack.arrangedSubviews == [view])
        #expect(stack.subviews.isEmpty)
    }
}
#endif
