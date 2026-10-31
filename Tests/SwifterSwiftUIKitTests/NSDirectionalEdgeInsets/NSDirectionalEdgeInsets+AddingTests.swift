// NSDirectionalEdgeInsets+AddingTests.swift - Copyright 2026 SwifterSwift

#if canImport(UIKit)
import SwifterSwiftUIKit
import Testing
import UIKit

struct NSDirectionalEdgeInsetsAddingTests {
    @Test(
        arguments: [
            (NSDirectionalEdgeInsets(), NSDirectionalEdgeInsets(), NSDirectionalEdgeInsets()),
            (
                NSDirectionalEdgeInsets(top: 1, leading: 2, bottom: 3, trailing: 4),
                NSDirectionalEdgeInsets(top: 5, leading: 6, bottom: 7, trailing: 8),
                NSDirectionalEdgeInsets(top: 6, leading: 8, bottom: 10, trailing: 12)
            ),
            (
                NSDirectionalEdgeInsets(top: -1, leading: -2, bottom: -3, trailing: -4),
                NSDirectionalEdgeInsets(top: -5, leading: -6, bottom: -7, trailing: -8),
                NSDirectionalEdgeInsets(top: -6, leading: -8, bottom: -10, trailing: -12)
            ),
            (
                NSDirectionalEdgeInsets(top: 1, leading: 2, bottom: 3, trailing: 4),
                NSDirectionalEdgeInsets(top: -1, leading: -2, bottom: -3, trailing: -4), NSDirectionalEdgeInsets()
            ),
            (
                NSDirectionalEdgeInsets(top: 0.5, leading: 0, bottom: 0, trailing: 0),
                NSDirectionalEdgeInsets(top: 0.25, leading: 0, bottom: 0, trailing: 0),
                NSDirectionalEdgeInsets(top: 0.75, leading: 0, bottom: 0, trailing: 0)
            )
        ] as [(NSDirectionalEdgeInsets, NSDirectionalEdgeInsets, NSDirectionalEdgeInsets)])
    func addsEdgeByEdge(
        _ insets: NSDirectionalEdgeInsets, _ other: NSDirectionalEdgeInsets, expected: NSDirectionalEdgeInsets
    ) {
        #expect(insets.adding(other) == expected)
        #expect(other.adding(insets) == expected)
    }

    @Test
    func addingZeroKeepsTheInsets() {
        let insets = NSDirectionalEdgeInsets(top: 1, leading: 2, bottom: 3, trailing: 4)
        #expect(insets.adding(NSDirectionalEdgeInsets()) == insets)
    }

    @Test
    func overflowsToInfinity() {
        let huge = NSDirectionalEdgeInsets(top: .greatestFiniteMagnitude, leading: 0, bottom: 0, trailing: 0)
        #expect(huge.adding(huge).top == .infinity)
    }
}
#endif
