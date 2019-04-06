//
//  SCNCapsuleExtensionsTests.swift
//  SwifterSwift
//
//  Created by Max Härtwig on 06.04.19.
//  Copyright © 2019 SwifterSwift
//

import XCTest
@testable import SwifterSwift

#if canImport(SceneKit)
import SceneKit

final class SCNCapsuleExtensionsTests: XCTestCase {

    func testInitWithDiameter() {
        let capsule = SCNCapsule(capDiameter: 10, height: 20)
        XCTAssertEqual(capsule.boundingSize, SCNVector3(10, 20, 10))
    }

    func testInitWithMaterial() {
        let material = SCNMaterial(color: .red)
        let capsule = SCNCapsule(capRadius: 5, height: 20, material: material)
        XCTAssertEqual(capsule.materials, [material])
    }

    func testInitWithColor() {
        let color = Color.red
        let capsule = SCNCapsule(capRadius: 5, height: 20, color: color)
        XCTAssertEqual(capsule.materials[0].diffuse.contents as? Color, color)
    }

    func testInitWithDiameterAndMaterial() {
        let material = SCNMaterial(color: .red)
        let capsule = SCNCapsule(capDiameter: 10, height: 20, material: material)
        XCTAssertEqual(capsule.boundingSize, SCNVector3(10, 20, 10))
        XCTAssertEqual(capsule.materials, [material])
    }

    func testInitWithDiameterAndColor() {
        let color = Color.red
        let capsule = SCNCapsule(capDiameter: 10, height: 20, color: color)
        XCTAssertEqual(capsule.boundingSize, SCNVector3(10, 20, 10))
        XCTAssertEqual(capsule.materials[0].diffuse.contents as? Color, color)
    }

}

#endif
