// Bundle+DisplayNameTests.swift - Copyright 2026 SwifterSwift

#if canImport(Foundation)
import Foundation
import SwifterSwiftFoundation
import Testing

struct BundleDisplayNameTests {
    func makeBundle(info: [String: String]) throws -> Bundle {
        let directory = FileManager.default.temporaryDirectory.appendingPathComponent("\(UUID().uuidString).bundle")
        try FileManager.default.createDirectory(at: directory, withIntermediateDirectories: true)
        var plist = info
        plist["CFBundleIdentifier"] = "com.swifterswift.tests.\(UUID().uuidString)"
        let data = try PropertyListSerialization.data(fromPropertyList: plist, format: .xml, options: 0)
        try data.write(to: directory.appendingPathComponent("Info.plist"))
        return try #require(Bundle(url: directory))
    }

    @Test
    func prefersDisplayName() throws {
        let bundle = try makeBundle(info: ["CFBundleDisplayName": "Swifter", "CFBundleName": "SwifterSwiftApp"])
        #expect(bundle.displayName == "Swifter")
    }

    @Test
    func fallsBackToBundleName() throws {
        let bundle = try makeBundle(info: ["CFBundleName": "SwifterSwiftApp"])
        #expect(bundle.displayName == "SwifterSwiftApp")
    }

    @Test
    func treatsEmptyDisplayNameAsMissing() throws {
        let bundle = try makeBundle(info: ["CFBundleDisplayName": "", "CFBundleName": "SwifterSwiftApp"])
        #expect(bundle.displayName == "SwifterSwiftApp")
    }

    @Test
    func returnsNilWithoutAnyName() throws {
        let bundle = try makeBundle(info: [:])
        #expect(bundle.displayName == nil)
    }

    @Test
    func keepsUnicodeNames() throws {
        let bundle = try makeBundle(info: ["CFBundleDisplayName": "سويفتر 🧑‍💻"])
        #expect(bundle.displayName == "سويفتر 🧑‍💻")
    }
}
#endif
