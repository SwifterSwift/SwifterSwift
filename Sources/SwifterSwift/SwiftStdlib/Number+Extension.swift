//
//  Number+Extension.swift
//  SwifterSwift
//
//  Created by Mazy on 2020/6/26.
//  Copyright © 2020 SwifterSwift
//


#if canImport(Foundation)
import Foundation
#endif

public extension NSNumber {
    /// The price number turns into a string
    ///
    /// - Parameter number: price number
    /// - Returns: price Formatted string
    func moneyFormatter() -> String {
        let numberFormatter = NumberFormatter()
        numberFormatter.positiveFormat = "###,###.##"
        let format = numberFormatter.string(from: self)
        return format ?? ""
    }
}
