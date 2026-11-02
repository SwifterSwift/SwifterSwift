// NSDirectionalEdgeInsets+NegatedTests.swift - Copyright 2026 SwifterSwift

#if canImport(UIKit)
import SwifterSwiftUIKit
import Testing
import UIKit

struct NSDirectionalEdgeInsetsNegatedTests {
    @Test(
        arguments: [
            (
                NSDirectionalEdgeInsets(top: 8, leading: -4, bottom: 0, trailing: 16),
                NSDirectionalEdgeInsets(top: -8, leading: 4, bottom: 0, trailing: -16)
            ),
            (
                NSDirectionalEdgeInsets(top: 1, leading: 2, bottom: 3, trailing: 4),
                NSDirectionalEdgeInsets(top: -1, leading: -2, bottom: -3, trailing: -4)
            ),
            (NSDirectionalEdgeInsets(), NSDirectionalEdgeInsets()),
            (
                NSDirectionalEdgeInsets(top: 0.5, leading: -0.25, bottom: 0, trailing: 0),
                NSDirectionalEdgeInsets(top: -0.5, leading: 0.25, bottom: 0, trailing: 0)
            )
        ] as [(NSDirectionalEdgeInsets, NSDirectionalEdgeInsets)])
    func flipsTheSignOfEveryEdge(_ insets: NSDirectionalEdgeInsets, expected: NSDirectionalEdgeInsets) {
        #expect(insets.negated() == expected)
    }

    @Test
    func negatingTwiceGivesTheOriginalInsets() {
        let insets = NSDirectionalEdgeInsets(top: 1, leading: -2, bottom: 3, trailing: -4)
        #expect(insets.negated().negated() == insets)
    }

    @Test
    func handlesExtremeValues() {
        let insets = NSDirectionalEdgeInsets(
            top: .infinity, leading: -.infinity, bottom: .greatestFiniteMagnitude, trailing: -.greatestFiniteMagnitude)
        #expect(
            insets.negated()
                == NSDirectionalEdgeInsets(
                    top: -.infinity, leading: .infinity, bottom: -.greatestFiniteMagnitude,
                    trailing: .greatestFiniteMagnitude))
    }
}
#endif
