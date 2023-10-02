// SKProductExtensions.swift - Copyright 2023 SwifterSwift

#if canImport(StoreKit)
import StoreKit

@available(watchOS 6.2, *)
public extension SKProduct {
    private static let priceFormatter: NumberFormatter = {
        let priceFormatter = NumberFormatter()
        priceFormatter.numberStyle = .currency
        return priceFormatter
    }()

    /// SwifterSwift: Localized price of SKProduct.
    var localizedPrice: String? {
        let formatter = SKProduct.priceFormatter
        formatter.locale = priceLocale
        return formatter.string(from: price)
    }
}
#endif
