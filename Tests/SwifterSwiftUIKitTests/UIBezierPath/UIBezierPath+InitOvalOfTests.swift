// UIBezierPath+InitOvalOfTests.swift - Copyright 2026 SwifterSwift

#if canImport(UIKit)
import CoreGraphics
import SwifterSwiftUIKit
import Testing
import UIKit

struct UIBezierPathInitOvalOfTests {
    @Test
    func centersOvalOnOrigin() {
        let size = CGSize(width: 100, height: 50)
        let path = UIBezierPath(ovalOf: size, centered: true)
        #expect(path.cgPath == UIBezierPath(ovalIn: CGRect(x: -50, y: -25, width: 100, height: 50)).cgPath)
        #expect(path.bounds == CGRect(x: -50, y: -25, width: 100, height: 50))
        #expect(path.contains(.zero))
    }

    @Test
    func putsTopLeftCornerOnOriginWhenNotCentered() {
        let size = CGSize(width: 100, height: 50)
        let path = UIBezierPath(ovalOf: size, centered: false)
        #expect(path.cgPath == UIBezierPath(ovalIn: CGRect(origin: .zero, size: size)).cgPath)
        #expect(path.bounds == CGRect(x: 0, y: 0, width: 100, height: 50))
        #expect(path.contains(CGPoint(x: 50, y: 25)))
        #expect(!path.contains(CGPoint(x: 1, y: 1)))
    }

    @Test
    func drawsACircleForEqualSides() {
        let path = UIBezierPath(ovalOf: CGSize(width: 20, height: 20), centered: true)
        #expect(path.contains(CGPoint(x: 9.9, y: 0)))
        #expect(path.contains(CGPoint(x: 0, y: -9.9)))
        #expect(!path.contains(CGPoint(x: 8, y: 8)))
    }

    @Test(arguments: [true, false])
    func handlesZeroSize(centered: Bool) {
        let path = UIBezierPath(ovalOf: .zero, centered: centered)
        #expect(path.bounds.size == .zero)
    }
}
#endif
