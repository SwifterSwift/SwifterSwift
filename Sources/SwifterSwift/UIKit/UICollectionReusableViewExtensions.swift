//
//  UICollectionReusableViewExtensions.swift
//  SwifterSwift
//
//  Created by Can Balkaya on 4/6/22.
//  Copyright © 2022 SwifterSwift
//

import UIKit

extension UICollectionReusableView {
    
    /// SwifterSwift: UICollectionViewCell or UICollectionReusableView reuseIdentifier.
    static var reuseIdentifier: String {
        return String(describing: Self.self)
    }
}
