//
//  CGAffineTransformExtensionsTests.swift
//  SwifterSwift
//
//  Created by Guy Kogus on 19/3/20.
//  Copyright © 2020 SwifterSwift
//

import XCTest
@testable import SwifterSwift

#if canImport(CoreGraphics)
import CoreGraphics

final class CGAffineTransformExtensionsTests: XCTestCase {

    #if canImport(QuartzCore)
    func testTransform3D() {
        let identityAffineTransform = CGAffineTransform.identity
        let identityTransform = CATransform3DIdentity
        XCTAssertEqual(identityAffineTransform.transform3D(), identityTransform)

        // swiftlint:disable identifier_name
        let x = CGFloat(5)
        let y = CGFloat(10)
        // swiftlint:enable identifier_name

        XCTAssertEqual(identityAffineTransform.translatedBy(x: x, y: y).transform3D(),
                       identityTransform.translated(tx: x, ty: y, tz: 0))

        XCTAssertEqual(identityAffineTransform.scaledBy(x: x, y: y).transform3D(),
                       identityTransform.scaled(sx: x, sy: y, sz: 1))

        let angle = CGFloat.pi / 3
        XCTAssertEqual(identityAffineTransform.rotated(by: angle).transform3D(),
                       identityTransform.rotated(angle: angle, x: 0, y: 0, z: 1))
    }
    #endif

}

#endif
