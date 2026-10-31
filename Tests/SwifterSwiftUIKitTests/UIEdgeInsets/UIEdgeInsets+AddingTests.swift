// UIEdgeInsets+AddingTests.swift - Copyright 2026 SwifterSwift

#if canImport(UIKit)
import SwifterSwiftUIKit
import Testing
import UIKit

struct UIEdgeInsetsAddingTests {
    @Test(
        arguments: [
            (UIEdgeInsets(), UIEdgeInsets(), UIEdgeInsets()),
            (
                UIEdgeInsets(top: 1, left: 2, bottom: 3, right: 4), UIEdgeInsets(top: 5, left: 6, bottom: 7, right: 8),
                UIEdgeInsets(top: 6, left: 8, bottom: 10, right: 12)
            ),
            (
                UIEdgeInsets(top: -1, left: -2, bottom: -3, right: -4),
                UIEdgeInsets(top: -5, left: -6, bottom: -7, right: -8),
                UIEdgeInsets(top: -6, left: -8, bottom: -10, right: -12)
            ),
            (
                UIEdgeInsets(top: 1, left: 2, bottom: 3, right: 4),
                UIEdgeInsets(top: -1, left: -2, bottom: -3, right: -4), UIEdgeInsets()
            ),
            (
                UIEdgeInsets(top: 0.5, left: 0, bottom: 0, right: 0),
                UIEdgeInsets(top: 0.25, left: 0, bottom: 0, right: 0),
                UIEdgeInsets(top: 0.75, left: 0, bottom: 0, right: 0)
            )
        ] as [(UIEdgeInsets, UIEdgeInsets, UIEdgeInsets)])
    func addsEdgeByEdge(_ insets: UIEdgeInsets, _ other: UIEdgeInsets, expected: UIEdgeInsets) {
        #expect(insets.adding(other) == expected)
        #expect(other.adding(insets) == expected)
    }

    @Test
    func addingZeroKeepsTheInsets() {
        let insets = UIEdgeInsets(top: 1, left: 2, bottom: 3, right: 4)
        #expect(insets.adding(UIEdgeInsets()) == insets)
    }

    @Test
    func overflowsToInfinity() {
        let huge = UIEdgeInsets(top: .greatestFiniteMagnitude, left: 0, bottom: 0, right: 0)
        #expect(huge.adding(huge).top == .infinity)
    }
}
#endif
