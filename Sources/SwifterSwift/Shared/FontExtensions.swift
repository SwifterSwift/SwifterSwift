// FontExtensions.swift - Copyright 2020 SwifterSwift

#if canImport(UIKit)
import UIKit
/// SwifterSwift: Font
public typealias Font = UIFont
#endif

#if canImport(AppKit) && !targetEnvironment(macCatalyst)
import AppKit
/// SwifterSwift: Font
public typealias Font = NSFont
#endif
