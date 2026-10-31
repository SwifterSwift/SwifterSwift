// UIAlertController+InitTitleMessageTests.swift - Copyright 2026 SwifterSwift

#if canImport(UIKit) && !os(watchOS)
import Foundation
import SwifterSwiftUIKit
import Testing
import UIKit

@MainActor
struct UIAlertControllerInitTitleMessageTests {
    @Test
    func createsAlertWithOneDismissButton() throws {
        let alert = UIAlertController(title: "Saved", message: "Your changes were saved.")
        #expect(alert.title == "Saved")
        #expect(alert.message == "Your changes were saved.")
        #expect(alert.preferredStyle == .alert)
        let action = try #require(alert.actions.first)
        #expect(alert.actions.count == 1)
        #expect(action.style == .default)
        #expect(action.isEnabled)
    }

    @Test
    func usesLocalizedOKAsDefaultButtonTitle() {
        let alert = UIAlertController(title: "Saved")
        #expect(alert.message == nil)
        #expect(alert.actions.map(\.title) == [String(localized: "OK")])
    }

    @Test
    func usesGivenButtonTitleAndTintColor() {
        let alert = UIAlertController(
            title: "Gespeichert",
            message: "Änderungen gespeichert ✅",
            defaultActionButtonTitle: "Weiter",
            tintColor: .systemPink
        )
        #expect(alert.message == "Änderungen gespeichert ✅")
        #expect(alert.actions.map(\.title) == ["Weiter"])
        #expect(alert.view.tintColor == .systemPink)
    }

    @Test
    func keepsSystemTintWithoutTintColor() {
        let alert = UIAlertController(title: "Saved")
        let reference = UIAlertController(title: "Saved", message: nil, preferredStyle: .alert)
        #expect(alert.view.tintColor == reference.view.tintColor)
    }

    @Test
    func acceptsEmptyTitle() {
        let alert = UIAlertController(title: "", message: "")
        #expect(alert.title?.isEmpty == true)
        #expect(alert.actions.count == 1)
    }
}
#endif
