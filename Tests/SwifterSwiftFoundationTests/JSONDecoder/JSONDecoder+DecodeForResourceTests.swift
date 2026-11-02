// JSONDecoder+DecodeForResourceTests.swift - Copyright 2026 SwifterSwift

#if canImport(Foundation)
import Foundation
import SwifterSwiftFoundation
import Testing

struct JSONDecoderDecodeForResourceTests {
    struct User: Decodable, Equatable {
        var name: String
        var age: Int
    }

    /// Creates a flat bundle in a new temporary directory, holding the given files and folders. Delete it with
    /// `removeItem(at:)`.
    ///
    /// The contents are written before the bundle is created, because `Bundle` caches the contents of its directory.
    func makeBundle(files: [String: String], folders: [String] = []) throws -> (bundle: Bundle, directory: URL) {
        let directory = FileManager.default.temporaryDirectory.appendingPathComponent("\(UUID().uuidString).bundle")
        try FileManager.default.createDirectory(at: directory, withIntermediateDirectories: true)
        for (name, contents) in files {
            try Data(contents.utf8).write(to: directory.appendingPathComponent(name))
        }
        for name in folders {
            try FileManager.default.createDirectory(
                at: directory.appendingPathComponent(name), withIntermediateDirectories: true)
        }
        return (try #require(Bundle(url: directory)), directory)
    }

    @Test
    func decodesAJSONFileFromTheBundle() throws {
        let (bundle, directory) = try makeBundle(files: ["user.json": #"{"name": "Zoë 🧑‍💻", "age": 30}"#])
        defer { try? FileManager.default.removeItem(at: directory) }
        let user = try JSONDecoder().decode(User.self, forResource: "user", in: bundle)
        #expect(user == User(name: "Zoë 🧑‍💻", age: 30))
    }

    @Test
    func decodesTopLevelArraysAndFragments() throws {
        let (bundle, directory) = try makeBundle(files: ["numbers.json": "[1, 2, 3]", "flag.json": "true"])
        defer { try? FileManager.default.removeItem(at: directory) }
        #expect(try JSONDecoder().decode([Int].self, forResource: "numbers", in: bundle) == [1, 2, 3])
        #expect(try JSONDecoder().decode(Bool.self, forResource: "flag", in: bundle))
    }

    @Test
    func keepsDotsInTheName() throws {
        let (bundle, directory) = try makeBundle(files: [
            "app.config.json": #"{"name": "config", "age": 1}"#,
            "app.json": #"{"name": "app", "age": 2}"#
        ])
        defer { try? FileManager.default.removeItem(at: directory) }
        #expect(try JSONDecoder().decode(User.self, forResource: "app.config", in: bundle).name == "config")
        #expect(try JSONDecoder().decode(User.self, forResource: "app", in: bundle).name == "app")
    }

    @Test
    func usesTheGivenExtension() throws {
        let (bundle, directory) = try makeBundle(files: [
            "map.geojson": #"{"name": "geo", "age": 1}"#,
            "LICENSE": #"{"name": "none", "age": 2}"#
        ])
        defer { try? FileManager.default.removeItem(at: directory) }
        let decoder = JSONDecoder()
        #expect(try decoder.decode(User.self, forResource: "map", withExtension: "geojson", in: bundle).name == "geo")
        #expect(try decoder.decode(User.self, forResource: "map.geojson", withExtension: nil, in: bundle).name == "geo")
        #expect(try decoder.decode(User.self, forResource: "LICENSE", withExtension: nil, in: bundle).name == "none")
        #expect(try decoder.decode(User.self, forResource: "LICENSE", withExtension: "", in: bundle).name == "none")
    }

    @Test
    func findsUnicodeNames() throws {
        let (bundle, directory) = try makeBundle(files: ["Zoë 🧑‍💻.json": #"{"name": "Zoë", "age": 30}"#])
        defer { try? FileManager.default.removeItem(at: directory) }
        #expect(try JSONDecoder().decode(User.self, forResource: "Zoë 🧑‍💻", in: bundle).name == "Zoë")
    }

    @Test
    func usesTheDecodersSettings() throws {
        struct Account: Decodable, Equatable {
            var displayName: String
        }
        let (bundle, directory) = try makeBundle(files: ["account.json": #"{"display_name": "Taylor"}"#])
        defer { try? FileManager.default.removeItem(at: directory) }
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        #expect(try decoder.decode(Account.self, forResource: "account", in: bundle) == Account(displayName: "Taylor"))
        #expect(throws: DecodingError.self) {
            try JSONDecoder().decode(Account.self, forResource: "account", in: bundle)
        }
    }

    @Test
    func throwsNoSuchFileForAMissingResource() throws {
        let (bundle, directory) = try makeBundle(files: ["user.json": #"{"name": "Taylor", "age": 41}"#])
        defer { try? FileManager.default.removeItem(at: directory) }
        let error = try #require(throws: CocoaError.self) {
            try JSONDecoder().decode(User.self, forResource: "missing", in: bundle)
        }
        #expect(error.code == .fileReadNoSuchFile)
        // The error points to where the file was expected: the bundle's resource folder.
        let url = try #require(error.url)
        #expect(url.lastPathComponent == "missing.json")
        #expect(url.deletingLastPathComponent().lastPathComponent == directory.lastPathComponent)
        #expect(error.filePath == url.path(percentEncoded: false))
    }

    @Test
    func matchesNamesAndExtensionsExactly() throws {
        let (bundle, directory) = try makeBundle(files: ["user.json": #"{"name": "Taylor", "age": 41}"#])
        defer { try? FileManager.default.removeItem(at: directory) }
        let decoder = JSONDecoder()
        for (name, ext) in [("User", "json"), ("user", "JSON"), ("user", "txt"), ("use", "json"), ("user", nil)] {
            let error = try #require(throws: CocoaError.self) {
                try decoder.decode(User.self, forResource: name, withExtension: ext, in: bundle)
            }
            #expect(error.code == .fileReadNoSuchFile)
        }
    }

    @Test
    func throwsForAnEmptyNameInsteadOfPickingAnyFile() throws {
        let (bundle, directory) = try makeBundle(files: ["user.json": #"{"name": "Taylor", "age": 41}"#])
        defer { try? FileManager.default.removeItem(at: directory) }
        // The bundle API itself returns the first file with the extension for an empty name.
        #expect(bundle.url(forResource: "", withExtension: "json") != nil)
        let error = try #require(throws: CocoaError.self) {
            try JSONDecoder().decode(User.self, forResource: "", in: bundle)
        }
        #expect(error.code == .fileReadNoSuchFile)
    }

    @Test
    func readsFromTheMainBundleByDefault() throws {
        let name = "SwifterSwift-missing-\(UUID().uuidString)"
        let error = try #require(throws: CocoaError.self) {
            try JSONDecoder().decode(User.self, forResource: name)
        }
        #expect(error.code == .fileReadNoSuchFile)
        #expect(error.url?.lastPathComponent == "\(name).json")
    }

    @Test
    func throwsTheDecodingErrorForInvalidContents() throws {
        let (bundle, directory) = try makeBundle(files: [
            "empty.json": "",
            "broken.json": "{\"name\": ",
            "partial.json": #"{"name": "Taylor"}"#,
            "wrong.json": #"{"name": "Taylor", "age": "forty"}"#
        ])
        defer { try? FileManager.default.removeItem(at: directory) }
        for name in ["empty", "broken", "partial", "wrong"] {
            #expect(throws: DecodingError.self) {
                try JSONDecoder().decode(User.self, forResource: name, in: bundle)
            }
        }
    }

    @Test
    func throwsTheReadErrorForAFolder() throws {
        let (bundle, directory) = try makeBundle(files: [:], folders: ["folder.json"])
        defer { try? FileManager.default.removeItem(at: directory) }
        #expect(throws: (any Error).self) {
            try JSONDecoder().decode(User.self, forResource: "folder", in: bundle)
        }
    }
}
#endif
