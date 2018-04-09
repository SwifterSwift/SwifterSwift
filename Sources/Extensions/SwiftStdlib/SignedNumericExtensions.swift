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

// MARK: - Methods
public extension SignedNumeric {
    
    /// SwifterSwift: Spelled out representation of a number.
    ///
    ///        print((12.32).spelledOutString()) // prints "twelve point three two"
    ///
    /// - Parameter locale: Locale, default is .current.
    /// - Returns: String representation of number spelled in specified locale language. E.g. input 92, output in "en": "ninety-two"
    #if canImport(Foundation)
    public func spelledOutString(locale: Locale = .current) -> String? {
        let formatter = NumberFormatter()
        formatter.locale = locale
        formatter.numberStyle = .spellOut
        
        guard let number = self as? NSNumber else { return nil }
        return formatter.string(from: number)
    }
    #endif
}
