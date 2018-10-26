//
//  UIActivityExtensions.swift
//  SwifterSwift
//
//  Created by Hannes Staffler on 07.10.18.
//  Copyright © 2018 SwifterSwift
//

#if canImport(UIKit) && os(iOS)
import UIKit

// MARK: - ActivityType
public extension UIActivity.ActivityType {

    /// SwifterSwift: AddToiCloudDrive
    public static let addToiCloudDrive = UIActivity.ActivityType("com.apple.CloudDocsUI.AddToiCloudDrive")

    /// SwifterSwift: WhatsApp share extension
    public static let postToWhatsApp = UIActivity.ActivityType("net.whatsapp.WhatsApp.ShareExtension")

    /// SwifterSwift: LinkedIn share extension
    public static let postToLinkedIn = UIActivity.ActivityType("com.linkedin.LinkedIn.ShareExtension")

    /// SwifterSwift: XING share extension
    public static let postToXing = UIActivity.ActivityType("com.xing.XING.Xing-Share")

}
#endif
