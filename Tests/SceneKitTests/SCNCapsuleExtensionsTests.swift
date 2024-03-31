// SCNCapsuleExtensionsTests.swift - Copyright 2024 SwifterSwift

@testable import SwifterSwift
import XCTest

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
        let color = SFColor.red
        let capsule = SCNCapsule(capRadius: 5, height: 20, color: color)
        XCTAssertEqual(capsule.materials[0].diffuse.contents as? SFColor, color)
    }

    func testInitWithDiameterAndMaterial() {
        let material = SCNMaterial(color: .red)
        let capsule = SCNCapsule(capDiameter: 10, height: 20, material: material)
        XCTAssertEqual(capsule.boundingSize, SCNVector3(10, 20, 10))
        XCTAssertEqual(capsule.materials, [material])
    }

    func testInitWithDiameterAndColor() {
        let color = SFColor.red
        let capsule = SCNCapsule(capDiameter: 10, height: 20, color: color)
        XCTAssertEqual(capsule.boundingSize, SCNVector3(10, 20, 10))
        XCTAssertEqual(capsule.materials[0].diffuse.contents as? SFColor, color)
    }
}

#endif
