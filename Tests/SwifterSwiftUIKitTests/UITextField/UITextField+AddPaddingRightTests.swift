// UITextField+AddPaddingRightTests.swift - Copyright 2026 SwifterSwift

#if canImport(UIKit) && !os(watchOS)
import SwifterSwiftUIKit
import Testing
import UIKit

@MainActor
struct UITextFieldAddPaddingRightTests {
    @Test(arguments: [0, 0.5, 12, 40, 1_000] as [CGFloat])
    func addsRightViewOfGivenWidth(_ padding: CGFloat) throws {
        let textField = UITextField(frame: CGRect(x: 0, y: 0, width: 200, height: 44))
        textField.addPaddingRight(padding)
        let rightView = try #require(textField.rightView)
        #expect(rightView.frame.width == padding)
        #expect(rightView.frame.height == 44)
        #expect(rightView.subviews.isEmpty)
        #expect(textField.rightViewMode == .always)
    }

    #if !os(tvOS)
    // tvOS lays out text field contents differently, so the text rect doesn't shrink by the right view's width there.
    @Test
    func movesTextEndLeft() {
        let textField = UITextField(frame: CGRect(x: 0, y: 0, width: 200, height: 44))
        let originalTextRect = textField.textRect(forBounds: textField.bounds)
        textField.addPaddingRight(30)
        let paddedTextRect = textField.textRect(forBounds: textField.bounds)
        #expect(paddedTextRect.maxX <= originalTextRect.maxX - 30)
    }
    #endif

    @Test
    func replacesExistingRightView() {
        let textField = UITextField(frame: CGRect(x: 0, y: 0, width: 200, height: 44))
        let existing = UIView()
        textField.rightView = existing
        textField.rightViewMode = .whileEditing
        textField.addPaddingRight(8)
        #expect(textField.rightView !== existing)
        #expect(textField.rightViewMode == .always)
    }

    @Test(arguments: [-1, -100, -.greatestFiniteMagnitude] as [CGFloat])
    func treatsNegativePaddingAsZero(_ padding: CGFloat) {
        let textField = UITextField(frame: CGRect(x: 0, y: 0, width: 200, height: 44))
        textField.addPaddingRight(padding)
        #expect(textField.rightView?.frame.width == 0)
    }

    @Test
    func leavesLeftSideUnchanged() {
        let textField = UITextField(frame: CGRect(x: 0, y: 0, width: 200, height: 44))
        textField.addPaddingRight(10)
        #expect(textField.leftView == nil)
        #expect(textField.leftViewMode == .never)
    }
}
#endif
