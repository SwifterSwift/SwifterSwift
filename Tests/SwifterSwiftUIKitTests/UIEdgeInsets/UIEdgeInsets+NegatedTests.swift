// UIEdgeInsets+NegatedTests.swift - Copyright 2026 SwifterSwift

#if canImport(UIKit)
import SwifterSwiftUIKit
import Testing
import UIKit

struct UIEdgeInsetsNegatedTests {
    @Test(
        arguments: [
            (
                UIEdgeInsets(top: 8, left: -4, bottom: 0, right: 16),
                UIEdgeInsets(top: -8, left: 4, bottom: 0, right: -16)
            ),
            (
                UIEdgeInsets(top: 1, left: 2, bottom: 3, right: 4),
                UIEdgeInsets(top: -1, left: -2, bottom: -3, right: -4)
            ),
            (UIEdgeInsets(), UIEdgeInsets()),
            (
                UIEdgeInsets(top: 0.5, left: -0.25, bottom: 0, right: 0),
                UIEdgeInsets(top: -0.5, left: 0.25, bottom: 0, right: 0)
            )
        ] as [(UIEdgeInsets, UIEdgeInsets)])
    func flipsTheSignOfEveryEdge(_ insets: UIEdgeInsets, expected: UIEdgeInsets) {
        #expect(insets.negated() == expected)
    }

    @Test
    func negatingTwiceGivesTheOriginalInsets() {
        let insets = UIEdgeInsets(top: 1, left: -2, bottom: 3, right: -4)
        #expect(insets.negated().negated() == insets)
    }

    @Test
    func handlesExtremeValues() {
        let insets = UIEdgeInsets(
            top: .infinity, left: -.infinity, bottom: .greatestFiniteMagnitude, right: -.greatestFiniteMagnitude)
        #expect(
            insets.negated()
                == UIEdgeInsets(
                    top: -.infinity, left: .infinity, bottom: -.greatestFiniteMagnitude, right: .greatestFiniteMagnitude
                ))
    }
}
#endif
