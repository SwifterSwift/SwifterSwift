// NSEdgeInsets+InsetByTopLeftBottomRightTests.swift - Copyright 2026 SwifterSwift

#if canImport(AppKit) && !targetEnvironment(macCatalyst)
import Foundation
import SwifterSwiftAppKit
import Testing

struct NSEdgeInsetsInsetByTopLeftBottomRightTests {
    @Test(
        arguments: [
            (
                NSEdgeInsets(top: 5, left: 0, bottom: 0, right: 0),
                NSEdgeInsets(top: 15, left: 10, bottom: 10, right: 10)
            ),
            (
                NSEdgeInsets(top: 0, left: 5, bottom: 0, right: 0),
                NSEdgeInsets(top: 10, left: 15, bottom: 10, right: 10)
            ),
            (
                NSEdgeInsets(top: 0, left: 0, bottom: 5, right: 0),
                NSEdgeInsets(top: 10, left: 10, bottom: 15, right: 10)
            ),
            (
                NSEdgeInsets(top: 0, left: 0, bottom: 0, right: 5),
                NSEdgeInsets(top: 10, left: 10, bottom: 10, right: 15)
            ),
            (
                NSEdgeInsets(top: -5, left: 0, bottom: 0, right: 0),
                NSEdgeInsets(top: 5, left: 10, bottom: 10, right: 10)
            ),
            (
                NSEdgeInsets(top: 1, left: -2, bottom: 3, right: -4),
                NSEdgeInsets(top: 11, left: 8, bottom: 13, right: 6)
            ),
            (NSEdgeInsets(top: 0, left: 0, bottom: 0, right: 0), NSEdgeInsets(top: 10, left: 10, bottom: 10, right: 10))
        ] as [(NSEdgeInsets, NSEdgeInsets)])
    func addsEachAmountToItsEdge(amounts: NSEdgeInsets, expected: NSEdgeInsets) {
        let insets = NSEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        let result = insets.insetBy(top: amounts.top, left: amounts.left, bottom: amounts.bottom, right: amounts.right)
        #expect(NSEdgeInsetsEqual(result, expected))
    }

    @Test
    func leavesOmittedEdgesUnchanged() {
        let insets = NSEdgeInsets(top: 1, left: 2, bottom: 3, right: 4)
        #expect(NSEdgeInsetsEqual(insets.insetBy(top: 5), NSEdgeInsets(top: 6, left: 2, bottom: 3, right: 4)))
        #expect(NSEdgeInsetsEqual(insets.insetBy(left: 5), NSEdgeInsets(top: 1, left: 7, bottom: 3, right: 4)))
        #expect(NSEdgeInsetsEqual(insets.insetBy(bottom: 5), NSEdgeInsets(top: 1, left: 2, bottom: 8, right: 4)))
        #expect(NSEdgeInsetsEqual(insets.insetBy(right: 5), NSEdgeInsets(top: 1, left: 2, bottom: 3, right: 9)))
    }

    @Test
    func composesAcrossCalls() {
        let insets = NSEdgeInsets(top: 10, left: 10, bottom: 10, right: 10).insetBy(bottom: 5).insetBy(
            left: -2, right: -2)
        #expect(NSEdgeInsetsEqual(insets, NSEdgeInsets(top: 10, left: 8, bottom: 15, right: 8)))
    }

    @Test
    func canProduceNegativeInsets() {
        #expect(NSEdgeInsetsEqual(NSEdgeInsets().insetBy(top: -3), NSEdgeInsets(top: -3, left: 0, bottom: 0, right: 0)))
    }
}
#endif
