//
//  UIColorExtensions.swift
//  SwifterSwift
//
//  Created by Omar Albeik on 8/6/16.
//  Copyright © 2016 Omar Albeik. All rights reserved.
//

import UIKit

public extension UIColor {
    /// Return hexadecimal value string.
    public var hexString: String {
        var r:CGFloat = 0
        var g:CGFloat = 0
        var b:CGFloat = 0
        var a:CGFloat = 0
        
        getRed(&r, green: &g, blue: &b, alpha: &a)
        let rgb: Int = (Int)(r*255)<<16 | (Int)(g*255)<<8 | (Int)(b*255)<<0
        return NSString(format:"#%06x", rgb).uppercased as String
    }
    
    /// Create UIColor from hexadecimal value.
    public convenience init(netHex:Int) {
        self.init(red:(netHex >> 16) & 0xff, green:(netHex >> 8) & 0xff, blue:netHex & 0xff)
    }
    
    /// Create new UIColor for a hexadicimal value with transparency
    public convenience init(netHex:Int, transparency: CGFloat) {
        self.init(red:(netHex >> 16) & 0xff, green:(netHex >> 8) & 0xff, blue:netHex & 0xff, transparency: transparency)
    }
    
    /// Create UIColor from RGB values.
    public convenience init(red: Int, green: Int, blue: Int) {
        assert(red >= 0 && red <= 255, "Invalid red component")
        assert(green >= 0 && green <= 255, "Invalid green component")
        assert(blue >= 0 && blue <= 255, "Invalid blue component")
        
        self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1.0)
    }
    
    /// Create UIColor from RGB values with transparency.
    public convenience init(red: Int, green: Int, blue: Int, transparency: CGFloat) {
        assert(red >= 0 && red <= 255, "Invalid red component")
        assert(green >= 0 && green <= 255, "Invalid green component")
        assert(blue >= 0 && blue <= 255, "Invalid blue component")
        
        self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: transparency)
    }
    
    /// Return random color.
    public static var random: UIColor {
        let r = Int(arc4random_uniform(255))
        let g = Int(arc4random_uniform(255))
        let b = Int(arc4random_uniform(255))
        return UIColor(red: r, green: g, blue: b)
    }
    
    /// Brand identity color of popular social media platform.
    public struct socialColors {
        // FIXME: re-check colors
        // https://www.lockedowndesign.com/social-media-colors/
        public static var facebook: UIColor {
            return UIColor(red: 59, green: 89, blue: 152)
        }
        
        public static var twitter: UIColor {
            return UIColor(red: 0, green: 182, blue: 241)
        }
        
        public static var googlePlus: UIColor {
            return UIColor(red: 223, green: 74, blue: 50)
        }
        
        public static var linkedIn: UIColor {
            return UIColor(red: 0, green: 123, blue: 182)
        }
        
        public static var vimeo: UIColor {
            return UIColor(red: 69, green: 187, blue: 255)
        }
        
        public static var youtube: UIColor {
            return UIColor(red: 179, green: 18, blue: 23)
        }
        
        public static var instagram: UIColor {
            return UIColor(red: 195, green: 42, blue: 163)
        }
        
        public static var pinterest: UIColor {
            return UIColor(red: 203, green: 32, blue: 39)
        }
        
        public static var flickr: UIColor {
            return UIColor(red: 244, green: 0, blue: 131)
        }
        
        public static var yahoo: UIColor {
            return UIColor(red: 67, green: 2, blue: 151)
        }
        
        public static var soundCloud: UIColor {
            return UIColor(red: 255, green: 85, blue: 0)
        }
        
        public static var tumblr: UIColor {
            return UIColor(red: 44, green: 71, blue: 98)
        }
        
        public static var foursquare: UIColor {
            return UIColor(red: 252, green: 69, blue: 117)
        }
        
        public static var swarm: UIColor {
            return UIColor(red: 255, green: 176, blue: 0)
        }
        
        public static var dribbble: UIColor {
            return UIColor(red: 234, green: 76, blue: 137)
        }
        
        public static var reddit: UIColor {
            return UIColor(red: 255, green: 87, blue: 0)
        }
        
        public static var devianArt: UIColor {
            return UIColor(red: 74, green: 93, blue: 78)
        }
        
        public static var pocket: UIColor {
            return UIColor(red: 238, green: 64, blue: 86)
        }
        
        public static var quora: UIColor {
            return UIColor(red: 170, green: 34, blue: 182)
        }
        
        public static var slideShare: UIColor {
            return UIColor(red: 247, green: 146, blue: 30)
        }
        
        public static var px500: UIColor {
            return UIColor(red: 0, green: 153, blue: 229)
        }
        
        public static var listly: UIColor {
            return UIColor(red: 223, green: 109, blue: 70)
        }
        
        public static var vine: UIColor {
            return UIColor(red: 0, green: 180, blue: 137)
        }
        
        public static var skype: UIColor {
            return UIColor(red: 0, green: 175, blue: 240)
        }
        
        public static var stumbleUpon: UIColor {
            return UIColor(red: 235, green: 73, blue: 36)
        }
        
        public static var snapchat: UIColor {
            return UIColor(red: 255, green: 252, blue: 0)
        }
    }
}
