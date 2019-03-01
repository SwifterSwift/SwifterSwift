//
//  UIBarButtonItemExtensions.swift
//  SwifterSwift
//
//  Created by Omar Albeik on 08/12/2016.
//  Copyright © 2016 SwifterSwift
//

#if canImport(UIKit) && !os(watchOS)
import UIKit

// MARK: - Methods
public extension UIBarButtonItem {

    /// SwifterSwift: Add Target to UIBarButtonItem
    ///
    /// - Parameters:
    ///   - target: target.
    ///   - action: selector to run when button is tapped.
    public func addTargetForAction(_ target: AnyObject, action: Selector) {
        self.target = target
        self.action = action
    }

}

// MARK: - Properties
extension UIBarButtonItem {
  
    /// Localized title
    @IBInspectable var localizedTitle: String {
      get {
        return self.title ?? ""
      }
      set {
        self.title = NSLocalizedString(newValue, comment: "")
      }
    }
}

#endif
