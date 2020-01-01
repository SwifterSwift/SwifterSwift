//
//  EdgeInsetsExtensions.swift
//  SwifterSwift
//
//  Created by Mustafa GUNES on 1.01.2020.
//  Copyright © 2020 SwifterSwift
//

#if canImport(UIKit)
import UIKit
/// SwifterSwift: EdgeInsets
public typealias EdgeInsets = UIEdgeInsets
#elseif os(macOS)
import Foundation
/// SwifterSwift: EdgeInsets
public typealias EdgeInsets = NSEdgeInsets
#endif
