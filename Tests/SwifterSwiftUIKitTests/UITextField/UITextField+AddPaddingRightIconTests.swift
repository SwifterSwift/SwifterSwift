// UITextField+AddPaddingRightIconTests.swift - Copyright 2026 SwifterSwift

#if canImport(UIKit) && !os(watchOS)
import SwifterSwiftUIKit
import Testing
import UIKit

@MainActor
struct UITextFieldAddPaddingRightIconTests {
    let icon = UIGraphicsImageRenderer(size: CGSize(width: 20, height: 16)).image { context in
        UIColor.systemBlue.setFill()
        context.fill(CGRect(x: 0, y: 0, width: 20, height: 16))
    }

    @Test
    func addsCenteredIconWithPadding() throws {
        let textField = UITextField(frame: CGRect(x: 0, y: 0, width: 200, height: 44))
        textField.addPaddingRightIcon(icon, padding: 10)
        let rightView = try #require(textField.rightView)
        #expect(rightView.frame.size == CGSize(width: 30, height: 16))
        #expect(textField.rightViewMode == .always)

        let imageView = try #require(rightView.subviews.first as? UIImageView)
        #expect(rightView.subviews.count == 1)
        #expect(imageView.image === icon)
        #expect(imageView.frame == rightView.bounds)
        #expect(imageView.contentMode == .center)
    }

    @Test(arguments: [0, 0.5, 100] as [CGFloat])
    func widensContainerByPadding(_ padding: CGFloat) {
        let textField = UITextField()
        textField.addPaddingRightIcon(icon, padding: padding)
        #expect(textField.rightView?.frame.width == 20 + padding)
    }

    @Test(arguments: [-1, -50, -.greatestFiniteMagnitude] as [CGFloat])
    func treatsNegativePaddingAsZero(_ padding: CGFloat) {
        let textField = UITextField()
        textField.addPaddingRightIcon(icon, padding: padding)
        #expect(textField.rightView?.frame.size == CGSize(width: 20, height: 16))
    }

    @Test
    func acceptsEmptyImage() {
        let textField = UITextField()
        textField.addPaddingRightIcon(UIImage(), padding: 8)
        #expect(textField.rightView?.frame.size == CGSize(width: 8, height: 0))
    }

    @Test
    func replacesExistingRightViewOnly() {
        let textField = UITextField()
        let existing = UIView()
        textField.rightView = existing
        textField.addPaddingRightIcon(icon, padding: 4)
        #expect(textField.rightView !== existing)
        #expect(textField.leftView == nil)
    }
}
#endif
