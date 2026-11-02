// FileManager+CreateTemporaryDirectoryTests.swift - Copyright 2026 SwifterSwift

#if canImport(Foundation)
import Foundation
import SwifterSwiftFoundation
import Testing

struct FileManagerCreateTemporaryDirectoryTests {
    @Test
    func createsAnEmptyDirectory() throws {
        let fileManager = FileManager()
        let directory = try fileManager.createTemporaryDirectory()
        defer { try? fileManager.removeItem(at: directory) }

        var isDirectory: ObjCBool = false
        #expect(fileManager.fileExists(atPath: directory.path, isDirectory: &isDirectory))
        #expect(isDirectory.boolValue)
        #expect(try fileManager.contentsOfDirectory(atPath: directory.path).isEmpty)
    }

    @Test
    func createsADifferentDirectoryEachTime() throws {
        let fileManager = FileManager()
        let first = try fileManager.createTemporaryDirectory()
        defer { try? fileManager.removeItem(at: first) }
        let second = try fileManager.createTemporaryDirectory()
        defer { try? fileManager.removeItem(at: second) }

        #expect(first.standardizedFileURL != second.standardizedFileURL)
    }

    @Test
    func holdsFilesThatAreRemovedWithTheDirectory() throws {
        let fileManager = FileManager()
        let directory = try fileManager.createTemporaryDirectory()
        defer { try? fileManager.removeItem(at: directory) }

        let file = directory.appendingPathComponent("übung 🚀.txt")
        try Data("SwifterSwift".utf8).write(to: file)
        #expect(try fileManager.contentsOfDirectory(atPath: directory.path).count == 1)
        #expect(try Data(contentsOf: file) == Data("SwifterSwift".utf8))

        try fileManager.removeItem(at: directory)
        #expect(!fileManager.fileExists(atPath: file.path))
        #expect(!fileManager.fileExists(atPath: directory.path))
    }
}
#endif
