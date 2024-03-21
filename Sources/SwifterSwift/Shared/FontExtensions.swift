// FontExtensions.swift - Copyright 2024 SwifterSwift

#if canImport(UIKit)
import UIKit

/// SwifterSwift: Font
public typealias SFFont = UIFont
#endif

#if canImport(AppKit) && !targetEnvironment(macCatalyst)
import AppKit

/// SwifterSwift: Font
public typealias SFFont = NSFont
#endif
