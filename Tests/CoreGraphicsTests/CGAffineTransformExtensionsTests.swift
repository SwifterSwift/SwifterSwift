// CGAffineTransformExtensionsTests.swift - Copyright 2024 SwifterSwift

@testable import SwifterSwift
import XCTest

#if canImport(CoreGraphics)
import CoreGraphics

#if canImport(QuartzCore) && !os(watchOS)
import QuartzCore

final class CGAffineTransformExtensionsTests: XCTestCase {
    func testTransform3D() {
        XCTAssertEqual(CGAffineTransform.identity.transform3D(), CATransform3DIdentity)

        let x = CGFloat(5)
        let y = CGFloat(10)
        let angle = CGFloat.pi / 3

        XCTAssertEqual(CGAffineTransform(translationX: x, y: y).transform3D(), CATransform3DMakeTranslation(x, y, 0))
        XCTAssertEqual(CGAffineTransform(scaleX: x, y: y).transform3D(), CATransform3DMakeScale(x, y, 1))
        XCTAssertEqual(CGAffineTransform(rotationAngle: angle).transform3D(), CATransform3DMakeRotation(angle, 0, 0, 1))
    }
}

#endif

#endif
