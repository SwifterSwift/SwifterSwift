//
//  SignedNumberExtensions.swift
//  SwifterSwift
//
//  Created by Omar Albeik on 8/15/17.
//  Copyright © 2017 SwifterSwift
//

// MARK: - Properties
public extension SignedNumeric {

	/// SwifterSwift: String.
	public var string: String {
		return String(describing: self)
	}

	/// SwifterSwift: String with number and current locale currency.
	public var asLocaleCurrency: String? {
		let formatter = NumberFormatter()
		formatter.numberStyle = .currency
		formatter.locale = Locale.current
        // swiftlint:disable force_cast
		return formatter.string(from: self as! NSNumber)
        // swiftlint:enable force_cast
	}

}
