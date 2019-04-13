//
//  SCNConeExtensionsTests.swift
//  SwifterSwift
//
//  Created by Max Härtwig on 06.04.19.
//  Copyright © 2019 SwifterSwift
//

import XCTest
@testable import SwifterSwift

#if canImport(SceneKit)
import SceneKit

final class SCNConeExtensionsTests: XCTestCase {

    func testInitWithDiameter() {
        let cone = SCNCone(topDiameter: 10, bottomDiameter: 10, height: 20)
        XCTAssertEqual(cone.boundingSize, SCNVector3(10, 20, 10))
    }

    func testInitWithMaterial() {
        let material = SCNMaterial(color: .red)
        let cone = SCNCone(topRadius: 5, bottomRadius: 5, height: 20, material: material)
        XCTAssertEqual(cone.materials, [material])
    }

    func testInitWithColor() {
        let color = Color.red
        let cone = SCNCone(topRadius: 5, bottomRadius: 5, height: 20, color: color)
        XCTAssertEqual(cone.materials[0].diffuse.contents as? Color, color)
    }

    func testInitWithDiameterAndMaterial() {
        let material = SCNMaterial(color: .red)
        let cone = SCNCone(topDiameter: 10, bottomDiameter: 10, height: 20, material: material)
        XCTAssertEqual(cone.boundingSize, SCNVector3(10, 20, 10))
        XCTAssertEqual(cone.materials, [material])
    }

    func testInitWithDiameterAndColor() {
        let color = Color.red
        let cone = SCNCone(topDiameter: 10, bottomDiameter: 10, height: 20, color: color)
        XCTAssertEqual(cone.boundingSize, SCNVector3(10, 20, 10))
        XCTAssertEqual(cone.materials[0].diffuse.contents as? Color, color)
    }

}

#endif
