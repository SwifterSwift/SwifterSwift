// UISegmentedControl+SegmentTitlesTests.swift - Copyright 2026 SwifterSwift

#if canImport(UIKit) && !os(watchOS)
import SwifterSwiftUIKit
import Testing
import UIKit

@MainActor
struct UISegmentedControlSegmentTitlesTests {
    let image = UIGraphicsImageRenderer(size: CGSize(width: 10, height: 10)).image { _ in }

    @Test
    func isEmptyWithoutSegments() {
        #expect(UISegmentedControl().segmentTitles.isEmpty)
    }

    @Test
    func keepsIndicesAlignedWithImageSegments() {
        let control = UISegmentedControl(items: ["Day", image, "Year"])
        #expect(control.segmentTitles == ["Day", nil, "Year"])
    }

    @Test
    func createsSegmentsFromTitles() {
        let control = UISegmentedControl()
        control.segmentTitles = ["One", "Two", "Three"]
        #expect(control.numberOfSegments == 3)
        #expect(control.segmentTitles == ["One", "Two", "Three"])
    }

    @Test
    func keepsSelectionWhenItRemains() {
        let control = UISegmentedControl(items: ["A", "B", "C"])
        control.selectedSegmentIndex = 1
        control.segmentTitles = ["X", "Y", "Z", "W"]
        #expect(control.segmentTitles == ["X", "Y", "Z", "W"])
        #expect(control.selectedSegmentIndex == 1)
    }

    @Test
    func removesSegmentsPastTheEnd() {
        let control = UISegmentedControl(items: ["A", "B", "C"])
        control.selectedSegmentIndex = 2
        control.segmentTitles = ["A"]
        #expect(control.numberOfSegments == 1)
        #expect(control.selectedSegmentIndex == UISegmentedControl.noSegment)
    }

    @Test
    func keepsSelectionWhenLaterSegmentsAreRemoved() {
        let control = UISegmentedControl(items: ["A", "B", "C", "D"])
        control.selectedSegmentIndex = 1
        control.segmentTitles = ["A", "B"]
        #expect(control.selectedSegmentIndex == 1)
    }

    @Test
    func keepsNoSelection() {
        let control = UISegmentedControl(items: ["A", "B", "C"])
        control.segmentTitles = ["A"]
        #expect(control.selectedSegmentIndex == UISegmentedControl.noSegment)
    }

    @Test
    func removesAllSegmentsForEmptyArray() {
        let control = UISegmentedControl(items: ["A", "B"])
        control.segmentTitles = []
        #expect(control.numberOfSegments == 0)
    }

    @Test
    func keepsSettingsOfRemainingSegments() {
        let control = UISegmentedControl(items: ["A", "B"])
        control.setEnabled(false, forSegmentAt: 0)
        control.setWidth(60, forSegmentAt: 1)
        control.segmentTitles = ["First", "Second", "Third"]
        #expect(!control.isEnabledForSegment(at: 0))
        #expect(control.widthForSegment(at: 1) == 60)
        #expect(control.isEnabledForSegment(at: 2))
    }

    @Test
    func replacesImageWhenTitleChanges() {
        let control = UISegmentedControl(items: ["A", image])
        control.segmentTitles = ["A", "B"]
        #expect(control.titleForSegment(at: 1) == "B")
        #expect(control.imageForSegment(at: 1) == nil)
    }

    @Test
    func assigningCurrentValueKeepsImages() {
        let control = UISegmentedControl(items: ["A", image, "C"])
        control.segmentTitles = control.segmentTitles
        #expect(control.imageForSegment(at: 1) === image)
        #expect(control.segmentTitles == ["A", nil, "C"])
    }

    @Test
    func insertsUntitledSegmentForNil() {
        let control = UISegmentedControl()
        control.segmentTitles = ["A", nil]
        #expect(control.numberOfSegments == 2)
        #expect(control.segmentTitles == ["A", nil])
    }

    @Test(arguments: ["", "👨‍👩‍👧‍👦", "🇸🇾", "e\u{301}", "日本語"])
    func keepsTitlesAsIs(_ title: String) {
        let control = UISegmentedControl()
        control.segmentTitles = [title]
        #expect(control.segmentTitles == [title])
    }
}
#endif
