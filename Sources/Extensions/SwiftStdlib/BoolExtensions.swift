//
//  BoolExtensions.swift
//  SwifterSwift
//
//  Created by Omar Albeik on 07/12/2016.
//  Copyright © 2016 SwifterSwift
//

// MARK: - Properties
public extension Bool {

	/// SwifterSwift: Return 1 if true, or 0 if false.
	///
	///		false.int -> 0
	///		true.int -> 1
	///
	public var int: Int {
		return self ? 1 : 0
	}

	/// SwifterSwift: Return "true" if true, or "false" if false.
	///
	///		false.string -> "false"
	///		true.string -> "true"
	///
	public var string: String {
		return description
	}

	/// SwifterSwift: Returns a random boolean value.
	///
	///     Bool.random -> true
	///     Bool.random -> false
	///
	public static var random: Bool {
		return arc4random_uniform(2) == 1
	}

}
