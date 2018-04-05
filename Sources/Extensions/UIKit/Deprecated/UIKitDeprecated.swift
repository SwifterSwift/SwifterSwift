//
//  UIKitDeprecated.swift
//  SwifterSwift
//
//  Created by Omar Albeik on 5.04.2018.
//  Copyright © 2018 ___ORGANIZATIONNAME___
//

#if canImport(UIKit)
import UIKit

#if !os(watchOS)
public extension UIStoryboard {

    /// SwifterSwift: Check if date is within the current week.
    @available(*, deprecated: 4.3, message: "Use main instead", renamed: "main")
    /// SwifterSwift: Get main storyboard for application
    public static var mainStoryboard: UIStoryboard? {
        let bundle = Bundle.main
        guard let name = bundle.object(forInfoDictionaryKey: "UIMainStoryboardFile") as? String else { return nil }
        return UIStoryboard(name: name, bundle: bundle)
    }

}
#endif

#endif
