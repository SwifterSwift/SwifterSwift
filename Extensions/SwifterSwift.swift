//
//  SwifterSwift.swift
//  SwifterSwift
//
//  Created by Omar Albeik on 8/8/16.
//  Copyright © 2016 Omar Albeik. All rights reserved.
//

import UIKit

// MARK: - Properties
/// SwifterSwift: Common usefull properties and methods.
public struct SwifterSwift {
	
	/// SwifterSwift: App's name (if applicable).
	public static var appDisplayName: String? {
		// http://stackoverflow.com/questions/28254377/get-app-name-in-swift
		return Bundle.main.infoDictionary?[kCFBundleNameKey as String] as? String
	}
	
	/// SwifterSwift: App's bundle ID (if applicable).
	public static var appBundleID: String? {
		return Bundle.main.bundleIdentifier
	}
	
	/// SwifterSwift: StatusBar height
	public static var statusBarHeight: CGFloat {
		return UIApplication.shared.statusBarFrame.height
	}
	
	/// SwifterSwift: App current build number (if applicable).
	public static var appBuild: String? {
		return Bundle.main.object(forInfoDictionaryKey: kCFBundleVersionKey as String) as? String
	}
	
	/// SwifterSwift: Application icon badge current number.
	public static var applicationIconBadgeNumber: Int {
		get {
			return UIApplication.shared.applicationIconBadgeNumber
		}
		set {
			UIApplication.shared.applicationIconBadgeNumber = newValue
		}
	}
	
	/// SwifterSwift: App's current version (if applicable).
	public static var appVersion: String? {
		return Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String
	}
	
	/// SwifterSwift: Current battery level.
	public static var batteryLevel: Float {
		return UIDevice.current.batteryLevel
	}
	
	/// SwifterSwift: Shared instance of current device.
	public static var currentDevice: UIDevice {
		return UIDevice.current
	}
	
	/// SwifterSwift: Screen height.
	public static var screenHeight: CGFloat {
		return UIScreen.main.bounds.height
	}
	
	/// SwifterSwift: Current device model.
	public static var deviceModel: String {
		return UIDevice.current.model
	}
	
	/// SwifterSwift: Current device name.
	public static var deviceName: String {
		return UIDevice.current.name
	}
	
	/// SwifterSwift: Current orientation of device.
	public static var deviceOrientation: UIDeviceOrientation {
		return UIDevice.current.orientation
	}
	
	/// SwifterSwift: Screen width.
	public static var screenWidth: CGFloat {
		return UIScreen.main.bounds.width
	}
	
	/// SwifterSwift: Check if app is running in debug mode.
	public static var isInDebuggingMode: Bool {
		// http://stackoverflow.com/questions/9063100/xcode-ios-how-to-determine-whether-code-is-running-in-debug-release-build
		#if DEBUG
			return true
		#else
			return false
		#endif
	}
	
	/// SwifterSwift: Check if multitasking is supported in current device.
	public static var isMultitaskingSupported: Bool {
		return UIDevice.current.isMultitaskingSupported
	}
	
	/// SwifterSwift: Current status bar network activity indicator state.
	public static var isNetworkActivityIndicatorVisible: Bool {
		get {
			return UIApplication.shared.isNetworkActivityIndicatorVisible
		}
		set {
			UIApplication.shared.isNetworkActivityIndicatorVisible = newValue
		}
	}
	
	/// SwifterSwift: Check if device is iPad.
	public static var isPad: Bool {
		return UIDevice.current.userInterfaceIdiom == .pad
	}
	
	/// SwifterSwift: Check if device is iPhone.
	public static var isPhone: Bool {
		return UIDevice.current.userInterfaceIdiom == .phone
	}
	
	/// SwifterSwift: Check if device is registered for remote notifications for current app (read-only).
	public static var isRegisteredForRemoteNotifications: Bool {
		return UIApplication.shared.isRegisteredForRemoteNotifications
	}
	
	/// SwifterSwift: Check if application is running on simulator (read-only).
	public static var isRunningOnSimulator: Bool {
		// http://stackoverflow.com/questions/24869481/detect-if-app-is-being-built-for-device-or-simulator-in-swift
		#if (arch(i386) || arch(x86_64)) && (os(iOS) || os(watchOS) || os(tvOS))
			return true
		#else
			return false
		#endif
	}
	
	/// SwifterSwift: Status bar visibility state.
	public static var isStatusBarHidden: Bool {
		get {
			return UIApplication.shared.isStatusBarHidden
		}
		set {
			UIApplication.shared.isStatusBarHidden = newValue
		}
	}
	
	/// SwifterSwift: Key window (read only, if applicable).
	public static var keyWindow: UIView? {
		return UIApplication.shared.keyWindow
	}
	
	/// SwifterSwift: Most top view controller (if applicable).
	public static var mostTopViewController: UIViewController? {
		get {
			return UIApplication.shared.keyWindow?.rootViewController
		}
		set {
			UIApplication.shared.keyWindow?.rootViewController = newValue
		}
	}
	
	/// SwifterSwift: Shared instance UIApplication.
	public static var sharedApplication: UIApplication {
		return UIApplication.shared
	}
	
	/// SwifterSwift: Current status bar style (if applicable).
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
	
	/// SwifterSwift: System current version (read-only).
	public static var systemVersion: String {
		return UIDevice.current.systemVersion
	}
	
	/// SwifterSwift: Shared instance of standard UserDefaults (read-only).
	public static var userDefaults: UserDefaults {
		return UserDefaults.standard
	}
	
}


// MARK: - Methods
public extension SwifterSwift {

	/// SwifterSwift: Called when user takes a screenshot
	///
	/// - Parameter action: a closure to run when user takes a screenshot
	public static func didTakeScreenShot(_ action: @escaping () -> ()) {
		// http://stackoverflow.com/questions/13484516/ios-detection-of-screenshot
		let mainQueue = OperationQueue.main
		NotificationCenter.default.addObserver(forName: NSNotification.Name.UIApplicationUserDidTakeScreenshot, object: nil, queue: mainQueue) { notification in
			action()
		}
	}
	
	/// SwifterSwift: Object from UserDefaults.
	///
	/// - Parameter forKey: key to find object for.
	/// - Returns: Any object for key (if exists).
	public static func object(forKey: String) -> Any? {
		return UserDefaults.standard.object(forKey: forKey)
	}
	
	/// SwifterSwift: String from UserDefaults.
	///
	/// - Parameter forKey: key to find string for.
	/// - Returns: String object for key (if exists).
	public static func string(forKey: String) -> String? {
		return UserDefaults.standard.string(forKey: forKey)
	}
	
	/// SwifterSwift: Integer from UserDefaults.
	///
	/// - Parameter forKey: key to find integer for.
	/// - Returns: Int number for key (if exists).
	public static func integer(forKey: String) -> Int? {
		return UserDefaults.standard.integer(forKey: forKey)
	}
	
	/// SwifterSwift: Double from UserDefaults.
	///
	/// - Parameter forKey: key to find double for.
	/// - Returns: Double number for key (if exists).
	public static func double(forKey: String) -> Double? {
		return UserDefaults.standard.double(forKey: forKey)
	}
	
	/// SwifterSwift: Data from UserDefaults.
	///
	/// - Parameter forKey: key to find data for.
	/// - Returns: Data object for key (if exists).
	public static func data(forKey: String) -> Data? {
		return UserDefaults.standard.data(forKey: forKey)
	}
	
	/// SwifterSwift: Bool from UserDefaults.
	///
	/// - Parameter forKey: key to find bool for.
	/// - Returns: Bool object for key (if exists).
	public static func bool(forKey: String) -> Bool? {
		return UserDefaults.standard.bool(forKey: forKey)
	}
	
	/// SwifterSwift: Array from UserDefaults.
	///
	/// - Parameter forKey: key to find array for.
	/// - Returns: Array of Any objects for key (if exists).
	public static func array(forKey: String) -> [Any]? {
		return UserDefaults.standard.array(forKey: forKey)
	}
	
	/// SwifterSwift: Dictionary from UserDefaults.
	///
	/// - Parameter forKey: key to find dictionary for.
	/// - Returns: ictionary of [String: Any] for key (if exists).
	public static func dictionary(forKey: String) -> [String: Any]? {
		return UserDefaults.standard.dictionary(forKey: forKey)
	}
	
	/// SwifterSwift: Float from UserDefaults.
	///
	/// - Parameter forKey: key to find float for.
	/// - Returns: Float number for key (if exists).
	public static func float(forKey: String) -> Float? {
		return UserDefaults.standard.object(forKey: forKey) as? Float
	}
	
	/// SwifterSwift: Save an object to UserDefaults.
	///
	/// - Parameters:
	///   - value: object to save in UserDefaults.
	///   - forKey: key to save object for.
	public static func set(value: Any?, forKey: String) {
		UserDefaults.standard.set(value, forKey: forKey)
	}
	
	/// SwifterSwift: Class name of object as string.
	///
	/// - Parameter object: Any object to find its class name.
	/// - Returns: Class name for given object.
	public static func typeName(for object: Any) -> String {
		let type = type(of: object.self)
		return String.init(describing: type)
	}
	
}
