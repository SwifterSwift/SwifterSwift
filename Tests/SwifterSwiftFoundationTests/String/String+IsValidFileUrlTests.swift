// String+IsValidFileUrlTests.swift - Copyright 2026 SwifterSwift

#if canImport(Foundation)
import Foundation
import SwifterSwiftFoundation
import Testing

struct StringIsValidFileUrlTests {
    @Test(arguments: [
        "file:///Users/tim/notes.txt",
        "file:///",
        "FILE:///tmp/file.txt",
        "file://localhost/tmp/file.txt",
        "file://LOCALHOST/tmp/file.txt",
        "file:/tmp/file.txt",
        "file:///tmp/a%20b.txt"
    ])
    func acceptsLocalFileURLs(_ string: String) {
        #expect(string.isValidFileUrl)
    }

    @Test(arguments: [
        "",
        "Hello world!",
        "google.com",
        "/Users/tim/notes.txt",
        "https://apple.com/file.txt",
        "file://var/folder/file.txt",
        "file://server/share/file.txt",
        "file:relative/path",
        "file:",
        "file:///tmp/a b.txt"
    ])
    func rejectsEverythingElse(_ string: String) {
        #expect(!string.isValidFileUrl)
    }
}
#endif
