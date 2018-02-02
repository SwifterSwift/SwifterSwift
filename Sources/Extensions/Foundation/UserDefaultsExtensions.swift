//
//  UserDefaultsExtensions.swift
//  SwifterSwift
//
//  Created by Omar Albeik on 9/5/17.
//  Copyright © 2017 SwifterSwift
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
	
    /// SwifterSwift: Retrieves a Codable object from UserDefaults.
    ///
    /// - Parameters:
    ///   - type: Class that conforms to the Codable protocol.
    ///   - key: key to find the Codable object for.
    /// - Returns: Codable object for key (if exists).
    public func object<T: Codable>(_ type: T.Type, with key: String) -> T? {
        guard let data = self.value(forKey: key) as? Data else { return nil }
        
        return try? JSONDecoder().decode(type.self, from: data)
    }
    
    /// SwifterSwift: Allows storing of Codable objects to UserDefaults
    ///
    /// - Parameters:
    ///   - object: Codable object to store.
    ///   - key: Identifier of the object
    public func set<T: Codable>(object: T, forKey key: String) {
        let data = try? JSONEncoder().encode(object)
        
        self.set(data, forKey: key)
    }
    
}
