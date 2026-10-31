// Bundle+BuildNumberTests.swift - Copyright 2026 SwifterSwift

#if canImport(Foundation)
import Foundation
import SwifterSwiftFoundation
import Testing

struct BundleBuildNumberTests {
    func makeBundle(info: [String: String]) throws -> Bundle {
        let directory = FileManager.default.temporaryDirectory.appendingPathComponent("\(UUID().uuidString).bundle")
        try FileManager.default.createDirectory(at: directory, withIntermediateDirectories: true)
        var plist = info
        plist["CFBundleIdentifier"] = "com.swifterswift.tests.\(UUID().uuidString)"
        let data = try PropertyListSerialization.data(fromPropertyList: plist, format: .xml, options: 0)
        try data.write(to: directory.appendingPathComponent("Info.plist"))
        return try #require(Bundle(url: directory))
    }

    @Test(arguments: ["1", "1042", "2026.10.30.1"])
    func returnsBundleVersion(_ build: String) throws {
        let bundle = try makeBundle(info: ["CFBundleVersion": build, "CFBundleShortVersionString": "1.0"])
        #expect(bundle.buildNumber == build)
    }

    @Test
    func doesNotFallBackToVersionNumber() throws {
        let bundle = try makeBundle(info: ["CFBundleShortVersionString": "1.0"])
        #expect(bundle.buildNumber == nil)
    }

    @Test
    func treatsEmptyBuildAsMissing() throws {
        let bundle = try makeBundle(info: ["CFBundleVersion": ""])
        #expect(bundle.buildNumber == nil)
    }
}
#endif
