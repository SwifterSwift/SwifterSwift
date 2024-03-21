// SCNMaterialExtensionsTests.swift - Copyright 2024 SwifterSwift

@testable import SwifterSwift
import XCTest

#if canImport(SceneKit)
import SceneKit

final class SCNMaterialExtensionsTests: XCTestCase {
    func testInitWithColor() {
        let color = SFColor.red
        let material = SCNMaterial(color: color)
        XCTAssertEqual(material.diffuse.contents as? SFColor, color)
    }
}

#endif
