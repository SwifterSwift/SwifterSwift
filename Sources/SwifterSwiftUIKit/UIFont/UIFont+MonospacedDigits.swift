// UIFont+MonospacedDigits.swift - Copyright 2026 SwifterSwift

#if canImport(UIKit)
import CoreText
import UIKit

public extension UIFont {
    /// SwifterSwift: A version of the font whose digits all have the same width.
    ///
    /// Monospaced digits keep numbers from shifting sideways when they change, which suits timers, counters and columns
    /// of figures. Only the digits change; letters keep their proportional widths. For a font where every character has
    /// the same width, use `UIFont.monospacedSystemFont(ofSize:weight:)` instead.
    ///
    /// `UIFont.monospacedDigitSystemFont(ofSize:weight:)` does the same for the system font only. This property works
    /// on any font that supports the number spacing feature, including Dynamic Type fonts, and keeps the font's other
    /// feature settings. Fonts without the feature draw their digits as before.
    ///
    /// ```swift
    /// let timer = UIFont.preferredFont(forTextStyle: .title1).monospacedDigits
    /// label.font = timer  // "11:11" and "88:88" now have the same width
    /// ```
    var monospacedDigits: UIFont {
        let existingSettings = fontDescriptor.object(forKey: .featureSettings) as? [[UIFontDescriptor.FeatureKey: Any]]
        let otherSettings = (existingSettings ?? []).filter { ($0[.type] as? Int) != kNumberSpacingType }
        let monospacedNumbers: [UIFontDescriptor.FeatureKey: Any] = [
            .type: kNumberSpacingType,
            .selector: kMonospacedNumbersSelector
        ]
        let descriptor = fontDescriptor.addingAttributes([.featureSettings: otherSettings + [monospacedNumbers]])
        return UIFont(descriptor: descriptor, size: 0)
    }
}
#endif
