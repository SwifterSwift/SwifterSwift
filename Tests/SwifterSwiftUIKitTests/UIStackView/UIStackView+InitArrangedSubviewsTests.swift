// UIStackView+InitArrangedSubviewsTests.swift - Copyright 2026 SwifterSwift

#if canImport(UIKit) && !os(watchOS)
import SwifterSwiftUIKit
import Testing
import UIKit

@MainActor
struct UIStackViewInitArrangedSubviewsTests {
    @Test
    func usesDefaultsForOptionalSettings() {
        let views = [UIView(), UIView()]
        let stack = UIStackView(arrangedSubviews: views, axis: .horizontal)
        let plain = UIStackView()
        #expect(stack.arrangedSubviews == views)
        #expect(stack.axis == .horizontal)
        #expect(stack.spacing == plain.spacing)
        #expect(stack.alignment == plain.alignment)
        #expect(stack.distribution == plain.distribution)
    }

    @Test
    func setsEverySetting() {
        let views = [UIView(), UIView(), UIView()]
        let stack = UIStackView(
            arrangedSubviews: views,
            axis: .vertical,
            spacing: 16,
            alignment: .center,
            distribution: .fillEqually
        )
        #expect(stack.arrangedSubviews == views)
        #expect(stack.subviews == views)
        #expect(stack.axis == .vertical)
        #expect(stack.spacing == 16)
        #expect(stack.alignment == .center)
        #expect(stack.distribution == .fillEqually)
    }

    @Test(arguments: [NSLayoutConstraint.Axis.horizontal, .vertical])
    func setsAxis(_ axis: NSLayoutConstraint.Axis) {
        #expect(UIStackView(arrangedSubviews: [], axis: axis).axis == axis)
    }

    @Test
    func acceptsNegativeSpacing() {
        let stack = UIStackView(arrangedSubviews: [UIView(), UIView()], axis: .horizontal, spacing: -4)
        #expect(stack.spacing == -4)
    }

    @Test
    func createsEmptyStackView() {
        let stack = UIStackView(arrangedSubviews: [], axis: .vertical, spacing: 8)
        #expect(stack.arrangedSubviews.isEmpty)
        #expect(stack.spacing == 8)
    }

    @Test
    func movesViewsFromTheirSuperview() {
        let container = UIView()
        let view = UIView()
        container.addSubview(view)
        let stack = UIStackView(arrangedSubviews: [view], axis: .vertical)
        #expect(view.superview === stack)
        #expect(container.subviews.isEmpty)
    }
}
#endif
