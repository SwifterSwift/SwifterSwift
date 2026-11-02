// Bundle+VersionNumberTests.swift - Copyright 2026 SwifterSwift

#if canImport(Foundation)
import Foundation
import SwifterSwiftFoundation
import Testing

struct BundleVersionNumberTests {
    func makeBundle(info: [String: String]) throws -> Bundle {
        let directory = FileManager.default.temporaryDirectory.appendingPathComponent("\(UUID().uuidString).bundle")
        try FileManager.default.createDirectory(at: directory, withIntermediateDirectories: true)
        var plist = info
        plist["CFBundleIdentifier"] = "com.swifterswift.tests.\(UUID().uuidString)"
        let data = try PropertyListSerialization.data(fromPropertyList: plist, format: .xml, options: 0)
        try data.write(to: directory.appendingPathComponent("Info.plist"))
        return try #require(Bundle(url: directory))
    }

    @Test(arguments: ["1.0", "2.4.1", "10.0.0-beta.3"])
    func returnsShortVersionString(_ version: String) throws {
        let bundle = try makeBundle(info: ["CFBundleShortVersionString": version, "CFBundleVersion": "99"])
        #expect(bundle.versionNumber == version)
    }

    @Test
    func doesNotFallBackToBuildNumber() throws {
        let bundle = try makeBundle(info: ["CFBundleVersion": "99"])
        #expect(bundle.versionNumber == nil)
    }

    @Test
    func treatsEmptyVersionAsMissing() throws {
        let bundle = try makeBundle(info: ["CFBundleShortVersionString": ""])
        #expect(bundle.versionNumber == nil)
    }
}
#endif
