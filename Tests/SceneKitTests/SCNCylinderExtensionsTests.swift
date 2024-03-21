// SCNCylinderExtensionsTests.swift - Copyright 2024 SwifterSwift

@testable import SwifterSwift
import XCTest

#if canImport(SceneKit)
import SceneKit

final class SCNCylinderExtensionsTests: XCTestCase {
    func testInitWithDiameter() {
        let cylinder = SCNCylinder(diameter: 10, height: 20)
        XCTAssertEqual(cylinder.boundingSize, SCNVector3(10, 20, 10))
    }

    func testInitWithMaterial() {
        let material = SCNMaterial(color: .red)
        let cylinder = SCNCylinder(diameter: 10, height: 20, material: material)
        XCTAssertEqual(cylinder.materials, [material])
    }

    func testInitWithColor() {
        let color = SFColor.red
        let cylinder = SCNCylinder(radius: 5, height: 20, color: color)
        XCTAssertEqual(cylinder.materials[0].diffuse.contents as? SFColor, color)
    }

    func testInitWithDiameterAndMaterial() {
        let material = SCNMaterial(color: .red)
        let cylinder = SCNCylinder(diameter: 10, height: 20, material: material)
        XCTAssertEqual(cylinder.boundingSize, SCNVector3(10, 20, 10))
        XCTAssertEqual(cylinder.materials, [material])
    }

    func testInitWithDiameterAndColor() {
        let color = SFColor.red
        let cylinder = SCNCylinder(diameter: 10, height: 20, color: color)
        XCTAssertEqual(cylinder.boundingSize, SCNVector3(10, 20, 10))
        XCTAssertEqual(cylinder.materials[0].diffuse.contents as? SFColor, color)
    }
}

#endif
