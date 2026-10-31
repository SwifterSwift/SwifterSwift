// NSEdgeInsets+VerticalTests.swift - Copyright 2026 SwifterSwift

#if canImport(AppKit) && !targetEnvironment(macCatalyst)
import Foundation
import SwifterSwiftAppKit
import Testing

struct NSEdgeInsetsVerticalTests {
    @Test(
        arguments: [
            (NSEdgeInsets(top: 10, left: 10, bottom: 5, right: 10), 15),
            (NSEdgeInsets(), 0),
            (NSEdgeInsets(top: -4, left: 1, bottom: 10, right: 1), 6),
            (NSEdgeInsets(top: -4, left: 0, bottom: -6, right: 0), -10),
            (NSEdgeInsets(top: 0.25, left: 0, bottom: 0.5, right: 0), 0.75)
        ] as [(NSEdgeInsets, CGFloat)])
    func sumsTheVerticalEdges(of insets: NSEdgeInsets, expected: CGFloat) {
        #expect(insets.vertical == expected)
    }

    @Test
    func ignoresTheHorizontalEdges() {
        #expect(NSEdgeInsets(top: 0, left: 100, bottom: 0, right: 200).vertical == 0)
    }

    @Test
    func propagatesInfinityAndNaN() {
        let huge = NSEdgeInsets(top: .greatestFiniteMagnitude, left: 0, bottom: .greatestFiniteMagnitude, right: 0)
        #expect(huge.vertical == .infinity)
        #expect(NSEdgeInsets(top: .nan, left: 0, bottom: 1, right: 0).vertical.isNaN)
    }
}
#endif
