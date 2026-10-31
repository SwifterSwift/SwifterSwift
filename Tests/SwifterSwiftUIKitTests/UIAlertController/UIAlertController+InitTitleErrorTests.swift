// UIAlertController+InitTitleErrorTests.swift - Copyright 2026 SwifterSwift

#if canImport(UIKit) && !os(watchOS)
import Foundation
import SwifterSwiftUIKit
import Testing
import UIKit

@MainActor
struct UIAlertControllerInitTitleErrorTests {
    struct DescribedError: LocalizedError {
        var errorDescription: String? { "The file couldn't be saved." }
    }

    struct PlainError: Error {}

    @Test
    func showsLocalizedDescriptionAsMessage() {
        let error = DescribedError()
        let alert = UIAlertController(error: error)
        #expect(alert.message == "The file couldn't be saved.")
        #expect(alert.message == error.localizedDescription)
    }

    @Test
    func usesLocalizedDefaultTitles() {
        let alert = UIAlertController(error: PlainError())
        #expect(alert.title == String(localized: "Error"))
        #expect(alert.actions.map(\.title) == [String(localized: "OK")])
    }

    @Test
    func alwaysUsesAlertStyleWithOneDefaultAction() throws {
        let alert = UIAlertController(error: PlainError())
        #expect(alert.preferredStyle == .alert)
        let action = try #require(alert.actions.first)
        #expect(alert.actions.count == 1)
        #expect(action.style == .default)
    }

    @Test
    func usesGivenTitlesAndTintColor() {
        let alert = UIAlertController(
            title: "خطأ",
            error: DescribedError(),
            defaultActionButtonTitle: "حسناً",
            tintColor: .systemRed
        )
        #expect(alert.title == "خطأ")
        #expect(alert.actions.map(\.title) == ["حسناً"])
        #expect(alert.view.tintColor == .systemRed)
    }

    @Test
    func showsNSErrorDescription() {
        let error = NSError(
            domain: "com.example",
            code: 42,
            userInfo: [NSLocalizedDescriptionKey: "Le serveur est indisponible."]
        )
        let alert = UIAlertController(error: error)
        #expect(alert.message == "Le serveur est indisponible.")
    }
}
#endif
