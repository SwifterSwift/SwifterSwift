// UIEdgeInsets+SubtractingTests.swift - Copyright 2026 SwifterSwift

#if canImport(UIKit)
import SwifterSwiftUIKit
import Testing
import UIKit

struct UIEdgeInsetsSubtractingTests {
    @Test(
        arguments: [
            (UIEdgeInsets(), UIEdgeInsets(), UIEdgeInsets()),
            (
                UIEdgeInsets(top: 6, left: 8, bottom: 10, right: 12),
                UIEdgeInsets(top: 5, left: 6, bottom: 7, right: 8), UIEdgeInsets(top: 1, left: 2, bottom: 3, right: 4)
            ),
            (
                UIEdgeInsets(top: 1, left: 2, bottom: 3, right: 4), UIEdgeInsets(top: 5, left: 6, bottom: 7, right: 8),
                UIEdgeInsets(top: -4, left: -4, bottom: -4, right: -4)
            ),
            (
                UIEdgeInsets(top: -1, left: -2, bottom: -3, right: -4),
                UIEdgeInsets(top: -1, left: -2, bottom: -3, right: -4), UIEdgeInsets()
            ),
            (
                UIEdgeInsets(top: 0.75, left: 0, bottom: 0, right: 0),
                UIEdgeInsets(top: 0.25, left: 0, bottom: 0, right: 0),
                UIEdgeInsets(top: 0.5, left: 0, bottom: 0, right: 0)
            )
        ] as [(UIEdgeInsets, UIEdgeInsets, UIEdgeInsets)])
    func subtractsEdgeByEdge(_ insets: UIEdgeInsets, _ other: UIEdgeInsets, expected: UIEdgeInsets) {
        #expect(insets.subtracting(other) == expected)
    }

    @Test
    func subtractingZeroKeepsTheInsets() {
        let insets = UIEdgeInsets(top: 1, left: 2, bottom: 3, right: 4)
        #expect(insets.subtracting(UIEdgeInsets()) == insets)
    }

    @Test
    func isNotCommutative() {
        let insets = UIEdgeInsets(top: 1, left: 2, bottom: 3, right: 4)
        let other = UIEdgeInsets(top: 4, left: 3, bottom: 2, right: 1)
        #expect(insets.subtracting(other) == UIEdgeInsets(top: -3, left: -1, bottom: 1, right: 3))
        #expect(other.subtracting(insets) == UIEdgeInsets(top: 3, left: 1, bottom: -1, right: -3))
    }

    @Test
    func infinityMinusInfinityIsNaN() {
        let infinite = UIEdgeInsets(top: .infinity, left: 0, bottom: 0, right: 0)
        #expect(infinite.subtracting(infinite).top.isNaN)
    }
}
#endif
