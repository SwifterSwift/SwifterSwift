//
//  SwiftierSwift.swift
//  SwiftierSwift
//
//  Created by Omar Albeik on 8/8/16.
//  Copyright © 2016 Omar Albeik. All rights reserved.
//

import UIKit

public class SwiftierSwift {
    
    /// Return shared instance UIApplication
    public static var sharedApplication: UIApplication {
        return UIApplication.shared
    }
    
    /// Return shared instance of AppDelegate
    public static var delegate: UIApplicationDelegate {
        return UIApplication.shared.delegate as! AppDelegate
    }
    
    /// Return app current version
    public static var appVersion: String? {
        return Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String
    }
    
    /// Return app current build number
    public static var appBuild: String? {
        return Bundle.main.object(forInfoDictionaryKey: kCFBundleVersionKey as String) as? String
    }
    
    /// Return shared instance of current device
    public static var currentDevice: UIDevice {
        return UIDevice.current
    }
    
    /// Return system current version
    public static var systemVersion: String {
        return UIDevice.current.systemVersion
    }
    
    /// Return current device name
    public static var deviceName: String {
        return UIDevice.current.name
    }
    
    /// Return current device model
    public static var deviceModel: String {
        return UIDevice.current.model
    }
    
    /// Return current battery level
    public static var batteryLevel: Float {
        return UIDevice.current.batteryLevel
    }
    
    /// Return true if multitasking is supported in current device
    public static var isMultitaskingSupported: Bool {
        return UIDevice.current.isMultitaskingSupported
    }
    
    /// Return current orientation of device
    public static var deviceOrientation: UIDeviceOrientation {
        return UIDevice.current.orientation
    }
    
    /// Application icon badge current number
    public static var applicationIconBadgeNumber: Int {
        get {
            return UIApplication.shared.applicationIconBadgeNumber
        }
        set {
            UIApplication.shared.applicationIconBadgeNumber = newValue
        }
    }
    
    /// Network activity indicator state
    public static var isNetworkActivityIndicatorVisible: Bool {
        get {
            return UIApplication.shared.isNetworkActivityIndicatorVisible
        }
        set {
            UIApplication.shared.isNetworkActivityIndicatorVisible = newValue
        }
    }
    
    /// Status bar visibility state
    public static var isStatusBarHidden: Bool {
        get {
            return UIApplication.shared.isStatusBarHidden
        }
        set {
            UIApplication.shared.isStatusBarHidden = newValue
        }
    }
    
    /// Return key window (read only)
    public static var keyWindow: UIView? {
        return UIApplication.shared.keyWindow
    }
    
    /// Most top view controller
    var mostTopViewController: UIViewController? {
        get {
            return UIApplication.shared.keyWindow?.rootViewController
        }
        set {
            UIApplication.shared.keyWindow?.rootViewController = newValue
        }
    }
    
    /// Return true if device is registered for remote notifications for current app (read only)
    public static var isRegisteredForRemoteNotifications: Bool {
        return UIApplication.shared.isRegisteredForRemoteNotifications
    }
    
    /// Current status bar style
    public static var statusBarStyle: UIStatusBarStyle? {
        get {
            return UIApplication.shared.statusBarStyle
        }
        set {
            if let style = newValue {
                UIApplication.shared.statusBarStyle = style
            }
        }
    }
    
    /// Return shared instance of standard UserDefaults
    public static var userDefaults: UserDefaults {
        return UserDefaults.standard
    }
    
    /// Save an object to UserDefaults
    public static func set(value: AnyObject?, forKey: String) {
        UserDefaults.standard.set(value, forKey: forKey)
    }
    
    /// Get an object from UserDefaults
    public static func object(forKey: String) -> AnyObject? {
        return UserDefaults.standard.object(forKey: forKey)
    }
    
    /// Return true if app is running in debug mode
    public static var isInDebuggingMode: Bool {
        // http://stackoverflow.com/questions/9063100/xcode-ios-how-to-determine-whether-code-is-running-in-debug-release-build
        #if DEBUG
            return true
        #else
            return false
        #endif
    }
    
    /// Return true is application is running on simulator
    public static var isRunningOnSimulator: Bool {
        // http://stackoverflow.com/questions/24869481/detect-if-app-is-being-built-for-device-or-simulator-in-swift
        #if (arch(i386) || arch(x86_64)) && (os(iOS) || os(watchOS) || os(tvOS))
            return true
        #else
            return false
        #endif
    }

}
