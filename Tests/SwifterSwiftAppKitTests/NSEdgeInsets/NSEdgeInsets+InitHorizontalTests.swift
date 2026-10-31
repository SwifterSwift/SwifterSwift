// NSEdgeInsets+InitHorizontalTests.swift - Copyright 2026 SwifterSwift

#if canImport(AppKit) && !targetEnvironment(macCatalyst)
import Foundation
import SwifterSwiftAppKit
import Testing

struct NSEdgeInsetsInitHorizontalTests {
    @Test
    func appliesEachValueInFullToBothOfItsEdges() {
        #expect(
            NSEdgeInsetsEqual(
                NSEdgeInsets(horizontal: 16, vertical: 8), NSEdgeInsets(top: 8, left: 16, bottom: 8, right: 16)))
    }

    @Test
    func doesNotHalveTheValues() {
        let insets = NSEdgeInsets(horizontal: 20, vertical: 10)
        #expect(insets.left == 20)
        #expect(insets.right == 20)
        #expect(insets.top == 10)
        #expect(insets.bottom == 10)
    }

    @Test
    func defaultsTheMissingValueToZero() {
        #expect(NSEdgeInsetsEqual(NSEdgeInsets(horizontal: 16), NSEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)))
        #expect(NSEdgeInsetsEqual(NSEdgeInsets(vertical: 8), NSEdgeInsets(top: 8, left: 0, bottom: 8, right: 0)))
    }

    @Test
    func acceptsNegativeAndFractionalValues() {
        #expect(
            NSEdgeInsetsEqual(
                NSEdgeInsets(horizontal: -4, vertical: 0.5), NSEdgeInsets(top: 0.5, left: -4, bottom: 0.5, right: -4)))
    }

    @Test
    func leavesTheEmptyInitializerUnambiguous() {
        let insets = NSEdgeInsets()
        #expect(NSEdgeInsetsEqual(insets, NSEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)))
    }
}
#endif
