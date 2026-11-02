// NSEdgeInsets+HorizontalTests.swift - Copyright 2026 SwifterSwift

#if canImport(AppKit) && !targetEnvironment(macCatalyst)
import Foundation
import SwifterSwiftAppKit
import Testing

struct NSEdgeInsetsHorizontalTests {
    @Test(
        arguments: [
            (NSEdgeInsets(top: 30, left: 5, bottom: 5, right: 10), 15),
            (NSEdgeInsets(), 0),
            (NSEdgeInsets(top: 1, left: -4, bottom: 1, right: 10), 6),
            (NSEdgeInsets(top: 0, left: -4, bottom: 0, right: -6), -10),
            (NSEdgeInsets(top: 0, left: 0.25, bottom: 0, right: 0.5), 0.75)
        ] as [(NSEdgeInsets, CGFloat)])
    func sumsTheHorizontalEdges(of insets: NSEdgeInsets, expected: CGFloat) {
        #expect(insets.horizontal == expected)
    }

    @Test
    func ignoresTheVerticalEdges() {
        #expect(NSEdgeInsets(top: 100, left: 0, bottom: 200, right: 0).horizontal == 0)
    }

    @Test
    func propagatesInfinityAndNaN() {
        let huge = NSEdgeInsets(top: 0, left: .greatestFiniteMagnitude, bottom: 0, right: .greatestFiniteMagnitude)
        #expect(huge.horizontal == .infinity)
        #expect(NSEdgeInsets(top: 0, left: .nan, bottom: 0, right: 1).horizontal.isNaN)
    }
}
#endif
