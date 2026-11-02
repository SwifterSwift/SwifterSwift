// NSEdgeInsets+NegatedTests.swift - Copyright 2026 SwifterSwift

#if canImport(AppKit) && !targetEnvironment(macCatalyst)
import Foundation
import SwifterSwiftAppKit
import Testing

struct NSEdgeInsetsNegatedTests {
    @Test(
        arguments: [
            (
                NSEdgeInsets(top: 8, left: -4, bottom: 0, right: 16),
                NSEdgeInsets(top: -8, left: 4, bottom: 0, right: -16)
            ),
            (
                NSEdgeInsets(top: 1, left: 2, bottom: 3, right: 4),
                NSEdgeInsets(top: -1, left: -2, bottom: -3, right: -4)
            ),
            (NSEdgeInsets(), NSEdgeInsets()),
            (
                NSEdgeInsets(top: 0.5, left: -0.25, bottom: 0, right: 0),
                NSEdgeInsets(top: -0.5, left: 0.25, bottom: 0, right: 0)
            )
        ] as [(NSEdgeInsets, NSEdgeInsets)])
    func flipsTheSignOfEveryEdge(_ insets: NSEdgeInsets, expected: NSEdgeInsets) {
        #expect(NSEdgeInsetsEqual(insets.negated(), expected))
    }

    @Test
    func negatingTwiceGivesTheOriginalInsets() {
        let insets = NSEdgeInsets(top: 1, left: -2, bottom: 3, right: -4)
        #expect(NSEdgeInsetsEqual(insets.negated().negated(), insets))
    }

    @Test
    func handlesExtremeValues() {
        let insets = NSEdgeInsets(
            top: .infinity, left: -.infinity, bottom: .greatestFiniteMagnitude, right: -.greatestFiniteMagnitude)
        #expect(
            NSEdgeInsetsEqual(
                insets.negated(),
                NSEdgeInsets(
                    top: -.infinity, left: .infinity, bottom: -.greatestFiniteMagnitude, right: .greatestFiniteMagnitude
                )))
    }
}
#endif
