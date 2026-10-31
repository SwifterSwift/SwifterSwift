// String+CopyToPasteboardTests.swift - Copyright 2026 SwifterSwift

// Pasteboard calls can block on a CI simulator, and the blocked tests then hold up every other test, so these tests run
// on Mac Catalyst and devices only.
#if canImport(UIKit) && !os(tvOS) && !os(watchOS) && !targetEnvironment(simulator)
import SwifterSwiftUIKit
import Testing
import UIKit
import UniformTypeIdentifiers

struct StringCopyToPasteboardTests {
    /// Runs the body with a private pasteboard, so the tests never touch the user's clipboard.
    func withPrivatePasteboard(_ body: (UIPasteboard) -> Void) {
        let pasteboard = UIPasteboard.withUniqueName()
        defer { UIPasteboard.remove(withName: pasteboard.name) }
        body(pasteboard)
    }

    @Test(arguments: ["Hello world!", "👋🏽 e\u{301} 🇸🇾", "line 1\r\nline 2", "مرحبا بالعالم"])
    func copiesTheStringToThePasteboard(_ string: String) {
        withPrivatePasteboard { pasteboard in
            string.copyToPasteboard(pasteboard)
            #expect(pasteboard.string == string)
            #expect(pasteboard.hasStrings)
        }
    }

    @Test
    func copiesTheEmptyString() {
        withPrivatePasteboard { pasteboard in
            pasteboard.string = "old"
            "".copyToPasteboard(pasteboard)
            #expect(pasteboard.string == "")
        }
    }

    @Test
    func replacesPreviousContents() {
        withPrivatePasteboard { pasteboard in
            pasteboard.items = [
                [UTType.html.identifier: "<b>old</b>", UTType.utf8PlainText.identifier: "old"],
                [UTType.utf8PlainText.identifier: "second"]
            ]
            "new".copyToPasteboard(pasteboard)
            #expect(pasteboard.string == "new")
            #expect(pasteboard.strings == ["new"])
            #expect(pasteboard.numberOfItems == 1)
            #expect(!pasteboard.contains(pasteboardTypes: [UTType.html.identifier]))
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
