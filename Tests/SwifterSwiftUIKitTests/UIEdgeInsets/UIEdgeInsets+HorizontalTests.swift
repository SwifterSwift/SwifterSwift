// UIEdgeInsets+HorizontalTests.swift - Copyright 2026 SwifterSwift

#if canImport(UIKit)
import SwifterSwiftUIKit
import Testing
import UIKit

struct UIEdgeInsetsHorizontalTests {
    @Test(
        arguments: [
            (UIEdgeInsets(top: 30, left: 5, bottom: 5, right: 10), 15),
            (UIEdgeInsets(), 0),
            (UIEdgeInsets(top: 1, left: -4, bottom: 1, right: 10), 6),
            (UIEdgeInsets(top: 0, left: -4, bottom: 0, right: -6), -10),
            (UIEdgeInsets(top: 0, left: 0.25, bottom: 0, right: 0.5), 0.75)
        ] as [(UIEdgeInsets, CGFloat)])
    func sumsTheHorizontalEdges(of insets: UIEdgeInsets, expected: CGFloat) {
        #expect(insets.horizontal == expected)
    }

    @Test
    func ignoresTheVerticalEdges() {
        #expect(UIEdgeInsets(top: 100, left: 0, bottom: 200, right: 0).horizontal == 0)
    }

    @Test
    func propagatesInfinityAndNaN() {
        let huge = UIEdgeInsets(top: 0, left: .greatestFiniteMagnitude, bottom: 0, right: .greatestFiniteMagnitude)
        #expect(huge.horizontal == .infinity)
        #expect(UIEdgeInsets(top: 0, left: .nan, bottom: 0, right: 1).horizontal.isNaN)
    }
}
#endif
