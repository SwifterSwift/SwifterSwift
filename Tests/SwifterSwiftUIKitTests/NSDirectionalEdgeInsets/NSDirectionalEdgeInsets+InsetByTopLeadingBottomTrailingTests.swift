// NSDirectionalEdgeInsets+InsetByTopLeadingBottomTrailingTests.swift - Copyright 2026 SwifterSwift

#if canImport(UIKit)
import SwifterSwiftUIKit
import Testing
import UIKit

struct NSDirectionalEdgeInsetsInsetByTopLeadingBottomTrailingTests {
    @Test(
        arguments: [
            (
                NSDirectionalEdgeInsets(top: 5, leading: 0, bottom: 0, trailing: 0),
                NSDirectionalEdgeInsets(top: 15, leading: 10, bottom: 10, trailing: 10)
            ),
            (
                NSDirectionalEdgeInsets(top: 0, leading: 5, bottom: 0, trailing: 0),
                NSDirectionalEdgeInsets(top: 10, leading: 15, bottom: 10, trailing: 10)
            ),
            (
                NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 5, trailing: 0),
                NSDirectionalEdgeInsets(top: 10, leading: 10, bottom: 15, trailing: 10)
            ),
            (
                NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 5),
                NSDirectionalEdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 15)
            ),
            (
                NSDirectionalEdgeInsets(top: -5, leading: 0, bottom: 0, trailing: 0),
                NSDirectionalEdgeInsets(top: 5, leading: 10, bottom: 10, trailing: 10)
            ),
            (
                NSDirectionalEdgeInsets(top: 1, leading: -2, bottom: 3, trailing: -4),
                NSDirectionalEdgeInsets(top: 11, leading: 8, bottom: 13, trailing: 6)
            ),
            (
                NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0),
                NSDirectionalEdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10)
            )
        ] as [(NSDirectionalEdgeInsets, NSDirectionalEdgeInsets)])
    func addsEachAmountToItsEdge(amounts: NSDirectionalEdgeInsets, expected: NSDirectionalEdgeInsets) {
        let insets = NSDirectionalEdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10)
        let result = insets.insetBy(
            top: amounts.top, leading: amounts.leading, bottom: amounts.bottom, trailing: amounts.trailing)
        #expect(result == expected)
    }

    @Test
    func leavesOmittedEdgesUnchanged() {
        let insets = NSDirectionalEdgeInsets(top: 1, leading: 2, bottom: 3, trailing: 4)
        #expect(insets.insetBy(top: 5) == NSDirectionalEdgeInsets(top: 6, leading: 2, bottom: 3, trailing: 4))
        #expect(insets.insetBy(leading: 5) == NSDirectionalEdgeInsets(top: 1, leading: 7, bottom: 3, trailing: 4))
        #expect(insets.insetBy(bottom: 5) == NSDirectionalEdgeInsets(top: 1, leading: 2, bottom: 8, trailing: 4))
        #expect(insets.insetBy(trailing: 5) == NSDirectionalEdgeInsets(top: 1, leading: 2, bottom: 3, trailing: 9))
    }

    @Test
    func composesAcrossCalls() {
        let insets = NSDirectionalEdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10).insetBy(bottom: 5).insetBy(
            leading: -2, trailing: -2)
        #expect(insets == NSDirectionalEdgeInsets(top: 10, leading: 8, bottom: 15, trailing: 8))
    }

    @Test
    func canProduceNegativeInsets() {
        #expect(
            NSDirectionalEdgeInsets().insetBy(top: -3)
                == NSDirectionalEdgeInsets(top: -3, leading: 0, bottom: 0, trailing: 0))
    }
}
#endif
