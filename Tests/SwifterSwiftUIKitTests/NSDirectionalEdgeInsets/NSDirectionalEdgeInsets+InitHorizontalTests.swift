// NSDirectionalEdgeInsets+InitHorizontalTests.swift - Copyright 2026 SwifterSwift

#if canImport(UIKit)
import SwifterSwiftUIKit
import Testing
import UIKit

struct NSDirectionalEdgeInsetsInitHorizontalTests {
    @Test
    func appliesEachValueInFullToBothOfItsEdges() {
        #expect(
            NSDirectionalEdgeInsets(horizontal: 16, vertical: 8)
                == NSDirectionalEdgeInsets(top: 8, leading: 16, bottom: 8, trailing: 16))
    }

    @Test
    func doesNotHalveTheValues() {
        let insets = NSDirectionalEdgeInsets(horizontal: 20, vertical: 10)
        #expect(insets.leading == 20)
        #expect(insets.trailing == 20)
        #expect(insets.top == 10)
        #expect(insets.bottom == 10)
    }

    @Test
    func defaultsTheMissingValueToZero() {
        #expect(
            NSDirectionalEdgeInsets(horizontal: 16)
                == NSDirectionalEdgeInsets(top: 0, leading: 16, bottom: 0, trailing: 16))
        #expect(
            NSDirectionalEdgeInsets(vertical: 8) == NSDirectionalEdgeInsets(top: 8, leading: 0, bottom: 8, trailing: 0))
    }

    @Test
    func acceptsNegativeAndFractionalValues() {
        #expect(
            NSDirectionalEdgeInsets(horizontal: -4, vertical: 0.5)
                == NSDirectionalEdgeInsets(top: 0.5, leading: -4, bottom: 0.5, trailing: -4))
    }

    @Test
    func leavesTheEmptyInitializerUnambiguous() {
        let insets = NSDirectionalEdgeInsets()
        #expect(insets == NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
    }
}
#endif
