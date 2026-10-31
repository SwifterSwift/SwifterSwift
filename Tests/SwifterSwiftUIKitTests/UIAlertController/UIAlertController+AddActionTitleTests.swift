// UIAlertController+AddActionTitleTests.swift - Copyright 2026 SwifterSwift

#if canImport(UIKit) && !os(watchOS)
import SwifterSwiftUIKit
import Testing
import UIKit

@MainActor
struct UIAlertControllerAddActionTitleTests {
    @Test
    func addsActionWithGivenProperties() {
        let alert = UIAlertController(title: "Title", message: "Message", preferredStyle: .alert)
        let action = alert.addAction(title: "Delete", style: .destructive, isEnabled: false)
        #expect(alert.actions == [action])
        #expect(action.title == "Delete")
        #expect(action.style == .destructive)
        #expect(!action.isEnabled)
    }

    @Test
    func usesDefaultStyleAndEnabledByDefault() {
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        let action = alert.addAction(title: "Share")
        #expect(action.style == .default)
        #expect(action.isEnabled)
    }

    @Test
    func appendsActionsInOrder() {
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .alert)
        let existing = UIAlertAction(title: "Existing", style: .default)
        alert.addAction(existing)
        let cancel = alert.addAction(title: "Cancel", style: .cancel)
        let save = alert.addAction(title: "Save", handler: { _ in })
        #expect(alert.actions == [existing, cancel, save])
    }

    @Test
    func returnsActionThatCanBeThePreferredAction() {
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .alert)
        alert.addAction(title: "Cancel", style: .cancel)
        let save = alert.addAction(title: "Save")
        alert.preferredAction = save
        #expect(alert.preferredAction === save)
    }

    @Test
    func returnedActionCanBeEnabledLater() {
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .alert)
        let save = alert.addAction(title: "Save", isEnabled: false)
        save.isEnabled = true
        #expect(alert.actions.first?.isEnabled == true)
    }

    @Test(arguments: ["", "Supprimer 🗑️", "e\u{301}", "🇸🇾 حذف"])
    func keepsTitleAsIs(_ title: String) {
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .alert)
        let action = alert.addAction(title: title)
        #expect(action.title == title)
    }
}
#endif
