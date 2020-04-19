//
//  DataExtensionsTests.swift
//  SwifterSwift
//
//  Created by Omar Albeik on 09/02/2017.
//  Copyright © 2017 SwifterSwift
//

import XCTest
@testable import SwifterSwift

#if canImport(Foundation)
import Foundation

final class DataExtensionsTests: XCTestCase {

    func testString() {
        let dataFromString = "hello".data(using: .utf8)
        XCTAssertNotNil(dataFromString)
        XCTAssertNotNil(dataFromString?.string(encoding: .utf8))
        XCTAssertEqual(dataFromString?.string(encoding: .utf8), "hello")
    }

    func testBytes() {
        let dataFromString = "hello".data(using: .utf8)
        let bytes = dataFromString?.bytes
        XCTAssertNotNil(bytes)
        XCTAssertEqual(bytes?.count, 5)
    }

    func testJsonObject() {
        let invalidData = "hello".data(using: .utf8)
        XCTAssertThrowsError(try invalidData?.jsonObject())
        XCTAssertThrowsError(try invalidData?.jsonObject(options: [.allowFragments]))

        let stringData = "\"hello\"".data(using: .utf8)
        XCTAssertThrowsError(try stringData?.jsonObject())
        XCTAssertEqual((try? stringData?.jsonObject(options: [.allowFragments])) as? String, "hello")

        let objectData = "{\"message\": \"hello\"}".data(using: .utf8)
        let object = (try? objectData?.jsonObject()) as? [String: String]
        XCTAssertNotNil(object)
        XCTAssertEqual(object?["message"], "hello")

        let arrayData = "[\"hello\"]".data(using: .utf8)
        let array = (try? arrayData?.jsonObject()) as? [String]
        XCTAssertNotNil(array)
        XCTAssertEqual(array?.first, "hello")
    }

    func testHexEmpty() {
        let data = Data([])
        let hexDump = data.toHexString()

        let resolvedValue = hexDump
        let expectedValue = ""

        XCTAssertEqual(resolvedValue, expectedValue, "Hexdump does not match expected value.")
    }
    func testHexSimple() {
        let data = Data([0x00, 0x11, 0x22, 0x33, 0x44, 0x55, 0x66, 0x77, 0x88, 0x99, 0xaa, 0xbb, 0xcc, 0xdd, 0xee, 0xff, 0xde, 0xad, 0xbe, 0xef])

        let resolvedValue = data.toHexString(formatter: .simpleFormatter)
        let expectedValue = "00112233445566778899aabbccddeeffdeadbeef"

        XCTAssertEqual(resolvedValue, expectedValue, "Hex string does not match expected value.")

    }
    func testHexDump() {
        let data = Data([0x00, 0x11, 0x22, 0x33, 0x44, 0x55, 0x66, 0x77, 0x88, 0x99, 0xaa, 0xbb, 0xcc, 0xdd, 0xee, 0xff])
        let hexDump = data.toHexString()

        let resolvedValue = hexDump
        let expectedValue = "0000: 00 11 22 33 44 55 66 77 - 88 99 aa bb cc dd ee ff  ..\"3DUfw........\n"

        XCTAssertEqual(resolvedValue, expectedValue, "Hexdump does not match expected value.")
    }
    func testHexCanonical() {
        let data = "Lorem ipsum dolor sit amet".data(using: .utf8)!
        let resolvedValue = data.toHexString(formatter: .canonicalFormatter)
        let expectedValue = "00000000  4c 6f 72 65 6d 20 69 70  73 75 6d 20 64 6f 6c 6f  |Lorem ipsum dolo|\n00000010  72 20 73 69 74 20 61 6d  65 74                    |r sit amet|\n0000001a"

        print("resolved:\n\(resolvedValue)\n")
        print("expected:\n\(expectedValue)\n")

        XCTAssertEqual(resolvedValue, expectedValue, "Hexdump does not match expected value.")
    }
    func testHexComplex() {
        let data = Data([0x00, 0x11, 0x22, 0x33, 0x44, 0x55, 0x66, 0x77, 0x88, 0x99, 0xaa, 0xbb, 0xcc, 0xdd, 0xee, 0xff, 0xde, 0xad, 0xbe, 0xef])
        let fmt = Data.HexStringFormatter()
        fmt.offsetWrap = .init(begin: "<offset>", end: "</offset>")
        fmt.byteWrap = .init(begin: "<byte>", end: "</byte>")
        fmt.asciiSectionWrap = .init(begin: "<ascii>", end: "</ascii>")
        fmt.even.lineWrap = .init(begin: "<even><line>", end: "</line></even>\n")
        fmt.odd.lineWrap = .init(begin: "<odd><line>", end: "</line></odd>\n")
        fmt.midRowSeparator = "<midrow> - </midrow>"
        let hexDump = data.toHexString(formatter: fmt)

        let resolvedValue = hexDump
        let expectedValue = "<even><line><offset>0000</offset><byte>00</byte><byte>11</byte><byte>22</byte><byte>33</byte><byte>44</byte><byte>55</byte><byte>66</byte><byte>77</byte><midrow> - </midrow><byte>88</byte><byte>99</byte><byte>aa</byte><byte>bb</byte><byte>cc</byte><byte>dd</byte><byte>ee</byte><byte>ff</byte><ascii>..\"3DUfw........</ascii></line></even>\n<odd><line><offset>0010</offset><byte>de</byte><byte>ad</byte><byte>be</byte><byte>ef</byte>            <midrow> - </midrow>                        <ascii>....            </ascii></line></odd>\n"
        print("resolved: \n\(resolvedValue)")
        XCTAssertEqual(resolvedValue, expectedValue, "Hexdump does not match expected value.")
    }
}

#endif
