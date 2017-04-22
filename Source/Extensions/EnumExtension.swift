//
//  EnumExtensions.swift
//  SSTests
//
//  Created by Omar Albeik on 07/12/2016.
//  Copyright © 2016 Omar Albeik. All rights reserved.
//

protocol EnumExtensions {  
    // Returns an array of all enum values
    static var allValues: [Self] { get }
    
    // Returns a .label for the enum value and a .value for the associated value
    public var associated: (label: String, value: Any?) { get }
    
    // Returns the rawValue even if the enum is passed on in a Any (Like Mirror does)
    public var anyRawValue: Any { get }
}

extension EnumExtensions {
    public var associated: (label: String, value: Any?) {
        get {
            let mirror = Mirror(reflecting: self)
            if let associated = mirror.children.first {
                return (associated.label!, associated.value)
            }
            print("WARNING: Enum option of \(self) does not have an associated value")
            return ("\(self)", nil)
        }
    }
}

extension EnumExtensions where Self: Hashable {
    public static var allValues: [Self] {
        return Array(self.cases())
    }
    
    static func cases() -> AnySequence<Self> {
        typealias S = Self
        return AnySequence { () -> AnyIterator<S> in
            var raw = 0
            return AnyIterator {
                let current : Self = withUnsafePointer(to: &raw) { $0.withMemoryRebound(to: S.self, capacity: 1) { $0.pointee } }
                guard current.hashValue == raw else { return nil }
                raw += 1
                return current
            }
        }
    }
}

extension EnumExtensions where Self: RawRepresentable {
    var anyRawValue: Any {
        get {
            return rawValue as Any
        }
    }
}
