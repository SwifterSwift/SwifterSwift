//
//  KeyedDecodingContainerTests.swift
//  SwifterSwift
//
//  Created by Francesco Deliro on 23/10/2019.
//  Copyright © 2019 SwifterSwift
//

import XCTest

@testable import SwifterSwift

private struct Video: Decodable {
    var isPlaying: Bool
    var isFullScreen: Bool?

    enum CodingKeys: String, CodingKey {
        case isPlaying
        case isFullScreen
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        isPlaying = try container.decodeBoolAsIntOrString(forKey: .isPlaying)
        isFullScreen = try container.decodeBoolAsIntOrStringIfPresent(forKey: .isFullScreen)
    }
}

final class KeyedDecodingContainerTests: XCTestCase {

    private let isPlayingAndIsFullScreenAsInt = #"{"isPlaying": 1, "isFullScreen": 0}"#
    private let isPlayingAndIsFullScreenAsString = #"{"isPlaying": "true", "isFullScreen": "false"}"#
    private let isPlayingAndIsFullScreenAsBool = #"{"isPlaying": true, "isFullScreen": false}"#
    private let isPlayingAsIntAndIsFullScreenNotPresent = #"{"isPlaying": 0}"#
    private let isPlayingAndIsFullScreenTypeMismatch = #"{"isPlaying": [1], "isFullScreen": ["true"]}"#

    func testDecodeBoolAsIntOrStringDataAsIntSuccessful() {
        let data = mockJsonData(from: isPlayingAndIsFullScreenAsInt)
        let result = try? JSONDecoder().decode(Video.self, from: data)

        if let video = result {
            XCTAssertTrue(video.isPlaying)
            XCTAssertNotNil(video.isFullScreen)
            XCTAssertFalse(video.isFullScreen!)
        } else {
            XCTFail("Expected to decode Video but found a \(String(describing: result)) instead")
        }
    }

    func testDecodeBoolAsIntOrStringDataAsStringSuccessful() {
        let data = mockJsonData(from: isPlayingAndIsFullScreenAsString)
        let result = try? JSONDecoder().decode(Video.self, from: data)

        if let video = result {
            XCTAssertTrue(video.isPlaying)
            XCTAssertNotNil(video.isFullScreen)
            XCTAssertFalse(video.isFullScreen!)
        } else {
            XCTFail("Expected to decode Video but found a \(String(describing: result)) instead")
        }
    }

    func testDecodeBoolAsIntOrStringDataAsBoolSuccessful() {
        let data = mockJsonData(from: isPlayingAndIsFullScreenAsBool)
        let result = try? JSONDecoder().decode(Video.self, from: data)

        if let video = result {
            XCTAssertTrue(video.isPlaying)
            XCTAssertNotNil(video.isFullScreen)
            XCTAssertFalse(video.isFullScreen!)
        } else {
            XCTFail("Expected to decode Video but found a \(String(describing: result)) instead")
        }
    }

    func testDecodeBoolAsIntOrStringIfPresentSuccessful() {
        let data = mockJsonData(from: isPlayingAsIntAndIsFullScreenNotPresent)
        let result = try? JSONDecoder().decode(Video.self, from: data)

        if let video = result {
            XCTAssertFalse(video.isPlaying)
            XCTAssertNil(video.isFullScreen)
        } else {
            XCTFail("Expected to decode Video but found a \(String(describing: result)) instead")
        }
    }

    func testDecodeBoolAsIntOrStringThrowsError() {
        let data = mockJsonData(from: isPlayingAndIsFullScreenTypeMismatch)
        XCTAssertThrowsError(try JSONDecoder().decode(Video.self, from: data))
    }
  
    private func mockJsonData(from json: String) -> Data {
        return Data(json.utf8)
    }

}
