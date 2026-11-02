// NSEdgeInsets+InitAllTests.swift - Copyright 2026 SwifterSwift

#if canImport(AppKit) && !targetEnvironment(macCatalyst)
import Foundation
import SwifterSwiftAppKit
import Testing

struct NSEdgeInsetsInitAllTests {
    @Test(arguments: [0, 8, -4, 0.5, CGFloat.greatestFiniteMagnitude, -CGFloat.infinity])
    func setsTheSameValueOnEveryEdge(_ inset: CGFloat) {
        let insets = NSEdgeInsets(all: inset)
        #expect(NSEdgeInsetsEqual(insets, NSEdgeInsets(top: inset, left: inset, bottom: inset, right: inset)))
    }

    @Test
    func matchesZeroForZero() {
        #expect(NSEdgeInsetsEqual(NSEdgeInsets(all: 0), NSEdgeInsets()))
    }

    @Test
    func keepsNaN() {
        let insets = NSEdgeInsets(all: .nan)
        #expect(insets.top.isNaN && insets.left.isNaN && insets.bottom.isNaN && insets.right.isNaN)
    }
}
#endif
