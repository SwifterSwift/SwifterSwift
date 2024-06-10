// SKProductTests.swift - Copyright 2024 SwifterSwift

@testable import SwifterSwift
import XCTest

#if canImport(StoreKit)
import StoreKit

private extension SKProduct {
    /// Creates a mocked `SKProduct`.
    /// - Parameters:
    ///   - identifier: Product identifier.
    ///   - price: Product price.
    ///   - priceLocale: Product price locale.
    convenience init(identifier: String, price: String, priceLocale: Locale) {
        self.init()
        setValue(identifier, forKey: "productIdentifier")
        setValue(NSDecimalNumber(string: price), forKey: "price")
        setValue(priceLocale, forKey: "priceLocale")
    }
}

final class SKProductTests: XCTestCase {
    func testLocalizedPrice() {
        let usMockedProduct = SKProduct(
            identifier: "com.swifterswift.usmockedproduct",
            price: "10.50",
            priceLocale: Locale(identifier: "en_US"))

        XCTAssertEqual(usMockedProduct.localizedPrice, "$10.50")

        let trMockedProduct = SKProduct(
            identifier: "com.swifterswift.trmockedproduct",
            price: "7.50",
            priceLocale: Locale(identifier: "tr_TR"))

        XCTAssertEqual(trMockedProduct.localizedPrice, "₺7,50")

        let noMockedProduct = SKProduct(
            identifier: "com.swifterswift.nomockedproduct",
            price: "100.00",
            priceLocale: Locale(identifier: "nb_NO"))

        if #available(iOS 18.0, tvOS 18.0, *) {
            XCTAssertEqual(noMockedProduct.localizedPrice, "100,00 kr")
        } else {
            XCTAssertEqual(noMockedProduct.localizedPrice, "kr 100,00")
        }

        let frMockedProduct = SKProduct(
            identifier: "com.swifterswift.frmockedproduct",
            price: "10.00",
            priceLocale: Locale(identifier: "fr_FR"))

        XCTAssertEqual(frMockedProduct.localizedPrice, "10,00 €")
    }
}
#endif
