// String+CopyToPasteboardTests.swift - Copyright 2026 SwifterSwift

#if canImport(AppKit) && !targetEnvironment(macCatalyst)
import AppKit
import SwifterSwiftAppKit
import Testing

@MainActor
struct StringCopyToPasteboardTests {
    /// Runs the body with a private pasteboard, so the tests never touch the user's clipboard.
    func withPrivatePasteboard(_ body: (NSPasteboard) -> Void) {
        let pasteboard = NSPasteboard.withUniqueName()
        defer { pasteboard.releaseGlobally() }
        body(pasteboard)
    }

    @Test(arguments: ["Hello world!", "", "👋🏽 e\u{301} 🇸🇾", "line 1\r\nline 2"])
    func copiesStringToPasteboard(_ string: String) {
        withPrivatePasteboard { pasteboard in
            #expect(string.copyToPasteboard(pasteboard))
            #expect(pasteboard.string(forType: .string) == string)
        }
    }

    @Test
    func replacesPreviousContents() {
        withPrivatePasteboard { pasteboard in
            pasteboard.clearContents()
            pasteboard.setString("<b>old</b>", forType: .html)
            pasteboard.setString("old", forType: .string)
            "new".copyToPasteboard(pasteboard)
            #expect(pasteboard.string(forType: .string) == "new")
            #expect(pasteboard.string(forType: .html) == nil)
            #expect(pasteboard.types?.contains(.html) == false)
        }
    }

    @Test
    func incrementsTheChangeCount() {
        withPrivatePasteboard { pasteboard in
            let changeCount = pasteboard.changeCount
            "text".copyToPasteboard(pasteboard)
            #expect(pasteboard.changeCount > changeCount)
        }
    }
}
#endif
