// UIEdgeInsets+InsetByTopLeftBottomRightTests.swift - Copyright 2026 SwifterSwift

#if canImport(UIKit)
import SwifterSwiftUIKit
import Testing
import UIKit

struct UIEdgeInsetsInsetByTopLeftBottomRightTests {
    @Test(
        arguments: [
            (
                UIEdgeInsets(top: 5, left: 0, bottom: 0, right: 0),
                UIEdgeInsets(top: 15, left: 10, bottom: 10, right: 10)
            ),
            (
                UIEdgeInsets(top: 0, left: 5, bottom: 0, right: 0),
                UIEdgeInsets(top: 10, left: 15, bottom: 10, right: 10)
            ),
            (
                UIEdgeInsets(top: 0, left: 0, bottom: 5, right: 0),
                UIEdgeInsets(top: 10, left: 10, bottom: 15, right: 10)
            ),
            (
                UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 5),
                UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 15)
            ),
            (
                UIEdgeInsets(top: -5, left: 0, bottom: 0, right: 0),
                UIEdgeInsets(top: 5, left: 10, bottom: 10, right: 10)
            ),
            (
                UIEdgeInsets(top: 1, left: -2, bottom: 3, right: -4),
                UIEdgeInsets(top: 11, left: 8, bottom: 13, right: 6)
            ),
            (UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0), UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10))
        ] as [(UIEdgeInsets, UIEdgeInsets)])
    func addsEachAmountToItsEdge(amounts: UIEdgeInsets, expected: UIEdgeInsets) {
        let insets = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        let result = insets.insetBy(top: amounts.top, left: amounts.left, bottom: amounts.bottom, right: amounts.right)
        #expect(result == expected)
    }

    @Test
    func leavesOmittedEdgesUnchanged() {
        let insets = UIEdgeInsets(top: 1, left: 2, bottom: 3, right: 4)
        #expect(insets.insetBy(top: 5) == UIEdgeInsets(top: 6, left: 2, bottom: 3, right: 4))
        #expect(insets.insetBy(left: 5) == UIEdgeInsets(top: 1, left: 7, bottom: 3, right: 4))
        #expect(insets.insetBy(bottom: 5) == UIEdgeInsets(top: 1, left: 2, bottom: 8, right: 4))
        #expect(insets.insetBy(right: 5) == UIEdgeInsets(top: 1, left: 2, bottom: 3, right: 9))
    }

    @Test
    func composesAcrossCalls() {
        let insets = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10).insetBy(bottom: 5).insetBy(
            left: -2, right: -2)
        #expect(insets == UIEdgeInsets(top: 10, left: 8, bottom: 15, right: 8))
    }

    @Test
    func canProduceNegativeInsets() {
        #expect(UIEdgeInsets().insetBy(top: -3) == UIEdgeInsets(top: -3, left: 0, bottom: 0, right: 0))
    }
}
#endif
