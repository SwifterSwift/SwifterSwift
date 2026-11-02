// NSDirectionalEdgeInsets+VerticalTests.swift - Copyright 2026 SwifterSwift

#if canImport(UIKit)
import SwifterSwiftUIKit
import Testing
import UIKit

struct NSDirectionalEdgeInsetsVerticalTests {
    @Test(
        arguments: [
            (NSDirectionalEdgeInsets(top: 10, leading: 10, bottom: 5, trailing: 10), 15),
            (NSDirectionalEdgeInsets(), 0),
            (NSDirectionalEdgeInsets(top: -4, leading: 1, bottom: 10, trailing: 1), 6),
            (NSDirectionalEdgeInsets(top: -4, leading: 0, bottom: -6, trailing: 0), -10),
            (NSDirectionalEdgeInsets(top: 0.25, leading: 0, bottom: 0.5, trailing: 0), 0.75)
        ] as [(NSDirectionalEdgeInsets, CGFloat)])
    func sumsTheVerticalEdges(of insets: NSDirectionalEdgeInsets, expected: CGFloat) {
        #expect(insets.vertical == expected)
    }

    @Test
    func ignoresTheHorizontalEdges() {
        #expect(NSDirectionalEdgeInsets(top: 0, leading: 100, bottom: 0, trailing: 200).vertical == 0)
    }

    @Test
    func propagatesInfinityAndNaN() {
        let huge = NSDirectionalEdgeInsets(
            top: .greatestFiniteMagnitude, leading: 0, bottom: .greatestFiniteMagnitude, trailing: 0)
        #expect(huge.vertical == .infinity)
        #expect(NSDirectionalEdgeInsets(top: .nan, leading: 0, bottom: 1, trailing: 0).vertical.isNaN)
    }
}
#endif
