// UIBezierPath+InitRectOfTests.swift - Copyright 2026 SwifterSwift

#if canImport(UIKit)
import CoreGraphics
import SwifterSwiftUIKit
import Testing
import UIKit

struct UIBezierPathInitRectOfTests {
    @Test
    func centersRectOnOrigin() {
        let size = CGSize(width: 100, height: 50)
        let path = UIBezierPath(rectOf: size, centered: true)
        #expect(path.cgPath == UIBezierPath(rect: CGRect(x: -50, y: -25, width: 100, height: 50)).cgPath)
        #expect(path.bounds == CGRect(x: -50, y: -25, width: 100, height: 50))
        #expect(path.contains(CGPoint(x: -49, y: -24)))
    }

    @Test
    func putsTopLeftCornerOnOriginWhenNotCentered() {
        let size = CGSize(width: 100, height: 50)
        let path = UIBezierPath(rectOf: size, centered: false)
        #expect(path.cgPath == UIBezierPath(rect: CGRect(origin: .zero, size: size)).cgPath)
        #expect(path.bounds == CGRect(x: 0, y: 0, width: 100, height: 50))
        #expect(path.contains(CGPoint(x: 1, y: 1)))
        #expect(!path.contains(CGPoint(x: -1, y: -1)))
    }

    @Test
    func centersOddSizesOnHalfPoints() {
        let path = UIBezierPath(rectOf: CGSize(width: 3, height: 5), centered: true)
        #expect(path.bounds == CGRect(x: -1.5, y: -2.5, width: 3, height: 5))
    }

    @Test(arguments: [true, false])
    func handlesZeroSize(centered: Bool) {
        let path = UIBezierPath(rectOf: .zero, centered: centered)
        #expect(path.bounds.size == .zero)
    }
}
#endif
