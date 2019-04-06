//
//  SCNShapeExtensionsTests.swift
//  SwifterSwift
//
//  Created by Max Härtwig on 06.04.19.
//  Copyright © 2019 SwifterSwift
//

import XCTest
@testable import SwifterSwift

#if canImport(SceneKit)
import SceneKit

final class SCNShapeExtensionsTests: XCTestCase {

    let rect = CGRect(x: 0, y: 0, width: 10, height: 10)

    func testInitWithMaterial() {
        let material = SCNMaterial(color: .red)
        let shape = SCNShape(path: UIBezierPath(rect: rect), extrusionDepth: 1, material: material)
        XCTAssertEqual(shape.materials, [material])
    }

    func testInitWithColor() {
        let color = UIColor.red
        let shape = SCNShape(path: UIBezierPath(rect: rect), extrusionDepth: 1, color: color)
        XCTAssertEqual(shape.materials[0].diffuse.contents as? Color, color)
    }

}

#endif
