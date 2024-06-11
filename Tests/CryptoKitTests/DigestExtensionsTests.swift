// DigestExtensionsTests.swift - Copyright 2024 SwifterSwift

@testable import SwifterSwift
import XCTest

#if canImport(CryptoKit)
import CryptoKit

final class DigestExtensionsTests: XCTestCase {
    @available(iOS 13.0, macOS 10.15, watchOS 6.0, tvOS 13.0, *)
    func testHexString() {
        let data = Data("Hello, World!".utf8)
        XCTAssertEqual(
            SHA256.hash(data: data).hexString,
            "DFFD6021BB2BD5B0AF676290809EC3A53191DD81C7F70A4B28688A362182986F")
        XCTAssertEqual(
            SHA512.hash(data: data).hexString,
            "374D794A95CDCFD8B35993185FEF9BA368F160D8DAF432D08BA9F1ED1E5ABE6CC69291E0FA2FE0006A52570EF18C19DEF4E617C33CE52EF0A6E5FBE318CB0387")
    }
}
#endif
