// String+FullNSRangeTests.swift - Copyright 2026 SwifterSwift

#if canImport(Foundation)
import Foundation
import SwifterSwiftFoundation
import Testing

struct StringFullNSRangeTests {
    @Test(arguments: [
        ("Hello", 5),
        ("", 0),
        ("👋🏽 Hi", 7),
        ("🇸🇾", 4),
        ("e\u{301}", 2),
        ("\u{E9}", 1),
        ("line\r\nbreak", 11),
        ("日本語", 3)
    ])
    func coversEveryUTF16CodeUnit(_ string: String, _ length: Int) {
        let range = string.fullNSRange
        #expect(range.location == 0)
        #expect(range.length == length)
        #expect(range.length == string.utf16.count)
    }

    @Test
    func convertsBackToTheWholeString() throws {
        let string = "Hello 👋🏽 e\u{301}"
        let range = try #require(Range(string.fullNSRange, in: string))
        #expect(string[range] == string[...])
    }

    @Test
    func worksWithNSString() {
        let string = "Hi 🇸🇾!"
        let nsString = string as NSString
        #expect(nsString.substring(with: string.fullNSRange) == string)
    }
}
#endif
