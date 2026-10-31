// UIEdgeInsets+VerticalTests.swift - Copyright 2026 SwifterSwift

#if canImport(UIKit)
import SwifterSwiftUIKit
import Testing
import UIKit

struct UIEdgeInsetsVerticalTests {
    @Test(
        arguments: [
            (UIEdgeInsets(top: 10, left: 10, bottom: 5, right: 10), 15),
            (UIEdgeInsets(), 0),
            (UIEdgeInsets(top: -4, left: 1, bottom: 10, right: 1), 6),
            (UIEdgeInsets(top: -4, left: 0, bottom: -6, right: 0), -10),
            (UIEdgeInsets(top: 0.25, left: 0, bottom: 0.5, right: 0), 0.75)
        ] as [(UIEdgeInsets, CGFloat)])
    func sumsTheVerticalEdges(of insets: UIEdgeInsets, expected: CGFloat) {
        #expect(insets.vertical == expected)
    }

    @Test
    func ignoresTheHorizontalEdges() {
        #expect(UIEdgeInsets(top: 0, left: 100, bottom: 0, right: 200).vertical == 0)
    }

    @Test
    func propagatesInfinityAndNaN() {
        let huge = UIEdgeInsets(top: .greatestFiniteMagnitude, left: 0, bottom: .greatestFiniteMagnitude, right: 0)
        #expect(huge.vertical == .infinity)
        #expect(UIEdgeInsets(top: .nan, left: 0, bottom: 1, right: 0).vertical.isNaN)
    }
}
#endif
