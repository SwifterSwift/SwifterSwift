// NSFont+MonospacedDigits.swift - Copyright 2026 SwifterSwift

#if canImport(AppKit) && !targetEnvironment(macCatalyst)
import AppKit
import CoreText

public extension NSFont {
    /// SwifterSwift: A version of the font whose digits all have the same width.
    ///
    /// Monospaced digits keep numbers from shifting sideways when they change, which suits timers, counters and columns
    /// of figures. Only the digits change; letters keep their proportional widths. For a font where every character has
    /// the same width, use `NSFont.monospacedSystemFont(ofSize:weight:)` instead.
    ///
    /// `NSFont.monospacedDigitSystemFont(ofSize:weight:)` does the same for the system font only. This property works
    /// on any font that supports the number spacing feature and keeps the font's other feature settings. Fonts without
    /// the feature draw their digits as before. If the font can't be recreated, it's returned unchanged.
    ///
    /// ```swift
    /// let timer = NSFont.preferredFont(forTextStyle: .title1).monospacedDigits
    /// label.font = timer  // "11:11" and "88:88" now have the same width
    /// ```
    var monospacedDigits: NSFont {
        let existingSettings = fontDescriptor.object(forKey: .featureSettings) as? [[NSFontDescriptor.FeatureKey: Any]]
        let otherSettings = (existingSettings ?? []).filter { ($0[.typeIdentifier] as? Int) != kNumberSpacingType }
        let monospacedNumbers: [NSFontDescriptor.FeatureKey: Any] = [
            .typeIdentifier: kNumberSpacingType,
            .selectorIdentifier: kMonospacedNumbersSelector
        ]
        let descriptor = fontDescriptor.addingAttributes([.featureSettings: otherSettings + [monospacedNumbers]])
        return NSFont(descriptor: descriptor, size: 0) ?? self
    }
}
#endif
