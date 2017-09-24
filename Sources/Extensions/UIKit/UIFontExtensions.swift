//
//  UIFontExtensions.swift
//  SwifterSwift 
//
//  Created by Benjamin Meyer on 9/16/17.
//

#if os(iOS) || os(tvOS) || os(watchOS)
import UIKit

// MARK: - Properties
public extension UIFont {
    /// SwifterSwift: Font as monospaced digit font. [Monospaced Font explanation](https://en.wikipedia.org/wiki/Monospaced_font)
    ///
    ///     UIFont.preferredFont(forTextStyle: .body).asMonospacedDigitFont()
    ///
    public func asMonospacedDigitFont() -> UIFont {
        let fontDescriptorFeatureSettings = [[UIFontFeatureTypeIdentifierKey: kNumberSpacingType, UIFontFeatureSelectorIdentifierKey: kMonospacedNumbersSelector]]
        let fontDescriptorAttributes = [UIFontDescriptorFeatureSettingsAttribute: fontDescriptorFeatureSettings]
        let newFontDescriptor = fontDescriptor.addingAttributes(fontDescriptorAttributes)
        return UIFont(descriptor: newFontDescriptor, size: 0)
    }
}
#endif
