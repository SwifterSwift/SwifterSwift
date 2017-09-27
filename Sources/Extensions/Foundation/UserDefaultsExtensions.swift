//
//  UserDefaultsExtensions.swift
//  SwifterSwift
//
//  Created by Omar Albeik on 9/5/17.
//
//
import Foundation

// MARK: - Methods
public extension UserDefaults {
	
	/// SwifterSwift: get object from UserDefaults by using subscript
	///
	/// - Parameter key: key in the current user's defaults database.
	public subscript(key: String) -> Any? {
		get {
			return object(forKey: key)
		}
		set {
			set(newValue, forKey: key)
		}
	}
	
	/// SwifterSwift: Float from UserDefaults.
	///
	/// - Parameter forKey: key to find float for.
	/// - Returns: Float object for key (if exists).
	public func float(forKey key: String) -> Float? {
		return object(forKey: key) as? Float
	}
	
	/// SwifterSwift: Date from UserDefaults.
	///
	/// - Parameter forKey: key to find date for.
	/// - Returns: Date object for key (if exists).
	public func date(forKey key: String) -> Date? {
		return object(forKey: key) as? Date
	}
	
}
