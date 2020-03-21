//
//  CATransform3DExtensionsTests.swift
//  SwifterSwift
//
//  Created by Guy Kogus on 19/3/20.
//  Copyright © 2020 SwifterSwift
//

import XCTest
@testable import SwifterSwift

#if canImport(QuartzCore)

#if canImport(CoreGraphics)
import CoreGraphics
#endif

// swiftlint:disable identifier_name

final class CATransform3DExtensionsTests: XCTestCase {

    let x = CGFloat(5)
    let y = CGFloat(10)
    let z = CGFloat(20)
    let angle = CGFloat.pi / 3

    var translation: CATransform3D { CATransform3DMakeTranslation(x, y, z) }
    var scale: CATransform3D { CATransform3DMakeScale(x, y, z) }
    var rotation: CATransform3D { CATransform3DMakeRotation(angle, x, y, z) }

    func testIdentity() {
        XCTAssertEqual(CATransform3D.identity, CATransform3DIdentity)
        XCTAssertNotEqual(translation, CATransform3D.identity)
        XCTAssertNotEqual(scale, CATransform3D.identity)
        XCTAssertNotEqual(rotation, CATransform3D.identity)
    }

    func testIsIdentity() {
        XCTAssert(CATransform3DIdentity.isIdentity)
        XCTAssertFalse(translation.isIdentity)
        XCTAssertFalse(scale.isIdentity)
        XCTAssertFalse(rotation.isIdentity)
    }

    func testInitTranslation() {
        XCTAssertEqual(CATransform3D(translation: x, y, z), translation)
    }

    func testInitScale() {
        XCTAssertEqual(CATransform3D(scale: x, y, z), scale)
    }

    func testInitRotation() {
        XCTAssertEqual(CATransform3D(rotation: angle, x, y, z), rotation)
    }

    func testTranslated() {
        XCTAssertEqual(CATransform3DIdentity.translated(tx: x, ty: y, tz: z), translation)
    }

    func testScaled() {
        XCTAssertEqual(CATransform3DIdentity.scaled(sx: x, sy: y, sz: z), scale)
    }

    func testRotated() {
        XCTAssertEqual(CATransform3DIdentity.rotated(angle: angle, x: x, y: y, z: z), rotation)
    }

    func testConcatenated() {
        XCTAssertEqual(CATransform3DIdentity.concatenated(transform: translation), translation)
        XCTAssertEqual(CATransform3DIdentity.concatenated(transform: scale), scale)
        XCTAssertEqual(CATransform3DIdentity.concatenated(transform: rotation), rotation)
    }

    func testInverted() {
        XCTAssertEqual(CATransform3DIdentity, CATransform3DIdentity.inverted())
        XCTAssertEqual(translation.inverted(), CATransform3DInvert(translation))
        XCTAssertEqual(scale.inverted(), CATransform3DInvert(scale))
        XCTAssertEqual(rotation.inverted(), CATransform3DInvert(rotation))
    }

    func testTranslate() {
        var transform = CATransform3DIdentity
        transform.translate(tx: x, ty: y, tz: z)
        XCTAssertEqual(transform, translation)
    }

    func testScale() {
        var transform = CATransform3DIdentity
        transform.scale(sx: x, sy: y, sz: z)
        XCTAssertEqual(transform, scale)
    }

    func testRotate() {
        var transform = CATransform3DIdentity
        transform.rotate(angle: angle, x: x, y: y, z: z)
        XCTAssertEqual(transform, rotation)
    }

    func testConcatenate() {
        var transform = CATransform3DIdentity
        transform.concatenate(transform: translation)
        XCTAssertEqual(transform, translation)

        transform = CATransform3DIdentity
        transform.concatenate(transform: scale)
        XCTAssertEqual(transform, scale)

        transform = CATransform3DIdentity
        transform.concatenate(transform: rotation)
        XCTAssertEqual(transform, rotation)
    }

    func testInvert() {
        var transform = CATransform3DIdentity
        transform.invert()
        XCTAssertEqual(transform, CATransform3DIdentity)

        transform = translation
        transform.invert()
        XCTAssertEqual(transform, CATransform3DInvert(translation))

        transform = scale
        transform.invert()
        XCTAssertEqual(transform, CATransform3DInvert(scale))

        transform = rotation
        transform.invert()
        XCTAssertEqual(transform, CATransform3DInvert(rotation))
    }

    #if canImport(CoreGraphics)

    func testIsAffine() {
        XCTAssert(CATransform3DIdentity.isAffine)
        XCTAssertFalse(CATransform3DMakeTranslation(0, 0, 1).isAffine)
    }

    func testAffineTransform() {
        XCTAssertEqual(CATransform3DIdentity.affineTransform(), CGAffineTransform.identity)
        XCTAssertEqual(CATransform3DMakeTranslation(x, y, 1).affineTransform(), CGAffineTransform(translationX: x, y: y))
    }

    #endif

}

// swiftlint:enable identifier_name

#endif
