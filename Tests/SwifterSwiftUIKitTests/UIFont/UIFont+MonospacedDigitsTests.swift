// UIFont+MonospacedDigitsTests.swift - Copyright 2026 SwifterSwift

#if canImport(UIKit)
import CoreText
import SwifterSwiftUIKit
import Testing
import UIKit

struct UIFontMonospacedDigitsTests {
    @Test
    func requestsMonospacedNumbers() throws {
        let font = UIFont.systemFont(ofSize: 17).monospacedDigits
        let settings = try #require(
            font.fontDescriptor.object(forKey: .featureSettings) as? [[UIFontDescriptor.FeatureKey: Any]]
        )
        let numberSpacing = settings.filter { ($0[.type] as? Int) == kNumberSpacingType }
        #expect(numberSpacing.count == 1)
        #expect(numberSpacing.first?[.selector] as? Int == kMonospacedNumbersSelector)
    }

    @Test
    func givesEveryDigitTheSameWidth() {
        let font = UIFont.systemFont(ofSize: 20).monospacedDigits
        let widths = Set("0123456789".map { String($0).size(withAttributes: [.font: font]).width })
        #expect(widths.count == 1)
    }

    @Test
    func keepsTheFaceSizeAndTraits() throws {
        let font = try #require(UIFont(name: "Helvetica-Oblique", size: 15))
        let monospaced = font.monospacedDigits
        #expect(monospaced.fontName == "Helvetica-Oblique")
        #expect(monospaced.pointSize == 15)
        #expect(UIFont.boldSystemFont(ofSize: 17).monospacedDigits.fontDescriptor.symbolicTraits.contains(.traitBold))
    }

    @Test
    func keepsOtherFeatureSettings() throws {
        let smallCaps: [UIFontDescriptor.FeatureKey: Any] = [
            .type: kLowerCaseType,
            .selector: kLowerCaseSmallCapsSelector
        ]
        let base = UIFont.systemFont(ofSize: 17)
        let font = UIFont(descriptor: base.fontDescriptor.addingAttributes([.featureSettings: [smallCaps]]), size: 0)
        let settings = try #require(
            font.monospacedDigits.fontDescriptor.object(forKey: .featureSettings)
                as? [[UIFontDescriptor.FeatureKey: Any]]
        )
        #expect(settings.contains { ($0[.type] as? Int) == kLowerCaseType })
        #expect(settings.contains { ($0[.type] as? Int) == kNumberSpacingType })
    }

    @Test
    func replacesAnExistingNumberSpacingSetting() throws {
        let proportional: [UIFontDescriptor.FeatureKey: Any] = [
            .type: kNumberSpacingType,
            .selector: kProportionalNumbersSelector
        ]
        let base = UIFont.systemFont(ofSize: 17)
        let font = UIFont(descriptor: base.fontDescriptor.addingAttributes([.featureSettings: [proportional]]), size: 0)
        let twice = font.monospacedDigits.monospacedDigits
        let settings = try #require(
            twice.fontDescriptor.object(forKey: .featureSettings) as? [[UIFontDescriptor.FeatureKey: Any]]
        )
        let numberSpacing = settings.filter { ($0[.type] as? Int) == kNumberSpacingType }
        #expect(numberSpacing.count == 1)
        #expect(numberSpacing.first?[.selector] as? Int == kMonospacedNumbersSelector)
    }

    #if !os(watchOS)
    @Test
    func worksOnTextStyleFonts() {
        let traits = UITraitCollection(preferredContentSizeCategory: .extraExtraLarge)
        let font = UIFont.preferredFont(forTextStyle: .title1, compatibleWith: traits)
        let monospaced = font.monospacedDigits
        #expect(monospaced.pointSize == font.pointSize)
        let widths = Set(["1", "8"].map { $0.size(withAttributes: [.font: monospaced]).width })
        #expect(widths.count == 1)
    }
    #endif

    @Test
    func worksOnTheSystemMonospacedDigitFont() throws {
        let font = UIFont.monospacedDigitSystemFont(ofSize: 17, weight: .regular).monospacedDigits
        let settings = try #require(
            font.fontDescriptor.object(forKey: .featureSettings) as? [[UIFontDescriptor.FeatureKey: Any]]
        )
        #expect(settings.filter { ($0[.type] as? Int) == kNumberSpacingType }.count == 1)
    }
}
#endif
