//
//  OptionalExtensions.swift
//  SwifterSwift
//
//  Created by Omar Albeik on 3/3/17.
//  Copyright © 2017 omaralbeik. All rights reserved.
//

import Foundation

public extension Optional {
	
	/// SwifterSwift: Get self of default value (if self is nil).
	///
	///		let foo: String? = nil
	///		print(foo.unwrapped(or: "bar")) -> "bar"
	///
	///		let bar: String? = "bar"
	///		print(bar.unwrapped(or: "foo")) -> "bar"
	///
	/// - Parameter defaultValue: default value to return if self is nil.
	/// - Returns: self if not nil or default value if nil.
	public func unwrapped(or defaultValue: Wrapped) -> Wrapped {
		// http://www.russbishop.net/improving-optionals
		return self ?? defaultValue
	}
	
	/// SwifterSwift: Runs a block to Wrapped if not nil
	///
	///		let foo: String? = nil
	///		foo.run { unwrappedFoo in
	///			// block will never run sice foo is nill
	///			print(unwrappedFoo)
	///		}
	///
	///		let bar: String? = "bar"
	///		bar.run { unwrappedBar in
	///			// block will run sice bar is not nill
	///			print(unwrappedBar) -> "bar"
	///		}
	///
	/// - Parameter block: a block to run if self is not nil.
	public func run(_ block: (Wrapped) -> Void) {
		// http://www.russbishop.net/improving-optionals
		_ = self.map(block)
	}
	
}
