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
	public var asLocaleCurrency: String {
		let formatter = NumberFormatter()
		formatter.numberStyle = .currency
		formatter.locale = Locale.current
		guard let number = self as? NSNumber else { return "" }
		return formatter.string(from: number) ?? ""
	}
    
    /// SwifterSwift: Spelled out representation of a number.
    ///
    ///        print((12.32).spelledOutString()) // prints "twelve point three two"
    ///
    /// - Parameter locale: Locale, default is .current.
    /// - Returns: String representation of number spelled in specified locale language. E.g. input 92, output in "en": "ninety-two"
    public func spelledOutString(locale: Locale = .current) -> String? {
        let formatter = NumberFormatter()
        formatter.locale = locale
        formatter.numberStyle = .spellOut
        
        guard let number = self as? NSNumber else { return nil }
        return formatter.string(from: number)
    }
    
    /// SwifterSwift: Ordinal representation of an integer.
    ///
    ///        print((12).ordinalString()) // prints "12th"
    ///
    /// - Parameter locale: Locale, default is .current.
    /// - Returns: String ordinal representation of number in specified locale language. E.g. input 92, output in "en": "92nd"
    public func ordinalString(locale: Locale = .current) -> String? {
        let formatter = NumberFormatter()
        formatter.locale = locale
        
        if #available(iOS 9.0, macOS 10.11, *) {
            formatter.numberStyle = .ordinal
        } else {
            return ""
        }
        
        guard let number = self as? NSNumber else { return nil }
        return formatter.string(from: number)
    }
}
