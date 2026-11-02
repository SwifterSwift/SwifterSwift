// UITextField+AddToolbarTests.swift - Copyright 2026 SwifterSwift

#if canImport(UIKit) && !os(watchOS) && !os(tvOS) && !os(visionOS)
import SwifterSwiftUIKit
import Testing
import UIKit

@MainActor
struct UITextFieldAddToolbarTests {
    @Test
    func setsToolbarWithItemsAsInputAccessoryView() throws {
        let textField = UITextField(frame: CGRect(x: 0, y: 0, width: 200, height: 44))
        let done = UIBarButtonItem(systemItem: .done)
        let flexibleSpace = UIBarButtonItem.flexibleSpace()
        let toolbar = textField.addToolbar(items: [flexibleSpace, done])
        let accessory = try #require(textField.inputAccessoryView as? UIToolbar)
        #expect(accessory === toolbar)
        #expect(toolbar.items == [flexibleSpace, done])
    }

    @Test
    func sizesToolbarToStandardHeight() {
        let textField = UITextField()
        let toolbar = textField.addToolbar(items: [UIBarButtonItem(systemItem: .done)])
        #expect(toolbar.frame.height == toolbar.sizeThatFits(.zero).height)
        #expect(toolbar.frame.height > 0)
    }

    @Test
    func acceptsEmptyItems() {
        let textField = UITextField()
        let toolbar = textField.addToolbar(items: [])
        #expect(textField.inputAccessoryView === toolbar)
        #expect(toolbar.items?.isEmpty ?? true)
    }

    @Test
    func replacesExistingAccessoryView() {
        let textField = UITextField()
        let first = textField.addToolbar(items: [UIBarButtonItem(systemItem: .cancel)])
        let second = textField.addToolbar(items: [UIBarButtonItem(systemItem: .done)])
        #expect(first !== second)
        #expect(textField.inputAccessoryView === second)
    }
}
#endif
