// UIDatePickerExtensions.swift - Copyright 2020 SwifterSwift

#if canImport(UIKit) && os(iOS)
import UIKit

// MARK: - Properties

public extension UIDatePicker {
    #if !targetEnvironment(macCatalyst)
    /// SwifterSwift: Text color of UIDatePicker.
    var textColor: UIColor? {
        set {
            setValue(newValue, forKeyPath: "textColor")
        }
        get {
            return value(forKeyPath: "textColor") as? UIColor
        }
    }
    #endif
}

#endif
