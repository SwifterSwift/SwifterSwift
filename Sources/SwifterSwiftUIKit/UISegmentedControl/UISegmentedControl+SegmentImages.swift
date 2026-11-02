// UISegmentedControl+SegmentImages.swift - Copyright 2026 SwifterSwift

#if canImport(UIKit) && !os(watchOS)
import UIKit

public extension UISegmentedControl {
    /// SwifterSwift: The images of the segments, one per segment, with `nil` for a segment that has no image.
    ///
    /// Reading the property returns exactly `numberOfSegments` elements, so each image stays at the index of its
    /// segment, also when some segments show a title instead of an image.
    ///
    /// Setting the property updates the control to have one segment per element. Existing segments are updated in
    /// place, so the selected segment, the enabled state, the widths and the actions of the segments that remain are
    /// kept. Extra segments are added at the end, and segments past the end of the new array are removed; when the
    /// selected segment is removed, no segment is selected (`UISegmentedControl.noSegment`). A segment whose image
    /// changes loses its title, because a segment shows either a title or an image; a segment whose image doesn't
    /// change is left alone, so assigning the current value back changes nothing.
    ///
    /// ```swift
    /// let control = UISegmentedControl(items: [UIImage(systemName: "list.bullet")!, "Map"])
    /// control.segmentImages  // [list.bullet image, nil]
    /// control.segmentImages = [UIImage(systemName: "list.bullet"), UIImage(systemName: "map")]
    /// control.titleForSegment(at: 1)  // nil
    /// ```
    ///
    /// - Complexity: O(*n*), where *n* is the larger of the current and the new number of segments.
    var segmentImages: [UIImage?] {
        get {
            (0..<numberOfSegments).map { imageForSegment(at: $0) }
        }
        set {
            let selectedIndex = selectedSegmentIndex
            while numberOfSegments > newValue.count {
                removeSegment(at: numberOfSegments - 1, animated: false)
            }
            for (index, image) in newValue.enumerated() {
                if index < numberOfSegments {
                    if imageForSegment(at: index) !== image {
                        setImage(image, forSegmentAt: index)
                    }
                } else {
                    insertSegment(with: image, at: index, animated: false)
                }
            }
            // UIKit shifts the selected index when it removes segments, so set it explicitly.
            selectedSegmentIndex = selectedIndex < newValue.count ? selectedIndex : UISegmentedControl.noSegment
        }
    }
}
#endif
