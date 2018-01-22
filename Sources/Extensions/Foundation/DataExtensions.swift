//
//  DataExtensions.swift
//  SwifterSwift
//
//  Created by Omar Albeik on 07/12/2016.
//  Copyright © 2016 SwifterSwift
//

import Foundation

// MARK: - Properties
public extension Data {
	
	/// SwifterSwift: Return data as an array of bytes.
	public var bytes: [UInt8] {
		// http://stackoverflow.com/questions/38097710/swift-3-changes-for-getbytes-method
		return [UInt8](self)
	}
    
    /// SwifterSwift: Return data.bytes as a binary string.
    ///
    ///     let data = Data(bytes: [0x31])
    ///     let hexString = data.hexString -> "00110001"
    public var binaryString: String {
        return bytes.reduce("", {
            let bin = String($1, radix: 2)
            let padded = bin.paddingStart(8, with: "0")
            return $0 + padded
        })
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
}
