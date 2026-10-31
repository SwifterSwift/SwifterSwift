// UITextField+AddPaddingLeftTests.swift - Copyright 2026 SwifterSwift

#if canImport(UIKit) && !os(watchOS)
import SwifterSwiftUIKit
import Testing
import UIKit

@MainActor
struct UITextFieldAddPaddingLeftTests {
    @Test(arguments: [0, 0.5, 12, 40, 1_000] as [CGFloat])
    func addsLeftViewOfGivenWidth(_ padding: CGFloat) throws {
        let textField = UITextField(frame: CGRect(x: 0, y: 0, width: 200, height: 44))
        textField.addPaddingLeft(padding)
        let leftView = try #require(textField.leftView)
        #expect(leftView.frame.width == padding)
        #expect(leftView.frame.height == 44)
        #expect(leftView.subviews.isEmpty)
        #expect(textField.leftViewMode == .always)
    }

    @Test
    func movesTextRight() {
        let textField = UITextField(frame: CGRect(x: 0, y: 0, width: 200, height: 44))
        let originalTextRect = textField.textRect(forBounds: textField.bounds)
        textField.addPaddingLeft(30)
        let paddedTextRect = textField.textRect(forBounds: textField.bounds)
        #expect(paddedTextRect.minX >= originalTextRect.minX + 30)
    }

    @Test
    func replacesExistingLeftView() {
        let textField = UITextField(frame: CGRect(x: 0, y: 0, width: 200, height: 44))
        let existing = UIView()
        textField.leftView = existing
        textField.leftViewMode = .never
        textField.addPaddingLeft(8)
        #expect(textField.leftView !== existing)
        #expect(textField.leftViewMode == .always)
    }

    @Test(arguments: [-1, -100, -.greatestFiniteMagnitude] as [CGFloat])
    func treatsNegativePaddingAsZero(_ padding: CGFloat) {
        let textField = UITextField(frame: CGRect(x: 0, y: 0, width: 200, height: 44))
        textField.addPaddingLeft(padding)
        #expect(textField.leftView?.frame.width == 0)
    }

    @Test
    func leavesRightSideUnchanged() {
        let textField = UITextField(frame: CGRect(x: 0, y: 0, width: 200, height: 44))
        textField.addPaddingLeft(10)
        #expect(textField.rightView == nil)
        #expect(textField.rightViewMode == .never)
    }
}
#endif
