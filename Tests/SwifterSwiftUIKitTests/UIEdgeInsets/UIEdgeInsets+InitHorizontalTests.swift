// UIEdgeInsets+InitHorizontalTests.swift - Copyright 2026 SwifterSwift

#if canImport(UIKit)
import SwifterSwiftUIKit
import Testing
import UIKit

struct UIEdgeInsetsInitHorizontalTests {
    @Test
    func appliesEachValueInFullToBothOfItsEdges() {
        #expect(UIEdgeInsets(horizontal: 16, vertical: 8) == UIEdgeInsets(top: 8, left: 16, bottom: 8, right: 16))
    }

    @Test
    func doesNotHalveTheValues() {
        let insets = UIEdgeInsets(horizontal: 20, vertical: 10)
        #expect(insets.left == 20)
        #expect(insets.right == 20)
        #expect(insets.top == 10)
        #expect(insets.bottom == 10)
    }

    @Test
    func defaultsTheMissingValueToZero() {
        #expect(UIEdgeInsets(horizontal: 16) == UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16))
        #expect(UIEdgeInsets(vertical: 8) == UIEdgeInsets(top: 8, left: 0, bottom: 8, right: 0))
    }

    @Test
    func acceptsNegativeAndFractionalValues() {
        #expect(UIEdgeInsets(horizontal: -4, vertical: 0.5) == UIEdgeInsets(top: 0.5, left: -4, bottom: 0.5, right: -4))
    }

    @Test
    func leavesTheEmptyInitializerUnambiguous() {
        let insets = UIEdgeInsets()
        #expect(insets == UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0))
    }
}
#endif
