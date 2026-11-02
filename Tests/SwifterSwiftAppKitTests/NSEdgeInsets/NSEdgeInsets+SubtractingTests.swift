// NSEdgeInsets+SubtractingTests.swift - Copyright 2026 SwifterSwift

#if canImport(AppKit) && !targetEnvironment(macCatalyst)
import Foundation
import SwifterSwiftAppKit
import Testing

struct NSEdgeInsetsSubtractingTests {
    @Test(
        arguments: [
            (NSEdgeInsets(), NSEdgeInsets(), NSEdgeInsets()),
            (
                NSEdgeInsets(top: 6, left: 8, bottom: 10, right: 12),
                NSEdgeInsets(top: 5, left: 6, bottom: 7, right: 8), NSEdgeInsets(top: 1, left: 2, bottom: 3, right: 4)
            ),
            (
                NSEdgeInsets(top: 1, left: 2, bottom: 3, right: 4), NSEdgeInsets(top: 5, left: 6, bottom: 7, right: 8),
                NSEdgeInsets(top: -4, left: -4, bottom: -4, right: -4)
            ),
            (
                NSEdgeInsets(top: -1, left: -2, bottom: -3, right: -4),
                NSEdgeInsets(top: -1, left: -2, bottom: -3, right: -4), NSEdgeInsets()
            ),
            (
                NSEdgeInsets(top: 0.75, left: 0, bottom: 0, right: 0),
                NSEdgeInsets(top: 0.25, left: 0, bottom: 0, right: 0),
                NSEdgeInsets(top: 0.5, left: 0, bottom: 0, right: 0)
            )
        ] as [(NSEdgeInsets, NSEdgeInsets, NSEdgeInsets)])
    func subtractsEdgeByEdge(_ insets: NSEdgeInsets, _ other: NSEdgeInsets, expected: NSEdgeInsets) {
        #expect(NSEdgeInsetsEqual(insets.subtracting(other), expected))
    }

    @Test
    func subtractingZeroKeepsTheInsets() {
        let insets = NSEdgeInsets(top: 1, left: 2, bottom: 3, right: 4)
        #expect(NSEdgeInsetsEqual(insets.subtracting(NSEdgeInsets()), insets))
    }

    @Test
    func isNotCommutative() {
        let insets = NSEdgeInsets(top: 1, left: 2, bottom: 3, right: 4)
        let other = NSEdgeInsets(top: 4, left: 3, bottom: 2, right: 1)
        #expect(NSEdgeInsetsEqual(insets.subtracting(other), NSEdgeInsets(top: -3, left: -1, bottom: 1, right: 3)))
        #expect(NSEdgeInsetsEqual(other.subtracting(insets), NSEdgeInsets(top: 3, left: 1, bottom: -1, right: -3)))
    }

    @Test
    func infinityMinusInfinityIsNaN() {
        let infinite = NSEdgeInsets(top: .infinity, left: 0, bottom: 0, right: 0)
        #expect(infinite.subtracting(infinite).top.isNaN)
    }
}
#endif
