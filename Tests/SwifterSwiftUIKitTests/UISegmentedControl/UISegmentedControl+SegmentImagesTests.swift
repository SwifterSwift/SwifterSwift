// UISegmentedControl+SegmentImagesTests.swift - Copyright 2026 SwifterSwift

#if canImport(UIKit) && !os(watchOS)
import SwifterSwiftUIKit
import Testing
import UIKit

@MainActor
struct UISegmentedControlSegmentImagesTests {
    func makeImage(width: CGFloat) -> UIImage {
        UIGraphicsImageRenderer(size: CGSize(width: width, height: 10)).image { _ in }
    }

    @Test
    func isEmptyWithoutSegments() {
        #expect(UISegmentedControl().segmentImages.isEmpty)
    }

    @Test
    func keepsIndicesAlignedWithTitleSegments() {
        let first = makeImage(width: 10)
        let third = makeImage(width: 12)
        let control = UISegmentedControl(items: [first, "Map", third])
        #expect(control.segmentImages == [first, nil, third])
    }

    @Test
    func createsSegmentsFromImages() {
        let images = [makeImage(width: 10), makeImage(width: 12)]
        let control = UISegmentedControl()
        control.segmentImages = images
        #expect(control.numberOfSegments == 2)
        #expect(control.segmentImages == images)
    }

    @Test
    func keepsSelectionWhenItRemains() {
        let control = UISegmentedControl(items: [makeImage(width: 10), makeImage(width: 12)])
        control.selectedSegmentIndex = 1
        control.segmentImages = [makeImage(width: 14), makeImage(width: 16), makeImage(width: 18)]
        #expect(control.numberOfSegments == 3)
        #expect(control.selectedSegmentIndex == 1)
    }

    @Test
    func removesSegmentsPastTheEnd() {
        let control = UISegmentedControl(items: [makeImage(width: 10), makeImage(width: 12), makeImage(width: 14)])
        control.selectedSegmentIndex = 2
        control.segmentImages = [makeImage(width: 10)]
        #expect(control.numberOfSegments == 1)
        #expect(control.selectedSegmentIndex == UISegmentedControl.noSegment)
    }

    @Test
    func keepsSelectionWhenLaterSegmentsAreRemoved() {
        let control = UISegmentedControl(items: [makeImage(width: 10), makeImage(width: 12), makeImage(width: 14)])
        control.selectedSegmentIndex = 0
        control.segmentImages = [makeImage(width: 16)]
        #expect(control.selectedSegmentIndex == 0)
    }

    @Test
    func removesAllSegmentsForEmptyArray() {
        let control = UISegmentedControl(items: [makeImage(width: 10)])
        control.segmentImages = []
        #expect(control.numberOfSegments == 0)
    }

    @Test
    func keepsSettingsOfRemainingSegments() {
        let control = UISegmentedControl(items: [makeImage(width: 10), makeImage(width: 12)])
        control.setEnabled(false, forSegmentAt: 1)
        control.segmentImages = [makeImage(width: 14), makeImage(width: 16)]
        #expect(control.isEnabledForSegment(at: 0))
        #expect(!control.isEnabledForSegment(at: 1))
    }

    @Test
    func replacesTitleWhenImageChanges() {
        let image = makeImage(width: 10)
        let control = UISegmentedControl(items: ["List", "Map"])
        control.segmentImages = [nil, image]
        #expect(control.imageForSegment(at: 1) === image)
        #expect(control.titleForSegment(at: 1) == nil)
        #expect(control.titleForSegment(at: 0) == "List")
    }

    @Test
    func assigningCurrentValueKeepsTitles() {
        let image = makeImage(width: 10)
        let control = UISegmentedControl(items: ["List", image])
        control.segmentImages = control.segmentImages
        #expect(control.titleForSegment(at: 0) == "List")
        #expect(control.imageForSegment(at: 1) === image)
    }

    @Test
    func insertsEmptySegmentForNil() {
        let control = UISegmentedControl()
        control.segmentImages = [nil]
        #expect(control.numberOfSegments == 1)
        #expect(control.segmentImages == [nil])
    }
}
#endif
