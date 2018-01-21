//
//  UIDeviceExtensions.swift
//  SwifterSwift
//
//  Created by Anton Novoselov on 31/12/2017.
//  Copyright © 2017 SwifterSwift
//

#if os(iOS) || os(tvOS)
import UIKit
public extension UIDevice {
    /// Show country code of current locale for device
    static var countryISOCode: String? {
        return (Locale.current as NSLocale).object(forKey: NSLocale.Key.countryCode) as? String
    }
}
#endif
