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
    
    /// SwifterSwift: Stringify number using specified locale identifier in spellout representation
    ///
    /// - Parameter identifier: locale identifier, e.g "en", "ru", "es". It can be not only language, but language dialect for specific region, e.g.: "fr-FR" - french in France, "fr-CH" - french in Switzerland
    /// - Returns: String representation of number spelled in specified locale language. E.g. input 92, output in "en": "ninety-two"
    func getSpellOutString(forLocaleIdentifier identifier: String? = nil) -> String? {
        let formatter = NumberFormatter()
        formatter.numberStyle = .spellOut
        
        if let identifier = identifier {
            formatter.locale = Locale(identifier: identifier)
        } else {
            formatter.locale = Locale.current
        }
        
        guard  let number = self as? NSNumber else { return "" }
        return formatter.string(from: number)
    }
    
    /// SwifterSwift: Stringify number using specified locale identifier in ordinal representation
    ///
    /// - Parameter identifier: locale identifier, e.g "en", "ru", "es". It can be not only language, but language dialect for specific region, e.g.: "fr-FR" - french in France, "fr-CH" - french in Switzerland
    /// - Returns: String ordinal representation of number in specified locale language. E.g. input 92, output in "en": "92nd"
    func getOrdinalString(forLocaleIdentifier identifier: String? = nil) -> String? {
        let formatter = NumberFormatter()
        if #available(iOS 9.0, *) {
            formatter.numberStyle = .ordinal
        } else {
            return ""
        }
        
        if let identifier = identifier {
            formatter.locale = Locale(identifier: identifier)
        } else {
            formatter.locale = Locale.current
        }
        
        guard  let number = self as? NSNumber else { return "" }
        return formatter.string(from: number)
    }
}
