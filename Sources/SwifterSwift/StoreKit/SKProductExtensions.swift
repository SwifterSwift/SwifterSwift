//
//  SKProductExtensions.swift
//  SwifterSwift
//
//  Created by Batuhan Saka on 26.12.2019.
//  Copyright © 2019 SwifterSwift
//

#if canImport(StoreKit)
import StoreKit

public extension SKProduct {
    
    /// SwifterSwift: Localized price of SKProduct
    var localizedPrice: String? {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.locale = self.priceLocale
        return formatter.string(from: self.price)
    }
    
}
#endif
