// UIActivityExtensions.swift - Copyright 2023 SwifterSwift

#if canImport(UIKit) && os(iOS)
import UIKit

// MARK: - ActivityType

public extension UIActivity.ActivityType {
    /// SwifterSwift: AddToiCloudDrive.
    static let addToiCloudDrive = UIActivity.ActivityType("com.apple.CloudDocsUI.AddToiCloudDrive")

    /// SwifterSwift: WhatsApp share extension.
    static let postToWhatsApp = UIActivity.ActivityType("net.whatsapp.WhatsApp.ShareExtension")

    /// SwifterSwift: LinkedIn share extension.
    static let postToLinkedIn = UIActivity.ActivityType("com.linkedin.LinkedIn.ShareExtension")

    /// SwifterSwift: XING share extension.
    static let postToXing = UIActivity.ActivityType("com.xing.XING.Xing-Share")
}

#endif
