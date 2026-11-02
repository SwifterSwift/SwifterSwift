// NSDirectionalEdgeInsets+SubtractingTests.swift - Copyright 2026 SwifterSwift

#if canImport(UIKit)
import SwifterSwiftUIKit
import Testing
import UIKit

struct NSDirectionalEdgeInsetsSubtractingTests {
    @Test(
        arguments: [
            (NSDirectionalEdgeInsets(), NSDirectionalEdgeInsets(), NSDirectionalEdgeInsets()),
            (
                NSDirectionalEdgeInsets(top: 6, leading: 8, bottom: 10, trailing: 12),
                NSDirectionalEdgeInsets(top: 5, leading: 6, bottom: 7, trailing: 8),
                NSDirectionalEdgeInsets(top: 1, leading: 2, bottom: 3, trailing: 4)
            ),
            (
                NSDirectionalEdgeInsets(top: 1, leading: 2, bottom: 3, trailing: 4),
                NSDirectionalEdgeInsets(top: 5, leading: 6, bottom: 7, trailing: 8),
                NSDirectionalEdgeInsets(top: -4, leading: -4, bottom: -4, trailing: -4)
            ),
            (
                NSDirectionalEdgeInsets(top: -1, leading: -2, bottom: -3, trailing: -4),
                NSDirectionalEdgeInsets(top: -1, leading: -2, bottom: -3, trailing: -4), NSDirectionalEdgeInsets()
            ),
            (
                NSDirectionalEdgeInsets(top: 0.75, leading: 0, bottom: 0, trailing: 0),
                NSDirectionalEdgeInsets(top: 0.25, leading: 0, bottom: 0, trailing: 0),
                NSDirectionalEdgeInsets(top: 0.5, leading: 0, bottom: 0, trailing: 0)
            )
        ] as [(NSDirectionalEdgeInsets, NSDirectionalEdgeInsets, NSDirectionalEdgeInsets)])
    func subtractsEdgeByEdge(
        _ insets: NSDirectionalEdgeInsets, _ other: NSDirectionalEdgeInsets, expected: NSDirectionalEdgeInsets
    ) {
        #expect(insets.subtracting(other) == expected)
    }

    @Test
    func subtractingZeroKeepsTheInsets() {
        let insets = NSDirectionalEdgeInsets(top: 1, leading: 2, bottom: 3, trailing: 4)
        #expect(insets.subtracting(NSDirectionalEdgeInsets()) == insets)
    }

    @Test
    func isNotCommutative() {
        let insets = NSDirectionalEdgeInsets(top: 1, leading: 2, bottom: 3, trailing: 4)
        let other = NSDirectionalEdgeInsets(top: 4, leading: 3, bottom: 2, trailing: 1)
        #expect(insets.subtracting(other) == NSDirectionalEdgeInsets(top: -3, leading: -1, bottom: 1, trailing: 3))
        #expect(other.subtracting(insets) == NSDirectionalEdgeInsets(top: 3, leading: 1, bottom: -1, trailing: -3))
    }

    @Test
    func infinityMinusInfinityIsNaN() {
        let infinite = NSDirectionalEdgeInsets(top: .infinity, leading: 0, bottom: 0, trailing: 0)
        #expect(infinite.subtracting(infinite).top.isNaN)
    }
}
#endif
