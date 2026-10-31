// UITextField+AddPaddingLeftIconTests.swift - Copyright 2026 SwifterSwift

#if canImport(UIKit) && !os(watchOS)
import SwifterSwiftUIKit
import Testing
import UIKit

@MainActor
struct UITextFieldAddPaddingLeftIconTests {
    let icon = UIGraphicsImageRenderer(size: CGSize(width: 20, height: 16)).image { context in
        UIColor.systemBlue.setFill()
        context.fill(CGRect(x: 0, y: 0, width: 20, height: 16))
    }

    @Test
    func addsCenteredIconWithPadding() throws {
        let textField = UITextField(frame: CGRect(x: 0, y: 0, width: 200, height: 44))
        textField.addPaddingLeftIcon(icon, padding: 10)
        let leftView = try #require(textField.leftView)
        #expect(leftView.frame.size == CGSize(width: 30, height: 16))
        #expect(textField.leftViewMode == .always)

        let imageView = try #require(leftView.subviews.first as? UIImageView)
        #expect(leftView.subviews.count == 1)
        #expect(imageView.image === icon)
        #expect(imageView.frame == leftView.bounds)
        #expect(imageView.contentMode == .center)
    }

    @Test(arguments: [0, 0.5, 100] as [CGFloat])
    func widensContainerByPadding(_ padding: CGFloat) {
        let textField = UITextField()
        textField.addPaddingLeftIcon(icon, padding: padding)
        #expect(textField.leftView?.frame.width == 20 + padding)
    }

    @Test(arguments: [-1, -50, -.greatestFiniteMagnitude] as [CGFloat])
    func treatsNegativePaddingAsZero(_ padding: CGFloat) {
        let textField = UITextField()
        textField.addPaddingLeftIcon(icon, padding: padding)
        #expect(textField.leftView?.frame.size == CGSize(width: 20, height: 16))
    }

    @Test
    func acceptsEmptyImage() {
        let textField = UITextField()
        textField.addPaddingLeftIcon(UIImage(), padding: 8)
        #expect(textField.leftView?.frame.size == CGSize(width: 8, height: 0))
    }

    @Test
    func replacesExistingLeftViewOnly() {
        let textField = UITextField()
        let existing = UIView()
        textField.leftView = existing
        textField.addPaddingLeftIcon(icon, padding: 4)
        #expect(textField.leftView !== existing)
        #expect(textField.rightView == nil)
    }
}
#endif
