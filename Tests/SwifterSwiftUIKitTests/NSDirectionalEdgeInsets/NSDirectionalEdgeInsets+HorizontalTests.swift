// NSDirectionalEdgeInsets+HorizontalTests.swift - Copyright 2026 SwifterSwift

#if canImport(UIKit)
import SwifterSwiftUIKit
import Testing
import UIKit

struct NSDirectionalEdgeInsetsHorizontalTests {
    @Test(
        arguments: [
            (NSDirectionalEdgeInsets(top: 30, leading: 5, bottom: 5, trailing: 10), 15),
            (NSDirectionalEdgeInsets(), 0),
            (NSDirectionalEdgeInsets(top: 1, leading: -4, bottom: 1, trailing: 10), 6),
            (NSDirectionalEdgeInsets(top: 0, leading: -4, bottom: 0, trailing: -6), -10),
            (NSDirectionalEdgeInsets(top: 0, leading: 0.25, bottom: 0, trailing: 0.5), 0.75)
        ] as [(NSDirectionalEdgeInsets, CGFloat)])
    func sumsTheHorizontalEdges(of insets: NSDirectionalEdgeInsets, expected: CGFloat) {
        #expect(insets.horizontal == expected)
    }

    @Test
    func ignoresTheVerticalEdges() {
        #expect(NSDirectionalEdgeInsets(top: 100, leading: 0, bottom: 200, trailing: 0).horizontal == 0)
    }

    @Test
    func propagatesInfinityAndNaN() {
        let huge = NSDirectionalEdgeInsets(
            top: 0, leading: .greatestFiniteMagnitude, bottom: 0, trailing: .greatestFiniteMagnitude)
        #expect(huge.horizontal == .infinity)
        #expect(NSDirectionalEdgeInsets(top: 0, leading: .nan, bottom: 0, trailing: 1).horizontal.isNaN)
    }
}
#endif
