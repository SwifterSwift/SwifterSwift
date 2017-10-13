//
//  DataExtensions.swift
//  SwifterSwift
//
//  Created by Omar Albeik on 07/12/2016.
//  Copyright © 2016 Omar Albeik. All rights reserved.
//

#if os(macOS)
	import Cocoa
#else
	import UIKit
#endif

// MARK: - Properties
public extension Data {
	
	/// SwifterSwift: Return data as an array of bytes.
	public var bytes: [UInt8] {
		//http://stackoverflow.com/questions/38097710/swift-3-changes-for-getbytes-method
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
    
    /// SwifterSwift: Split a Data instance into sized chunks.
    ///
    /// - Parameter size: Int chunk size
    /// - Returns: An array with each individual data chunk
    public func chunks(of size: Int) -> [Data] {
        if size <= 0 {
            return [self]
        }
        let size = Swift.min(size, self.count)
        var data = self
        var chunks = [Data]()
        while true {
            let chunkSize = Swift.min(size, data.count)
            let chunkData = data.subdata(in: 0..<chunkSize)
            chunks.append(chunkData)
            if chunkSize == data.count {
                break
            }
            data = data.advanced(by: chunkSize)
        }
        return chunks
    }
}
