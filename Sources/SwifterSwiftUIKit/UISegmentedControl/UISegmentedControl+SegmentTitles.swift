// UISegmentedControl+SegmentTitles.swift - Copyright 2026 SwifterSwift

#if canImport(UIKit) && !os(watchOS)
import UIKit

public extension UISegmentedControl {
    /// SwifterSwift: The titles of the segments, one per segment, with `nil` for a segment that has no title.
    ///
    /// Reading the property returns exactly `numberOfSegments` elements, so each title stays at the index of its
    /// segment, also when some segments show an image instead of a title.
    ///
    /// Setting the property updates the control to have one segment per element. Existing segments are updated in
    /// place, so the selected segment, the enabled state, the widths and the actions of the segments that remain are
    /// kept. Extra segments are added at the end, and segments past the end of the new array are removed; when the
    /// selected segment is removed, no segment is selected (`UISegmentedControl.noSegment`). A segment whose title
    /// changes loses its image, because a segment shows either a title or an image; a segment whose title doesn't
    /// change is left alone, so assigning the current value back changes nothing.
    ///
    /// ```swift
    /// let control = UISegmentedControl(items: ["Day", UIImage(systemName: "calendar")!, "Year"])
    /// control.segmentTitles  // ["Day", nil, "Year"]
    /// control.selectedSegmentIndex = 0
    /// control.segmentTitles = ["Day", "Week", "Month", "Year"]
    /// control.numberOfSegments  // 4
    /// control.selectedSegmentIndex  // 0
    /// ```
    ///
    /// - Complexity: O(*n*), where *n* is the larger of the current and the new number of segments.
    var segmentTitles: [String?] {
        get {
            (0..<numberOfSegments).map { titleForSegment(at: $0) }
        }
        set {
            let selectedIndex = selectedSegmentIndex
            while numberOfSegments > newValue.count {
                removeSegment(at: numberOfSegments - 1, animated: false)
            }
            for (index, title) in newValue.enumerated() {
                if index < numberOfSegments {
                    if titleForSegment(at: index) != title {
                        setTitle(title, forSegmentAt: index)
                    }
                } else {
                    insertSegment(withTitle: title, at: index, animated: false)
                }
            }
            // UIKit shifts the selected index when it removes segments, so set it explicitly.
            selectedSegmentIndex = selectedIndex < newValue.count ? selectedIndex : UISegmentedControl.noSegment
        }
    }
}
#endif
