//
//  SCNPlaneExtensionsTests.swift
//  SwifterSwift
//
//  Created by Max Härtwig on 06.04.19.
//  Copyright © 2019 SwifterSwift
//

import XCTest
@testable import SwifterSwift

#if canImport(SceneKit)
import SceneKit

final class SCNPlaneExtensionsTests: XCTestCase {

    func testInitWithWidth() {
        let plane = SCNPlane(width: 10)
        XCTAssertEqual(plane.boundingSize, SCNVector3(10, 10, 0))
    }

    func testInitWithMaterial() {
        let material = SCNMaterial(color: .red)
        let plane = SCNPlane(width: 10, height: 20, material: material)
        XCTAssertEqual(plane.materials, [material])
    }

    func testInitWithColor() {
        let color = Color.red
        let plane = SCNPlane(width: 10, height: 20, color: color)
        XCTAssertEqual(plane.materials[0].diffuse.contents as? Color, color)
    }

    func testInitWithWidthAndMaterial() {
        let material = SCNMaterial(color: .red)
        let plane = SCNPlane(width: 10, material: material)
        XCTAssertEqual(plane.boundingSize, SCNVector3(10, 10, 0))
        XCTAssertEqual(plane.materials, [material])
    }

    func testInitWithWidthAndColor() {
        let color = Color.red
        let plane = SCNPlane(width: 10, color: color)
        XCTAssertEqual(plane.boundingSize, SCNVector3(10, 10, 0))
        XCTAssertEqual(plane.materials[0].diffuse.contents as? Color, color)
    }

}

#endif
