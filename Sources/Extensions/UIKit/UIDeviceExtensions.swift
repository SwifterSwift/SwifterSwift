//
//  UIDeviceExtensions.swift
//  SwifterSwift
//
//  Created by Marco Capano on 30/07/2018.
//  Copyright © 2018 SwifterSwift
//

import UIKit
import SystemConfiguration.CaptiveNetwork

extension UIDevice {

    /// SwifterSwift: Returns the ssid for the current network.
    /// This needs Access WiFi Information capability ON.
    public var ssid: String? {
        guard let interfaceNames = CNCopySupportedInterfaces() as? [String] else { return nil }

        return interfaceNames.compactMap { name in
            guard let info = CNCopyCurrentNetworkInfo(name as CFString) as? [String: AnyObject] else { return nil }
            guard let ssid = info[kCNNetworkInfoKeySSID as String] as? String else { return nil }

            return ssid
            }.first
    }

    /// SwifterSwift: Returns the bssid for the current network.
    /// This needs Access WiFi Information capability ON.
    public var bssid: String? {
        guard let interfaceNames = CNCopySupportedInterfaces() as? [String] else { return nil }

        return interfaceNames.compactMap { name in
            guard let info = CNCopyCurrentNetworkInfo(name as CFString) as? [String: AnyObject] else { return nil }
            guard let bssid = info[kCNNetworkInfoKeyBSSID as String] as? String else { return nil }

            return bssid
            }.first
    }
}
