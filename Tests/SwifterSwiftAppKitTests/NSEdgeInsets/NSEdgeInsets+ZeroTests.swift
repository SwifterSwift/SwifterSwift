// NSEdgeInsets+ZeroTests.swift - Copyright 2026 SwifterSwift

#if canImport(AppKit) && !targetEnvironment(macCatalyst)
import Foundation
import SwifterSwiftAppKit
import Testing

struct NSEdgeInsetsZeroTests {
    @Test
    func hasAllEdgesSetToZero() {
        let insets = NSEdgeInsets.zero
        #expect(insets.top == 0)
        #expect(insets.left == 0)
        #expect(insets.bottom == 0)
        #expect(insets.right == 0)
    }

    @Test
    func matchesTheFoundationConstant() {
        #expect(NSEdgeInsetsEqual(NSEdgeInsets.zero, NSEdgeInsetsZero))
        #expect(NSEdgeInsetsEqual(NSEdgeInsets.zero, NSEdgeInsets()))
    }

    @Test
    func worksWithImplicitMemberSyntax() {
        let insets: NSEdgeInsets = .zero
        #expect(NSEdgeInsetsEqual(insets, NSEdgeInsetsZero))
    }
}
#endif
