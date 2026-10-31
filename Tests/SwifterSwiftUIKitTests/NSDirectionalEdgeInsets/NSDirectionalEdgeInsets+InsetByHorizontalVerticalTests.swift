// NSDirectionalEdgeInsets+InsetByHorizontalVerticalTests.swift - Copyright 2026 SwifterSwift

#if canImport(UIKit)
import SwifterSwiftUIKit
import Testing
import UIKit

struct NSDirectionalEdgeInsetsInsetByHorizontalVerticalTests {
    @Test
    func addsTheHorizontalAmountInFullToBothHorizontalEdges() {
        // SwifterSwift 8 split the amount between the two edges, giving 12.5 here.
        #expect(
            NSDirectionalEdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10).insetBy(horizontal: 5)
                == NSDirectionalEdgeInsets(top: 10, leading: 15, bottom: 10, trailing: 15))
    }

    @Test
    func addsTheVerticalAmountInFullToBothVerticalEdges() {
        #expect(
            NSDirectionalEdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10).insetBy(vertical: 5)
                == NSDirectionalEdgeInsets(top: 15, leading: 10, bottom: 15, trailing: 10))
    }

    @Test(
        arguments: [
            (CGFloat(4), CGFloat(-2), NSDirectionalEdgeInsets(top: 8, leading: 14, bottom: 8, trailing: 14)),
            (-5, -5, NSDirectionalEdgeInsets(top: 5, leading: 5, bottom: 5, trailing: 5)),
            (-20, 0, NSDirectionalEdgeInsets(top: 10, leading: -10, bottom: 10, trailing: -10)),
            (0, 0, NSDirectionalEdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10)),
            (0.5, 0.25, NSDirectionalEdgeInsets(top: 10.25, leading: 10.5, bottom: 10.25, trailing: 10.5))
        ] as [(CGFloat, CGFloat, NSDirectionalEdgeInsets)])
    func addsBothAmounts(horizontal: CGFloat, vertical: CGFloat, expected: NSDirectionalEdgeInsets) {
        #expect(
            NSDirectionalEdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10).insetBy(
                horizontal: horizontal, vertical: vertical) == expected)
    }

    @Test
    func keepsUnequalEdgesApart() {
        let insets = NSDirectionalEdgeInsets(top: 1, leading: 2, bottom: 3, trailing: 4)
        #expect(
            insets.insetBy(horizontal: 1, vertical: 1)
                == NSDirectionalEdgeInsets(top: 2, leading: 3, bottom: 4, trailing: 5))
    }
}
#endif
