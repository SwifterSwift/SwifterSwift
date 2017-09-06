//
//  SwifterSwiftDeprecated.swift
//  SwifterSwift
//
//  Created by Omar Albeik on 9/5/17.
//
//

import Foundation

// MARK: - Preperties
public extension SwifterSwift {
	
	@available(*, deprecated: 3.2.0, message: "Use Apple's UserDefaults.standard instead")
	/// SwifterSwift: Shared instance of standard UserDefaults (read-only).
	public static var userDefaults: UserDefaults {
		return UserDefaults.standard
	}
	
}


// MARK: - Methods
public extension SwifterSwift {
	
	@available(*, deprecated: 3.2.0, message: "Use Apple's UserDefaults.standard.object(forKey: _) instead")
	/// SwifterSwift: Object from UserDefaults.
	///
	/// - Parameter forKey: key to find object for.
	/// - Returns: Any object for key (if exists).
	public static func object(forKey: String) -> Any? {
		return UserDefaults.standard.object(forKey: forKey)
	}
	
	@available(*, deprecated: 3.2.0, message: "Use Apple's UserDefaults.standard.string(forKey: _) instead")
	/// SwifterSwift: String from UserDefaults.
	///
	/// - Parameter forKey: key to find string for.
	/// - Returns: String object for key (if exists).
	public static func string(forKey: String) -> String? {
		return UserDefaults.standard.string(forKey: forKey)
	}
	
	@available(*, deprecated: 3.2.0, message: "Use Apple's UserDefaults.standard.integer(forKey: _) instead")
	/// SwifterSwift: Integer from UserDefaults.
	///
	/// - Parameter forKey: key to find integer for.
	/// - Returns: Int number for key (if exists).
	public static func integer(forKey: String) -> Int? {
		return UserDefaults.standard.integer(forKey: forKey)
	}
	
	@available(*, deprecated: 3.2.0, message: "Use Apple's UserDefaults.standard.double(forKey: _) instead")
	/// SwifterSwift: Double from UserDefaults.
	///
	/// - Parameter forKey: key to find double for.
	/// - Returns: Double number for key (if exists).
	public static func double(forKey: String) -> Double? {
		return UserDefaults.standard.double(forKey: forKey)
	}
	
	@available(*, deprecated: 3.2.0, message: "Use Apple's UserDefaults.standard.data(forKey: _) instead")
	/// SwifterSwift: Data from UserDefaults.
	///
	/// - Parameter forKey: key to find data for.
	/// - Returns: Data object for key (if exists).
	public static func data(forKey: String) -> Data? {
		return UserDefaults.standard.data(forKey: forKey)
	}
	
	@available(*, deprecated: 3.2.0, message: "Use Apple's UserDefaults.standard.bool(forKey: _) instead")
	/// SwifterSwift: Bool from UserDefaults.
	///
	/// - Parameter forKey: key to find bool for.
	/// - Returns: Bool object for key (if exists).
	public static func bool(forKey: String) -> Bool? {
		return UserDefaults.standard.bool(forKey: forKey)
	}
	
	@available(*, deprecated: 3.2.0, message: "Use Apple's UserDefaults.standard.array(forKey: _) instead")
	/// SwifterSwift: Array from UserDefaults.
	///
	/// - Parameter forKey: key to find array for.
	/// - Returns: Array of Any objects for key (if exists).
	public static func array(forKey: String) -> [Any]? {
		return UserDefaults.standard.array(forKey: forKey)
	}
	
	@available(*, deprecated: 3.2.0, message: "Use Apple's UserDefaults.standard.dictionary(forKey: _) instead")
	/// SwifterSwift: Dictionary from UserDefaults.
	///
	/// - Parameter forKey: key to find dictionary for.
	/// - Returns: ictionary of [String: Any] for key (if exists).
	public static func dictionary(forKey: String) -> [String: Any]? {
		return UserDefaults.standard.dictionary(forKey: forKey)
	}
	
	@available(*, deprecated: 3.2.0, message: "Use SwifterSwift's UserDefaults.standard.float(forKey: _) instead")
	/// SwifterSwift: Float from UserDefaults.
	///
	/// - Parameter forKey: key to find float for.
	/// - Returns: Float number for key (if exists).
	public static func float(forKey: String) -> Float? {
		return UserDefaults.standard.object(forKey: forKey) as? Float
	}
	
	@available(*, deprecated: 3.2.0, message: "Use Apple's UserDefaults.standard.setValue(_, forKey: _) instead")
	/// SwifterSwift: Save an object to UserDefaults.
	///
	/// - Parameters:
	///   - value: object to save in UserDefaults.
	///   - forKey: key to save object for.
	public static func set(_ value: Any?, forKey: String) {
		UserDefaults.standard.set(value, forKey: forKey)
	}
	
}
