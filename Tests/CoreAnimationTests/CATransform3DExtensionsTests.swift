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

    func testCodable() {
        let transform = translation.concatenating(scale).concatenating(rotation)

        let encoder = JSONEncoder()
        var data: Data?
        XCTAssertNoThrow(data = try encoder.encode(transform))
        XCTAssert(data?.isEmpty == false)

        let decoder = JSONDecoder()
        var decodedTransform: CATransform3D?
        XCTAssertNoThrow(decodedTransform = try decoder.decode(CATransform3D.self, from: data!))

        let accuracy = CGFloat(0.000001)
        XCTAssertEqual(transform.m11, decodedTransform!.m11, accuracy: accuracy)
        XCTAssertEqual(transform.m12, decodedTransform!.m12, accuracy: accuracy)
        XCTAssertEqual(transform.m13, decodedTransform!.m13, accuracy: accuracy)
        XCTAssertEqual(transform.m14, decodedTransform!.m14, accuracy: accuracy)
        XCTAssertEqual(transform.m21, decodedTransform!.m21, accuracy: accuracy)
        XCTAssertEqual(transform.m22, decodedTransform!.m22, accuracy: accuracy)
        XCTAssertEqual(transform.m23, decodedTransform!.m23, accuracy: accuracy)
        XCTAssertEqual(transform.m24, decodedTransform!.m24, accuracy: accuracy)
        XCTAssertEqual(transform.m31, decodedTransform!.m31, accuracy: accuracy)
        XCTAssertEqual(transform.m32, decodedTransform!.m32, accuracy: accuracy)
        XCTAssertEqual(transform.m33, decodedTransform!.m33, accuracy: accuracy)
        XCTAssertEqual(transform.m34, decodedTransform!.m34, accuracy: accuracy)
        XCTAssertEqual(transform.m41, decodedTransform!.m41, accuracy: accuracy)
        XCTAssertEqual(transform.m42, decodedTransform!.m42, accuracy: accuracy)
        XCTAssertEqual(transform.m43, decodedTransform!.m43, accuracy: accuracy)
        XCTAssertEqual(transform.m44, decodedTransform!.m44, accuracy: accuracy)
    }

    func testInitTranslation() {
        XCTAssertEqual(CATransform3D(translationX: x, y: y, z: z), translation)
    }

    func testInitScale() {
        XCTAssertEqual(CATransform3D(scaleX: x, y: y, z: z), scale)
    }

    func testInitRotation() {
        XCTAssertEqual(CATransform3D(rotationAngle: angle, x: x, y: y, z: z), rotation)
    }

    func testIsIdentity() {
        XCTAssert(CATransform3DIdentity.isIdentity)
        XCTAssertFalse(translation.isIdentity)
        XCTAssertFalse(scale.isIdentity)
        XCTAssertFalse(rotation.isIdentity)
    }

    func testTranslated() {
        XCTAssertEqual(CATransform3DIdentity.translatedBy(x: x, y: y, z: z), translation)
    }

    func testScaled() {
        XCTAssertEqual(CATransform3DIdentity.scaledBy(x: x, y: y, z: z), scale)
    }

    func testRotated() {
        XCTAssertEqual(CATransform3DIdentity.rotated(by: angle, x: x, y: y, z: z), rotation)
    }

    func testInverted() {
        XCTAssertEqual(CATransform3DIdentity, CATransform3DIdentity.inverted())
        XCTAssertEqual(translation.inverted(), CATransform3DInvert(translation))
        XCTAssertEqual(scale.inverted(), CATransform3DInvert(scale))
        XCTAssertEqual(rotation.inverted(), CATransform3DInvert(rotation))
    }

    func testConcatenated() {
        XCTAssertEqual(CATransform3DIdentity.concatenating(translation), translation)
        XCTAssertEqual(CATransform3DIdentity.concatenating(scale), scale)
        XCTAssertEqual(CATransform3DIdentity.concatenating(rotation), rotation)
    }

    func testTranslate() {
        var transform = CATransform3DIdentity
        transform.translateBy(x: x, y: y, z: z)
        XCTAssertEqual(transform, translation)
    }

    func testScale() {
        var transform = CATransform3DIdentity
        transform.scaleBy(x: x, y: y, z: z)
        XCTAssertEqual(transform, scale)
    }

    func testRotate() {
        var transform = CATransform3DIdentity
        transform.rotate(by: angle, x: x, y: y, z: z)
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

    func testConcatenate() {
        var transform = CATransform3DIdentity
        transform.concatenate(translation)
        XCTAssertEqual(transform, translation)

        transform = CATransform3DIdentity
        transform.concatenate(scale)
        XCTAssertEqual(transform, scale)

        transform = CATransform3DIdentity
        transform.concatenate(rotation)
        XCTAssertEqual(transform, rotation)
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

#endif
