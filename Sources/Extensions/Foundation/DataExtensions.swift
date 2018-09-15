//
//  DataExtensions.swift
//  SwifterSwift
//
//  Created by Omar Albeik on 07/12/2016.
//  Copyright © 2016 SwifterSwift
//

#if canImport(Foundation)
import Foundation

// MARK: - Properties
public extension Data {

    /// SwifterSwift: Return data as an array of bytes.
    public var bytes: [UInt8] {
        // http://stackoverflow.com/questions/38097710/swift-3-changes-for-getbytes-method
        return [UInt8](self)
    }

}

// MARK: - Methods
public extension Data {

    /// SwifterSwift: String by encoding Data using the given encoding (if applicable).
    ///
    /// - Parameter encoding: encoding.
    /// - Returns: String by encoding Data using the given encoding (if applicable).
    public func string(encoding: String.Encoding) -> String? {
        return String(data: self, encoding: encoding)
    }

    /// SwifterSwift: Returns a Foundation object from given JSON data.
    ///
    /// - Parameter options: Options for reading the JSON data and creating the Foundation object.
    ///
    ///   For possible values, see `JSONSerialization.ReadingOptions`.
    /// - Returns: A Foundation object from the JSON data in the receiver, or `nil` if an error occurs.
    /// - Throws: An `NSError` if the receiver does not represent a valid JSON object.
    public func jsonObject(options: JSONSerialization.ReadingOptions = []) throws -> Any {
        return try JSONSerialization.jsonObject(with: self, options: options)
    }

}
#endif
