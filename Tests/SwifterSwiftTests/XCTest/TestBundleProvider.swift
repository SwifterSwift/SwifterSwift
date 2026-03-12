// TestBundleProvider.swift - Copyright 2026 SwifterSwift

import Foundation

protocol TestBundleProvider: AnyObject {
    var testBundle: Bundle { get }
}

extension TestBundleProvider {
    var testBundle: Bundle {
        #if SWIFT_PACKAGE
        Bundle.module
        #else
        Bundle(for: Self.self)
        #endif
    }
}
