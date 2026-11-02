// UIEdgeInsets+InsetByHorizontalVerticalTests.swift - Copyright 2026 SwifterSwift

#if canImport(UIKit)
import SwifterSwiftUIKit
import Testing
import UIKit

struct UIEdgeInsetsInsetByHorizontalVerticalTests {
    @Test
    func addsTheHorizontalAmountInFullToBothHorizontalEdges() {
        #expect(
            UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10).insetBy(horizontal: 5)
                == UIEdgeInsets(top: 10, left: 15, bottom: 10, right: 15))
    }

    @Test
    func addsTheVerticalAmountInFullToBothVerticalEdges() {
        #expect(
            UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10).insetBy(vertical: 5)
                == UIEdgeInsets(top: 15, left: 10, bottom: 15, right: 10))
    }

    @Test(
        arguments: [
            (CGFloat(4), CGFloat(-2), UIEdgeInsets(top: 8, left: 14, bottom: 8, right: 14)),
            (-5, -5, UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)),
            (-20, 0, UIEdgeInsets(top: 10, left: -10, bottom: 10, right: -10)),
            (0, 0, UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)),
            (0.5, 0.25, UIEdgeInsets(top: 10.25, left: 10.5, bottom: 10.25, right: 10.5))
        ] as [(CGFloat, CGFloat, UIEdgeInsets)])
    func addsBothAmounts(horizontal: CGFloat, vertical: CGFloat, expected: UIEdgeInsets) {
        #expect(
            UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10).insetBy(horizontal: horizontal, vertical: vertical)
                == expected)
    }

    @Test
    func keepsUnequalEdgesApart() {
        let insets = UIEdgeInsets(top: 1, left: 2, bottom: 3, right: 4)
        #expect(insets.insetBy(horizontal: 1, vertical: 1) == UIEdgeInsets(top: 2, left: 3, bottom: 4, right: 5))
    }
}
#endif
