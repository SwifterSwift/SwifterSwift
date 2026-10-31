// NSEdgeInsets+AddingTests.swift - Copyright 2026 SwifterSwift

#if canImport(AppKit) && !targetEnvironment(macCatalyst)
import Foundation
import SwifterSwiftAppKit
import Testing

struct NSEdgeInsetsAddingTests {
    @Test(
        arguments: [
            (NSEdgeInsets(), NSEdgeInsets(), NSEdgeInsets()),
            (
                NSEdgeInsets(top: 1, left: 2, bottom: 3, right: 4), NSEdgeInsets(top: 5, left: 6, bottom: 7, right: 8),
                NSEdgeInsets(top: 6, left: 8, bottom: 10, right: 12)
            ),
            (
                NSEdgeInsets(top: -1, left: -2, bottom: -3, right: -4),
                NSEdgeInsets(top: -5, left: -6, bottom: -7, right: -8),
                NSEdgeInsets(top: -6, left: -8, bottom: -10, right: -12)
            ),
            (
                NSEdgeInsets(top: 1, left: 2, bottom: 3, right: 4),
                NSEdgeInsets(top: -1, left: -2, bottom: -3, right: -4), NSEdgeInsets()
            ),
            (
                NSEdgeInsets(top: 0.5, left: 0, bottom: 0, right: 0),
                NSEdgeInsets(top: 0.25, left: 0, bottom: 0, right: 0),
                NSEdgeInsets(top: 0.75, left: 0, bottom: 0, right: 0)
            )
        ] as [(NSEdgeInsets, NSEdgeInsets, NSEdgeInsets)])
    func addsEdgeByEdge(_ insets: NSEdgeInsets, _ other: NSEdgeInsets, expected: NSEdgeInsets) {
        #expect(NSEdgeInsetsEqual(insets.adding(other), expected))
        #expect(NSEdgeInsetsEqual(other.adding(insets), expected))
    }

    @Test
    func addingZeroKeepsTheInsets() {
        let insets = NSEdgeInsets(top: 1, left: 2, bottom: 3, right: 4)
        #expect(NSEdgeInsetsEqual(insets.adding(NSEdgeInsets()), insets))
    }

    @Test
    func overflowsToInfinity() {
        let huge = NSEdgeInsets(top: .greatestFiniteMagnitude, left: 0, bottom: 0, right: 0)
        #expect(huge.adding(huge).top == .infinity)
    }
}
#endif
