// UIView+AddBottomSeparatorTests.swift - Copyright 2026 SwifterSwift

#if canImport(UIKit) && !os(watchOS)
import SwifterSwiftUIKit
import Testing
import UIKit

@MainActor
struct UIViewAddBottomSeparatorTests {
    @Test
    func addsLineAlongBottomEdge() {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: 320, height: 44))
        let line = view.addBottomSeparator()
        view.layoutIfNeeded()
        #expect(view.subviews == [line])
        #expect(line.frame == CGRect(x: 0, y: 43, width: 320, height: 1))
        #expect(line.backgroundColor == .separator)
        #expect(line.layer.cornerRadius == 0.5)
    }

    @Test(arguments: [0, 4, 10])
    func placesLineAboveBottomEdgeBySpacing(_ spacing: CGFloat) {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: 320, height: 44))
        let line = view.addBottomSeparator(color: .red, height: 2, spacing: spacing)
        view.layoutIfNeeded()
        #expect(line.frame.maxY == 44 - spacing)
        #expect(line.frame.height == 2)
        #expect(view.bounds.contains(line.frame))
        #expect(line.backgroundColor == .red)
        #expect(line.layer.cornerRadius == 1)
    }

    @Test
    func followsViewWhenItResizes() {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: 320, height: 44))
        let line = view.addBottomSeparator(spacing: 4)
        view.frame.size = CGSize(width: 100, height: 80)
        view.layoutIfNeeded()
        #expect(line.frame == CGRect(x: 0, y: 75, width: 100, height: 1))
    }

    @Test
    func eachCallAddsAnotherLine() {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: 320, height: 44))
        let first = view.addBottomSeparator()
        let second = view.addBottomSeparator(spacing: 8)
        #expect(view.subviews == [first, second])
        #expect(!first.translatesAutoresizingMaskIntoConstraints)
        #expect(view.translatesAutoresizingMaskIntoConstraints)
    }
}
#endif
