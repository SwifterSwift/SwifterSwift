// UIStackView+AddArrangedSubviewsTests.swift - Copyright 2026 SwifterSwift

#if canImport(UIKit) && !os(watchOS)
import SwifterSwiftUIKit
import Testing
import UIKit

@MainActor
struct UIStackViewAddArrangedSubviewsTests {
    @Test
    func arrangesViewsInOrder() {
        let stack = UIStackView()
        let views = [UIView(), UILabel(), UIButton()]
        stack.addArrangedSubviews(views)
        #expect(stack.arrangedSubviews == views)
        #expect(stack.subviews == views)
    }

    @Test
    func appendsAfterExistingArrangedSubviews() {
        let existing = UIView()
        let stack = UIStackView(arrangedSubviews: [existing])
        let views = [UIView(), UIView()]
        stack.addArrangedSubviews(views)
        #expect(stack.arrangedSubviews == [existing] + views)
    }

    @Test
    func doesNothingForEmptyArray() {
        let existing = UIView()
        let stack = UIStackView(arrangedSubviews: [existing])
        stack.addArrangedSubviews([])
        #expect(stack.arrangedSubviews == [existing])
    }

    @Test
    func movesViewFromPreviousSuperview() {
        let container = UIView()
        let view = UIView()
        container.addSubview(view)
        let stack = UIStackView()
        stack.addArrangedSubviews([view])
        #expect(container.subviews.isEmpty)
        #expect(stack.arrangedSubviews == [view])
    }

    @Test
    func movesAlreadyArrangedViewToTheEnd() {
        let first = UIView()
        let second = UIView()
        let stack = UIStackView(arrangedSubviews: [first, second])
        stack.addArrangedSubviews([first])
        #expect(stack.arrangedSubviews == [second, first])
    }
}
#endif
