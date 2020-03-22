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

#if canImport(QuartzCore)
import QuartzCore
#endif

final class CGAffineTransformExtensionsTests: XCTestCase {

    #if canImport(QuartzCore)
    func testTransform3D() {
        XCTAssertEqual(CGAffineTransform.identity.transform3D(), CATransform3DIdentity)

        let x = CGFloat(5)
        let y = CGFloat(10)
        let angle = CGFloat.pi / 3

        XCTAssertEqual(CGAffineTransform(translationX: x, y: y).transform3D(), CATransform3DMakeTranslation(x, y, 0))
        XCTAssertEqual(CGAffineTransform(scaleX: x, y: y).transform3D(), CATransform3DMakeScale(x, y, 1))
        XCTAssertEqual(CGAffineTransform(rotationAngle: angle).transform3D(), CATransform3DMakeRotation(angle, 0, 0, 1))
    }
    #endif

}

#endif
