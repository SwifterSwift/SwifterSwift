//
//  UIKitDeprecated.swift
//  SwifterSwift
//
//  Created by Omar Albeik on 5.04.2018.
//  Copyright © 2018 SwifterSwift
//

#if canImport(UIKit) && !os(watchOS)
import UIKit

public extension UIStoryboard {

    /// SwifterSwift: Get main storyboard for application
    @available(*, deprecated: 4.3, message: "Use main instead", renamed: "main")
    public static var mainStoryboard: UIStoryboard? {
        let bundle = Bundle.main
        guard let name = bundle.object(forInfoDictionaryKey: "UIMainStoryboardFile") as? String else { return nil }
        return UIStoryboard(name: name, bundle: bundle)
    }

}
#endif
