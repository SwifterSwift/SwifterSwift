// NSImageExtensionsTests.swift - Copyright 2026 SwifterSwift

#if os(macOS)

@testable import SwifterSwift
import XCTest

final class NSImageExtensionsTests: XCTestCase {
    func testScaledToMaxSize() {
        #if SWIFT_PACKAGE
        let bundle = Bundle.module
        #else
        let bundle = Bundle(for: NSImageExtensionsTests.self)
        #endif

        let image: NSImage? = if let url = bundle.url(forResource: "TestImage", withExtension: "png") {
            NSImage(contentsOf: url)
        } else {
            bundle.image(forResource: NSImage.Name(stringLiteral: "TestImage"))
        }
        XCTAssertNotNil(image)

        let scaledImage = image?.scaled(toMaxSize: NSSize(width: 150, height: 150))
        XCTAssertNotNil(scaledImage)
        XCTAssertEqual(scaledImage?.size.width, 150)
        XCTAssertEqual(scaledImage?.size.height, 34)
    }
}

#endif
