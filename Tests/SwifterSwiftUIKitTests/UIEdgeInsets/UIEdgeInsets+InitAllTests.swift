// UIEdgeInsets+InitAllTests.swift - Copyright 2026 SwifterSwift

#if canImport(UIKit)
import SwifterSwiftUIKit
import Testing
import UIKit

struct UIEdgeInsetsInitAllTests {
    @Test(arguments: [0, 8, -4, 0.5, CGFloat.greatestFiniteMagnitude, -CGFloat.infinity])
    func setsTheSameValueOnEveryEdge(_ inset: CGFloat) {
        let insets = UIEdgeInsets(all: inset)
        #expect(insets == UIEdgeInsets(top: inset, left: inset, bottom: inset, right: inset))
    }

    @Test
    func matchesZeroForZero() {
        #expect(UIEdgeInsets(all: 0) == UIEdgeInsets())
    }

    @Test
    func keepsNaN() {
        let insets = UIEdgeInsets(all: .nan)
        #expect(insets.top.isNaN && insets.left.isNaN && insets.bottom.isNaN && insets.right.isNaN)
    }
}
#endif
