//
//  NSDecimalNumberExtensions.swift
//  SwifterSwift
//
//  Created by Vitaliy Gozhenko on 15/09/17.
//  Based on https://gist.github.com/mattt/1ed12090d7c89f36fd28
//
//

import Foundation

// MARK: Number Extensions

extension Int {
  public var decimalNumberValue: NSDecimalNumber { return NSDecimalNumber(value: self) }
}

extension Double {
  public var decimalNumberValue: NSDecimalNumber { return NSDecimalNumber(value: self) }
}

extension Float {
  public var decimalNumberValue: NSDecimalNumber { return NSDecimalNumber(value: self) }
}

extension UInt {
  public var decimalNumberValue: NSDecimalNumber { return NSDecimalNumber(value: self) }
}

extension CGFloat {
  public var decimalNumberValue: NSDecimalNumber { return NSDecimalNumber(value: Double(self)) }
}

// MARK: - Comparable

extension NSDecimalNumber: Comparable {}

public func ==(lhs: NSDecimalNumber, rhs: NSDecimalNumber) -> Bool {
    return lhs.compare(rhs) == .orderedSame
}

public func <(lhs: NSDecimalNumber, rhs: NSDecimalNumber) -> Bool {
    return lhs.compare(rhs) == .orderedAscending
}

public func >(lhs: NSDecimalNumber, rhs: NSDecimalNumber) -> Bool {
    return lhs.compare(rhs) == .orderedDescending
}


// MARK: - Arithmetic Operators

// MARK: - Negative

public prefix func -(value: NSDecimalNumber) -> NSDecimalNumber {
    return value.multiplying(by: NSDecimalNumber(mantissa: 1, exponent: 0, isNegative: true))
}

// MARK: - Add

public func +(lhs: NSDecimalNumber, rhs: NSDecimalNumber) -> NSDecimalNumber {
    return lhs.adding(rhs)
}

public func +(lhs: NSDecimalNumber, rhs: Int) -> NSDecimalNumber {
    return lhs.adding(NSDecimalNumber(value:rhs))
}

public func +(lhs: NSDecimalNumber, rhs: Double) -> NSDecimalNumber {
    return lhs.adding(NSDecimalNumber(value:rhs))
}

public func += (lhs: inout NSDecimalNumber, rhs: NSDecimalNumber) {
    lhs = lhs + rhs
}

public func += (lhs: inout NSDecimalNumber, rhs: Int) {
    lhs = lhs + rhs
}

public func += (lhs: inout NSDecimalNumber, rhs: Double) {
    lhs = lhs + rhs
}

// MARK: - Substract

public func -(lhs: NSDecimalNumber, rhs: NSDecimalNumber) -> NSDecimalNumber {
    return lhs.subtracting(rhs)
}

public func -(lhs: NSDecimalNumber, rhs: Int) -> NSDecimalNumber {
    return lhs.subtracting(NSDecimalNumber(value:rhs))
}

public func -(lhs: NSDecimalNumber, rhs: Double) -> NSDecimalNumber {
    return lhs.subtracting(NSDecimalNumber(value:rhs))
}

public func -= (lhs: inout NSDecimalNumber, rhs: NSDecimalNumber) {
    lhs = lhs - rhs
}

public func -= (lhs: inout NSDecimalNumber, rhs: Int) {
    lhs = lhs - rhs
}

public func -= (lhs: inout NSDecimalNumber, rhs: Double) {
    lhs = lhs - rhs
}

// MARK: - Multiply

public func *(lhs: NSDecimalNumber, rhs: NSDecimalNumber) -> NSDecimalNumber {
    return lhs.multiplying(by: rhs)
}

public func *(lhs: NSDecimalNumber, rhs: Int) -> NSDecimalNumber {
    return lhs.multiplying(by: NSDecimalNumber(value:rhs))
}

public func *(lhs: NSDecimalNumber, rhs: Double) -> NSDecimalNumber {
    return lhs.multiplying(by: NSDecimalNumber(value:rhs))
}

public func *= (lhs: inout NSDecimalNumber, rhs: NSDecimalNumber) {
    lhs = lhs * rhs
}

public func *= (lhs: inout NSDecimalNumber, rhs: Int) {
    lhs = lhs * rhs
}

public func *= (lhs: inout NSDecimalNumber, rhs: Double) {
    lhs = lhs * rhs
}

// MARK: - Divide

public func /(lhs: NSDecimalNumber, rhs: NSDecimalNumber) -> NSDecimalNumber {
    return lhs.dividing(by: rhs)
}


public func /(lhs: NSDecimalNumber, rhs: Int) -> NSDecimalNumber {
    return lhs.dividing(by: NSDecimalNumber(value:rhs))
}

public func /(lhs: NSDecimalNumber, rhs: Double) -> NSDecimalNumber {
    return lhs.dividing(by: NSDecimalNumber(value:rhs))
}

public func /= (lhs: inout NSDecimalNumber, rhs: NSDecimalNumber) {
    lhs = lhs / rhs
}

public func /= (lhs: inout NSDecimalNumber, rhs: Int) {
    lhs = lhs / rhs
}

public func /= (lhs: inout NSDecimalNumber, rhs: Double) {
    lhs = lhs / rhs
}

// MARK: - Power

public func ^(lhs: NSDecimalNumber, rhs: Int) -> NSDecimalNumber {
    return lhs.raising(toPower: rhs)
}
