//
//  KeyedDecodingContainerExtensionsTests.swift
//  SwifterSwift
//
//  Created by Francesco Deliro on 23/10/2019.
//  Copyright © 2019 SwifterSwift
//

import XCTest

@testable import SwifterSwift

private struct Video: Decodable {
    let isPlaying: Bool
    let isFullScreen: Bool?

    private enum CodingKeys: CodingKey {
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

    func testDecodeBoolAsIntOrStringDataAsIntSuccessful() {
        let isPlayingAndIsFullScreenAsInt = #"{"isPlaying": 1, "isFullScreen": 0}"#
        let data = mockJsonData(from: isPlayingAndIsFullScreenAsInt)
        let video = try! JSONDecoder().decode(Video.self, from: data) // swiftlint:disable:this force_try
        XCTAssertTrue(video.isPlaying)
        XCTAssertEqual(video.isFullScreen, false)
    }

    func testDecodeBoolAsIntOrStringDataAsStringSuccessful() {
        let isPlayingAndIsFullScreenAsString = #"{"isPlaying": "true", "isFullScreen": "false"}"#
        let data = mockJsonData(from: isPlayingAndIsFullScreenAsString)
        let video = try! JSONDecoder().decode(Video.self, from: data) // swiftlint:disable:this force_try
        XCTAssertTrue(video.isPlaying)
        XCTAssertEqual(video.isFullScreen, false)
    }

    func testDecodeBoolAsIntOrStringDataAsBoolSuccessful() {
        let isPlayingAndIsFullScreenAsBool = #"{"isPlaying": true, "isFullScreen": false}"#
        let data = mockJsonData(from: isPlayingAndIsFullScreenAsBool)
        let video = try! JSONDecoder().decode(Video.self, from: data) // swiftlint:disable:this force_try
        XCTAssertTrue(video.isPlaying)
        XCTAssertEqual(video.isFullScreen, false)
    }

    func testDecodeBoolAsIntOrStringIfPresentSuccessful() {
        let isPlayingAsIntAndIsFullScreenNotPresent = #"{"isPlaying": 0}"#
        let data = mockJsonData(from: isPlayingAsIntAndIsFullScreenNotPresent)
        let video = try! JSONDecoder().decode(Video.self, from: data) // swiftlint:disable:this force_try
        XCTAssertFalse(video.isPlaying)
        XCTAssertNil(video.isFullScreen)
    }

    func testDecodeBoolAsIntOrStringThrowsError() {
        let isPlayingAndIsFullScreenTypeMismatch = #"{"isPlaying": [1], "isFullScreen": ["true"]}"#
        let data = mockJsonData(from: isPlayingAndIsFullScreenTypeMismatch)
        XCTAssertThrowsError(try JSONDecoder().decode(Video.self, from: data))
    }

    private func mockJsonData(from json: String) -> Data {
        return Data(json.utf8)
    }

}
