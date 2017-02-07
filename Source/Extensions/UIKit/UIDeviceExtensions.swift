//
//  UIDeviceExtensions.swift
//  SwifterSwift
//
//  Created by Michal Kowalski on 07/02/2017.
//  Copyright © 2017 omaralbeik. All rights reserved.
//
#if os(iOS) || os(tvOS)
import Foundation

public extension UIDevice {
    public func isIPhone() -> Bool {
        return userInterfaceIdiom == .phone
    }

    public func isIPad() -> Bool {
        return userInterfaceIdiom == .pad
    }
}

#endif
