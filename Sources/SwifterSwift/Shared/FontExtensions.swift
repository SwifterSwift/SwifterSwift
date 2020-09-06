// FontExtensions.swift - Copyright 2020 SwifterSwift

#if canImport(UIKit)
public typealias Font = UIFont
#endif

#if canImport(AppKit) && !targetEnvironment(macCatalyst)
public typealias Font = NSFont
#endif
