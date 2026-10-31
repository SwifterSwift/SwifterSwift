// NSDirectionalEdgeInsets+InitAllTests.swift - Copyright 2026 SwifterSwift

#if canImport(UIKit)
import SwifterSwiftUIKit
import Testing
import UIKit

struct NSDirectionalEdgeInsetsInitAllTests {
    @Test(arguments: [0, 8, -4, 0.5, CGFloat.greatestFiniteMagnitude, -CGFloat.infinity])
    func setsTheSameValueOnEveryEdge(_ inset: CGFloat) {
        let insets = NSDirectionalEdgeInsets(all: inset)
        #expect(insets == NSDirectionalEdgeInsets(top: inset, leading: inset, bottom: inset, trailing: inset))
    }

    @Test
    func matchesZeroForZero() {
        #expect(NSDirectionalEdgeInsets(all: 0) == NSDirectionalEdgeInsets())
    }

    @Test
    func keepsNaN() {
        let insets = NSDirectionalEdgeInsets(all: .nan)
        #expect(insets.top.isNaN && insets.leading.isNaN && insets.bottom.isNaN && insets.trailing.isNaN)
    }
}
#endif
