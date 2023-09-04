//
//  DecimalExtensions.swift
//  SwifterSwift
//
//  Created by viktart on 04/09/2023.
//  Copyright © 2023 SwifterSwift
//

import Foundation

public extension Decimal {
    var doubleValue: Double {
        return NSDecimalNumber(decimal: self).doubleValue
    }
}
