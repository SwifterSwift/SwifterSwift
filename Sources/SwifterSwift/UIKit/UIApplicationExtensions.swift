// UIApplicationExtensions.swift - Copyright 2025 SwifterSwift

#if canImport(UIKit)
import UIKit

#if os(iOS) || os(tvOS)

public extension UIApplication {
    /// SwifterSwift: Application running environment.
    ///
    /// - debug: Application is running in debug mode.
    /// - testFlight: Application is installed from Test Flight.
    /// - appStore: Application is installed from the App Store.
    enum Environment {
        /// SwifterSwift: Application is running in debug mode.
        case debug
        /// SwifterSwift: Application is installed from Test Flight.
        case testFlight
        /// SwifterSwift: Application is installed from the App Store.
        case appStore
    }

    /// SwifterSwift: Current inferred app environment.
    var inferredEnvironment: Environment {
        #if DEBUG
        return .debug

        #elseif targetEnvironment(simulator)
        return .debug

        #else
        if Bundle.main.path(forResource: "embedded", ofType: "mobileprovision") != nil {
            return .testFlight
        }

        guard let appStoreReceiptUrl = Bundle.main.appStoreReceiptURL else {
            return .debug
        }

        if appStoreReceiptUrl.lastPathComponent.lowercased() == "sandboxreceipt" {
            return .testFlight
        }

        if appStoreReceiptUrl.path.lowercased().contains("simulator") {
            return .debug
        }

        return .appStore
        #endif
    }

    /// SwifterSwift: Application name (if applicable).
    var displayName: String? {
        return Bundle.main.object(forInfoDictionaryKey: "CFBundleDisplayName") as? String
    }

    /// SwifterSwift: App current build number (if applicable).
    var buildNumber: String? {
        return Bundle.main.object(forInfoDictionaryKey: kCFBundleVersionKey as String) as? String
    }

    /// SwifterSwift: App's current version number (if applicable).
    var version: String? {
        return Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as? String
    }
    
    /// SwifterSwift: Top safe area insets of the key window.
    ///
    /// Returns the top safe area insets from the current key window, or 0 if no key window is available.
    /// This is useful for adjusting UI elements to account for the status bar, notch, or other system UI elements.
    var topSafeAreaInsets: CGFloat {
        UIWindow.keyWindow?.safeAreaInsets.top ?? 0
    }
    
    /// SwifterSwift: Bottom safe area insets of the key window.
    ///
    /// Returns the bottom safe area insets from the current key window, or 0 if no key window is available.
    /// This is useful for adjusting UI elements to account for the home indicator or other system UI elements.
    var bottomSafeAreaInsets: CGFloat {
        UIWindow.keyWindow?.safeAreaInsets.bottom ?? 0
    }
    
    /// SwifterSwift: Left safe area insets of the key window.
    ///
    /// Returns the left safe area insets from the current key window, or 0 if no key window is available.
    /// This is useful for adjusting UI elements to account for system UI elements on the left side.
    var leftSafeAreaInsets: CGFloat {
        UIWindow.keyWindow?.safeAreaInsets.left ?? 0
    }
    
    /// SwifterSwift: Right safe area insets of the key window.
    ///
    /// Returns the right safe area insets from the current key window, or 0 if no key window is available.
    /// This is useful for adjusting UI elements to account for system UI elements on the right side.
    var rightSafeAreaInsets: CGFloat {
        UIWindow.keyWindow?.safeAreaInsets.right ?? 0
    }
    
    /// SwifterSwift: Horizontal safe area insets of the key window.
    ///
    /// Returns the combined left and right safe area insets from the current key window, or 0 if no key window is available.
    /// This is useful for calculating the total horizontal safe area that needs to be accounted for.
    var horizontalSafeAreaInsets: CGFloat {
        UIWindow.keyWindow?.safeAreaInsets.horizontal ?? 0
    }
    
    /// SwifterSwift: Vertical safe area insets of the key window.
    ///
    /// Returns the combined top and bottom safe area insets from the current key window, or 0 if no key window is available.
    /// This is useful for calculating the total vertical safe area that needs to be accounted for.
    var verticalSafeAreaInsets: CGFloat {
        UIWindow.keyWindow?.safeAreaInsets.vertical ?? 0
    }
}

#endif

#endif
