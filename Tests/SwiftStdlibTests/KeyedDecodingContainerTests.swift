//
//  KeyedDecodingContainerTests.swift
//  SwifterSwift
//
//  Created by Francesco Deliro on 23/10/2019.
//  Copyright © 2019 SwifterSwift
//

import XCTest

@testable import SwifterSwift

fileprivate struct Video: Decodable {
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

fileprivate enum ElementToTest: Decodable {
  case video(Video)
  
  enum CodingKeys: String, CodingKey {
      case data
  }
  
  init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    self = .video(try container.decode(Video.self, forKey: .data))
  }
}

class KeyedDecodingContainerTests: XCTestCase {
  
    private let isPlayingAndIsFullScreenAsInt = Data("""
    {
      "data" : {
        "isPlaying" : 1,
        "isFullScreen" : 0
      }
    }
    """.utf8)
  
    private let isPlayingAndIsFullScreenAsString = Data("""
    {
      "data" : {
        "isPlaying" : "true",
        "isFullScreen" : "false"
      }
    }
    """.utf8)
  
  private let isPlayingAndIsFullScreenAsBool = Data("""
  {
    "data" : {
      "isPlaying" : true,
      "isFullScreen" : false
    }
  }
  """.utf8)
  
    private let isPlayingAsIntAndIsFullScreenNotPresent = Data("""
    {
      "data" : {
        "isPlaying" : 0
      }
    }
    """.utf8)
  
    private let isPlayingAsIntAndIsFullScreenTypeMismatch = Data("""
    {
      "data" : {
        "isPlaying" : [0],
        "isFullScreen" : ["false"]
      }
    }
    """.utf8)

   
    func testDecodeBoolAsIntOrStringDataAsIntSuccessful() {
        let result = try? JSONDecoder().decode(ElementToTest.self, from: isPlayingAndIsFullScreenAsInt)
      
        if case .video(let video) = result {
            XCTAssertTrue(video.isPlaying)
            XCTAssertNotNil(video.isFullScreen)
            XCTAssertFalse(video.isFullScreen!)
        } else {
          XCTFail("Expected to decode Video but found a \(String(describing: result)) instead")
        }
    }
  
    func testDecodeBoolAsIntOrStringDataAsStringSuccessful() {
        let result = try? JSONDecoder().decode(ElementToTest.self, from: isPlayingAndIsFullScreenAsString)
    
        if case .video(let video) = result {
            XCTAssertTrue(video.isPlaying)
            XCTAssertNotNil(video.isFullScreen)
            XCTAssertFalse(video.isFullScreen!)
        } else {
            XCTFail("Expected to decode Video but found a \(String(describing: result)) instead")
        }
    }
  
  func testDecodeBoolAsIntOrStringDataAsBoolSuccessful() {
      let result = try? JSONDecoder().decode(ElementToTest.self, from: isPlayingAndIsFullScreenAsBool)
  
      if case .video(let video) = result {
          XCTAssertTrue(video.isPlaying)
          XCTAssertNotNil(video.isFullScreen)
          XCTAssertFalse(video.isFullScreen!)
      } else {
          XCTFail("Expected to decode Video but found a \(String(describing: result)) instead")
      }
  }
  
    func testDecodeBoolAsIntOrStringIfPresentSuccessful() {
        let result = try? JSONDecoder().decode(ElementToTest.self, from: isPlayingAsIntAndIsFullScreenNotPresent)
    
        if case .video(let video) = result {
            XCTAssertFalse(video.isPlaying)
            XCTAssertNil(video.isFullScreen)
        } else {
            XCTFail("Expected to decode Video but found a \(String(describing: result)) instead")
        }
    }
  
    func testDecodeBoolAsIntOrStringThrowsError() {
        XCTAssertThrowsError(try JSONDecoder().decode(ElementToTest.self, from: isPlayingAsIntAndIsFullScreenTypeMismatch))
    }

}
