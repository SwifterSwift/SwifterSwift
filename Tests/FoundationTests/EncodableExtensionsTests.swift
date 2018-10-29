//
//  EncodableExtensionsTests.swift
//  SwifterSwift
//
//  Created by Alexei Kozachenko on 2018-10-29.
//  Copyright © 2018 SwifterSwift
//
import XCTest
@testable import SwifterSwift

#if canImport(Foundation)
import Foundation

class EncodableExtensionsTests: XCTestCase {

    func testEncode() {
        let point = CGPoint(x: 1, y: 2) //CGPoint conforms to Encodable
        
        let tmpDirPath = NSTemporaryDirectory()
        let fileURL = URL(fileURLWithPath: tmpDirPath.appending("testEncodeFile"))
        
        do {
            try point.encode(to: fileURL)
            try FileManager.default.removeItem(at: fileURL) //delete created file
            XCTAssert(true)
        } catch {
            XCTFail()
        }
    }
}
#endif
