//
//  UIColorExtensions.swift
//  SwifterSwift
//
//  Created by Omar Albeik on 8/6/16.
//  Copyright © 2016 Omar Albeik. All rights reserved.
//

#if os(iOS) || os(tvOS) || os(watchOS)
import UIKit


// MARK: - Properties
public extension UIColor {
	
	/// SwifterSwift: Red component of UIColor (read-only).
	public var redComponent: Int {
		var red: CGFloat = 0.0
		getRed(&red, green: nil, blue: nil, alpha: nil)
		return Int(red * 255)
	}
	
	/// SwifterSwift: Green component of UIColor (read-only).
	public var greenComponent: Int {
		var green: CGFloat = 0.0
		getRed(nil, green: &green, blue: nil, alpha: nil)
		return Int(green * 255)
	}
	
	/// SwifterSwift: blue component of UIColor (read-only).
	public var blueComponent: Int {
		var blue: CGFloat = 0.0
		getRed(nil, green: nil, blue: &blue, alpha: nil)
		return Int(blue * 255)
	}
	
	/// SwifterSwift: Alpha of UIColor (read-only).
	public var alpha: CGFloat {
		var a: CGFloat = 0.0
		getRed(nil, green: nil, blue: nil, alpha: &a)
		return a
	}
	
	/// SwifterSwift: Hexadecimal value string (read-only).
	public var hexString: String {
		var red:	CGFloat = 0
		var green:	CGFloat = 0
		var blue:	CGFloat = 0
		var alpha:	CGFloat = 0
		
		getRed(&red, green: &green, blue: &blue, alpha: &alpha)
		let rgb: Int = (Int)(red*255)<<16 | (Int)(green*255)<<8 | (Int)(blue*255)<<0
		return NSString(format:"#%06x", rgb).uppercased as String
	}
	
	/// SwifterSwift: Short hexadecimal value string (read-only, if applicable).
	public var shortHexString: String? {
		let string = hexString.replacingOccurrences(of: "#", with: "")
		let chrs = Array(string.characters)
		guard chrs[0] == chrs[1], chrs[2] == chrs[3], chrs[4] == chrs[5] else {
				return nil
		}
		return  "#" + "\(chrs[0])\(chrs[2])\(chrs[4])"
	}
	
	/// SwifterSwift: Short hexadecimal value string, or full hexadecimal string if not possible (read-only).
	public var shortHexOrHexString: String {
		return shortHexString ?? hexString
	}
	
	/// SwifterSwift: Get color complementary (read-only, if applicable).
	public var complementary: UIColor? {
		return UIColor.init(complementaryFor: self)
	}
	
	/// SwifterSwift: Random color.
	public static var random: UIColor {
		let r = Int(arc4random_uniform(255))
		let g = Int(arc4random_uniform(255))
		let b = Int(arc4random_uniform(255))
		return UIColor(red: r, green: g, blue: b)
		
	}
	
}


// MARK: - Methods
public extension UIColor {
	
	/// SwifterSwift: Blend two UIColors
	///
	/// - Parameters:
	///   - color1: first color to blend
	///   - intensity1: intensity of first color (default is 0.5)
	///   - color2: second color to blend
	///   - intensity2: intensity of second color (default is 0.5)
	/// - Returns: UIColor created by blending first and seond colors.
	public static func blend(_ color1: UIColor, intensity1: CGFloat = 0.5, with color2: UIColor, intensity2: CGFloat = 0.5) -> UIColor {
		// http://stackoverflow.com/questions/27342715/blend-uicolors-in-swift
		let total = intensity1 + intensity2
		let l1 = intensity1/total
		let l2 = intensity2/total
		guard l1 > 0 else { return color2}
		guard l2 > 0 else { return color1}
		var (r1, g1, b1, a1): (CGFloat, CGFloat, CGFloat, CGFloat) = (0, 0, 0, 0)
		var (r2, g2, b2, a2): (CGFloat, CGFloat, CGFloat, CGFloat) = (0, 0, 0, 0)
		color1.getRed(&r1, green: &g1, blue: &b1, alpha: &a1)
		color2.getRed(&r2, green: &g2, blue: &b2, alpha: &a2)
		return UIColor(red: l1*r1 + l2*r2, green: l1*g1 + l2*g2, blue: l1*b1 + l2*b2, alpha: l1*a1 + l2*a2)
	}
	
}


// MARK: - Initializers
public extension UIColor {
	
	/// SwifterSwift: Create UIColor from hexadecimal value with optional transparency.
	///
	/// - Parameters:
	///   - hex: hex Int (example: 0xDECEB5).
	///   - transparency: optional transparency value (default is 1).
	public convenience init(hex: Int, transparency: CGFloat = 1) {
		var trans: CGFloat {
			if transparency > 1 {
				return 1
			} else if transparency < 0 {
				return 0
			} else {
				return transparency
			}
		}
		self.init(red:(hex >> 16) & 0xff, green:(hex >> 8) & 0xff, blue:hex & 0xff, transparency: trans)
	}
	
	/// SwifterSwift: Create UIColor from hexadecimal string with optional transparency (if applicable).
	///
	/// - Parameters:
	///   - hexString: hexadecimal string (examples: EDE7F6, 0xEDE7F6, #EDE7F6, #0ff, 0xF0F, ..).
	///   - transparency: optional transparency value (default is 1).
	public convenience init?(hexString: String, transparency: CGFloat = 1) {
		var string = ""
		if hexString.lowercased().starts(with: "0x") {
			string =  hexString.replacingOccurrences(of: "0x", with: "")
		} else if hexString.starts(with: "#") {
			string = hexString.replacingOccurrences(of: "#", with: "")
		} else {
			string = hexString
		}
		
		if string.characters.count == 3 { // convert hex to 6 digit format if in short format
			var str = ""
			string.characters.forEach({ str.append(String(repeating: String($0), count: 2)) })
			string = str
		}
		
		guard let hexValue = Int(string, radix: 16) else {
			return nil
		}
		
		self.init(hex: Int(hexValue), transparency: transparency)
	}
	
	/// SwifterSwift: Create UIColor from RGB values with optional transparency.
	///
	/// - Parameters:
	///   - red: red component.
	///   - green: green component.
	///   - blue: blue component.
	///   - transparency: optional transparency value (default is 1).
	public convenience init(red: Int, green: Int, blue: Int, transparency: CGFloat = 1) {
		assert(red >= 0 && red <= 255, "Invalid red component")
		assert(green >= 0 && green <= 255, "Invalid green component")
		assert(blue >= 0 && blue <= 255, "Invalid blue component")
		var trans: CGFloat {
			if transparency > 1 {
				return 1
			} else if transparency < 0 {
				return 0
			} else {
				return transparency
			}
		}
		self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: trans)
	}
	
	/// SwifterSwift: Create UIColor from a complementary of a UIColor (if applicable).
	///
	/// - Parameter color: color of which opposite color is desired.
	public convenience init?(complementaryFor color: UIColor) {
		let colorSpaceRGB = CGColorSpaceCreateDeviceRGB()
		let convertColorToRGBSpace : ((_ color : UIColor) -> UIColor?) = { (color) -> UIColor? in
			if color.cgColor.colorSpace!.model == CGColorSpaceModel.monochrome {
				let oldComponents = color.cgColor.components
				let components : [CGFloat] = [ oldComponents![0], oldComponents![0], oldComponents![0], oldComponents![1] ]
				let colorRef = CGColor(colorSpace: colorSpaceRGB, components: components)
				let colorOut = UIColor(cgColor: colorRef!)
				return colorOut
			}
			else {
				return color
			}
		}
		
		let c = convertColorToRGBSpace(color)
		guard let componentColors = c?.cgColor.components else {
			return nil
		}
		
		let r: CGFloat = sqrt(pow(255.0, 2.0) - pow((componentColors[0]*255), 2.0))/255
		let g: CGFloat = sqrt(pow(255.0, 2.0) - pow((componentColors[1]*255), 2.0))/255
		let b: CGFloat = sqrt(pow(255.0, 2.0) - pow((componentColors[2]*255), 2.0))/255
		self.init(red: r, green: g, blue: b, alpha: 1.0)
	}
	
}


//MARK: - Social Colors
public extension UIColor {
	
	/// SwifterSwift: Brand identity color of popular social media platform.
	public struct social {
		// https://www.lockedowndesign.com/social-media-colors/
		
		/// SwifterSwift: red: 59, green: 89, blue: 152
		public static let facebook = UIColor(red: 59, green: 89, blue: 152)
		
		/// SwifterSwift: red: 0, green: 182, blue: 241
		public static let twitter = UIColor(red: 0, green: 182, blue: 241)
		
		/// SwifterSwift: red: 223, green: 74, blue: 50
		public static let googlePlus = UIColor(red: 223, green: 74, blue: 50)
		
		/// SwifterSwift: red: 0, green: 123, blue: 182
		public static let linkedIn = UIColor(red: 0, green: 123, blue: 182)
		
		/// SwifterSwift: red: 69, green: 187, blue: 255
		public static let vimeo = UIColor(red: 69, green: 187, blue: 255)
		
		/// SwifterSwift: red: 179, green: 18, blue: 23
		public static let youtube = UIColor(red: 179, green: 18, blue: 23)
		
		/// SwifterSwift: red: 195, green: 42, blue: 163
		public static let instagram = UIColor(red: 195, green: 42, blue: 163)
		
		/// SwifterSwift: red: 203, green: 32, blue: 39
		public static let pinterest = UIColor(red: 203, green: 32, blue: 39)
		
		/// SwifterSwift: red: 244, green: 0, blue: 131
		public static let flickr = UIColor(red: 244, green: 0, blue: 131)
		
		/// SwifterSwift: red: 67, green: 2, blue: 151
		public static let yahoo = UIColor(red: 67, green: 2, blue: 151)
		
		/// SwifterSwift: red: 67, green: 2, blue: 151
		public static let soundCloud = UIColor(red: 67, green: 2, blue: 151)
		
		/// SwifterSwift: red: 44, green: 71, blue: 98
		public static let tumblr = UIColor(red: 44, green: 71, blue: 98)
		
		/// SwifterSwift: red: 252, green: 69, blue: 117
		public static let foursquare = UIColor(red: 252, green: 69, blue: 117)
		
		/// SwifterSwift: red: 255, green: 176, blue: 0
		public static let swarm = UIColor(red: 255, green: 176, blue: 0)
		
		/// SwifterSwift: red: 234, green: 76, blue: 137
		public static let dribbble = UIColor(red: 234, green: 76, blue: 137)
		
		/// SwifterSwift: red: 255, green: 87, blue: 0
		public static let reddit = UIColor(red: 255, green: 87, blue: 0)
		
		/// SwifterSwift: red: 74, green: 93, blue: 78
		public static let devianArt = UIColor(red: 74, green: 93, blue: 78)
		
		/// SwifterSwift: red: 238, green: 64, blue: 86
		public static let pocket = UIColor(red: 238, green: 64, blue: 86)
		
		/// SwifterSwift: red: 170, green: 34, blue: 182
		public static let quora = UIColor(red: 170, green: 34, blue: 182)
		
		/// SwifterSwift: red: 247, green: 146, blue: 30
		public static let slideShare = UIColor(red: 247, green: 146, blue: 30)
		
		/// SwifterSwift: red: 0, green: 153, blue: 229
		public static let px500 = UIColor(red: 0, green: 153, blue: 229)
		
		/// SwifterSwift: red: 223, green: 109, blue: 70
		public static let listly = UIColor(red: 223, green: 109, blue: 70)
		
		/// SwifterSwift: red: 0, green: 180, blue: 137
		public static let vine = UIColor(red: 0, green: 180, blue: 137)
		
		/// SwifterSwift: red: 0, green: 175, blue: 240
		public static let skype = UIColor(red: 0, green: 175, blue: 240)
		
		/// SwifterSwift: red: 235, green: 73, blue: 36
		public static let stumbleUpon = UIColor(red: 235, green: 73, blue: 36)
		
		/// SwifterSwift: red: 255, green: 252, blue: 0
		public static let snapchat = UIColor(red: 255, green: 252, blue: 0)
		
	}
}


//MARK: - Material colors
public extension UIColor {
	
	/// SwifterSwift: Google Material design colors palette.
	public struct material {
		// https://material.google.com/style/color.html
		
		/// SwifterSwift: color red500
		public static let red					= red500
		
		/// SwifterSwift: hex #FFEBEE
		public static let red50					= UIColor(hex: 0xFFEBEE)
		
		/// SwifterSwift: hex #FFCDD2
		public static let red100				= UIColor(hex: 0xFFCDD2)
		
		/// SwifterSwift: hex #EF9A9A
		public static let red200				= UIColor(hex: 0xEF9A9A)
		
		/// SwifterSwift: hex #E57373
		public static let red300				= UIColor(hex: 0xE57373)
		
		/// SwifterSwift: hex #EF5350
		public static let red400				= UIColor(hex: 0xEF5350)
		
		/// SwifterSwift: hex #F44336
		public static let red500				= UIColor(hex: 0xF44336)
		
		/// SwifterSwift: hex #E53935
		public static let red600				= UIColor(hex: 0xE53935)
		
		/// SwifterSwift: hex #D32F2F
		public static let red700				= UIColor(hex: 0xD32F2F)
		
		/// SwifterSwift: hex #C62828
		public static let red800				= UIColor(hex: 0xC62828)
		
		/// SwifterSwift: hex #B71C1C
		public static let red900				= UIColor(hex: 0xB71C1C)
		
		/// SwifterSwift: hex #FF8A80
		public static let redA100				= UIColor(hex: 0xFF8A80)
		
		/// SwifterSwift: hex #FF5252
		public static let redA200				= UIColor(hex: 0xFF5252)
		
		/// SwifterSwift: hex #FF1744
		public static let redA400				= UIColor(hex: 0xFF1744)
		
		/// SwifterSwift: hex #D50000
		public static let redA700				= UIColor(hex: 0xD50000)
		
		
		/// SwifterSwift: color pink500
		public static let pink					= pink500
		
		/// SwifterSwift: hex #FCE4EC
		public static let pink50				= UIColor(hex: 0xFCE4EC)
		
		/// SwifterSwift: hex #F8BBD0
		public static let pink100				= UIColor(hex: 0xF8BBD0)
		
		/// SwifterSwift: hex #F48FB1
		public static let pink200				= UIColor(hex: 0xF48FB1)
		
		/// SwifterSwift: hex #F06292
		public static let pink300				= UIColor(hex: 0xF06292)
		
		/// SwifterSwift: hex #EC407A
		public static let pink400				= UIColor(hex: 0xEC407A)
		
		/// SwifterSwift: hex #E91E63
		public static let pink500				= UIColor(hex: 0xE91E63)
		
		/// SwifterSwift: hex #D81B60
		public static let pink600				= UIColor(hex: 0xD81B60)
		
		/// SwifterSwift: hex #C2185B
		public static let pink700				= UIColor(hex: 0xC2185B)
		
		/// SwifterSwift: hex #AD1457
		public static let pink800				= UIColor(hex: 0xAD1457)
		
		/// SwifterSwift: hex #880E4F
		public static let pink900				= UIColor(hex: 0x880E4F)
		
		/// SwifterSwift: hex #FF80AB
		public static let pinkA100				= UIColor(hex: 0xFF80AB)
		
		/// SwifterSwift: hex #FF4081
		public static let pinkA200				= UIColor(hex: 0xFF4081)
		
		/// SwifterSwift: hex #F50057
		public static let pinkA400				= UIColor(hex: 0xF50057)
		
		/// SwifterSwift: hex #C51162
		public static let pinkA700				= UIColor(hex: 0xC51162)
		
		
		/// SwifterSwift: color purple500
		public static let purple				= purple500
		
		/// SwifterSwift: hex #F3E5F5
		public static let purple50				= UIColor(hex: 0xF3E5F5)
		
		/// SwifterSwift: hex #E1BEE7
		public static let purple100				= UIColor(hex: 0xE1BEE7)
		
		/// SwifterSwift: hex #CE93D8
		public static let purple200				= UIColor(hex: 0xCE93D8)
		
		/// SwifterSwift: hex #BA68C8
		public static let purple300				= UIColor(hex: 0xBA68C8)
		
		/// SwifterSwift: hex #AB47BC
		public static let purple400				= UIColor(hex: 0xAB47BC)
		
		/// SwifterSwift: hex #9C27B0
		public static let purple500				= UIColor(hex: 0x9C27B0)
		
		/// SwifterSwift: hex #8E24AA
		public static let purple600				= UIColor(hex: 0x8E24AA)
		
		/// SwifterSwift: hex #7B1FA2
		public static let purple700				= UIColor(hex: 0x7B1FA2)
		
		/// SwifterSwift: hex #6A1B9A
		public static let purple800				= UIColor(hex: 0x6A1B9A)
		
		/// SwifterSwift: hex #4A148C
		public static let purple900				= UIColor(hex: 0x4A148C)
		
		/// SwifterSwift: hex #EA80FC
		public static let purpleA100			= UIColor(hex: 0xEA80FC)
		
		/// SwifterSwift: hex #E040FB
		public static let purpleA200			= UIColor(hex: 0xE040FB)
		
		/// SwifterSwift: hex #D500F9
		public static let purpleA400			= UIColor(hex: 0xD500F9)
		
		/// SwifterSwift: hex #AA00FF
		public static let purpleA700			= UIColor(hex: 0xAA00FF)
		
		
		/// SwifterSwift: color deepPurple500
		public static let deepPurple			= deepPurple500
		
		/// SwifterSwift: hex #EDE7F6
		public static let deepPurple50			= UIColor(hex: 0xEDE7F6)
		
		/// SwifterSwift: hex #D1C4E9
		public static let deepPurple100			= UIColor(hex: 0xD1C4E9)
		
		/// SwifterSwift: hex #B39DDB
		public static let deepPurple200			= UIColor(hex: 0xB39DDB)
		
		/// SwifterSwift: hex #9575CD
		public static let deepPurple300			= UIColor(hex: 0x9575CD)
		
		/// SwifterSwift: hex #7E57C2
		public static let deepPurple400			= UIColor(hex: 0x7E57C2)
		
		/// SwifterSwift: hex #673AB7
		public static let deepPurple500			= UIColor(hex: 0x673AB7)
		
		/// SwifterSwift: hex #5E35B1
		public static let deepPurple600			= UIColor(hex: 0x5E35B1)
		
		/// SwifterSwift: hex #512DA8
		public static let deepPurple700			= UIColor(hex: 0x512DA8)
		
		/// SwifterSwift: hex #4527A0
		public static let deepPurple800			= UIColor(hex: 0x4527A0)
		
		/// SwifterSwift: hex #311B92
		public static let deepPurple900			= UIColor(hex: 0x311B92)
		
		/// SwifterSwift: hex #B388FF
		public static let deepPurpleA100		= UIColor(hex: 0xB388FF)
		
		/// SwifterSwift: hex #7C4DFF
		public static let deepPurpleA200		= UIColor(hex: 0x7C4DFF)
		
		/// SwifterSwift: hex #651FFF
		public static let deepPurpleA400		= UIColor(hex: 0x651FFF)
		
		/// SwifterSwift: hex #6200EA
		public static let deepPurpleA700		= UIColor(hex: 0x6200EA)
		
		
		/// SwifterSwift: color indigo500
		public static let indigo				= indigo500
		
		/// SwifterSwift: hex #E8EAF6
		public static let indigo50				= UIColor(hex: 0xE8EAF6)
		
		/// SwifterSwift: hex #C5CAE9
		public static let indigo100				= UIColor(hex: 0xC5CAE9)
		
		/// SwifterSwift: hex #9FA8DA
		public static let indigo200				= UIColor(hex: 0x9FA8DA)
		
		/// SwifterSwift: hex #7986CB
		public static let indigo300				= UIColor(hex: 0x7986CB)
		
		/// SwifterSwift: hex #5C6BC0
		public static let indigo400				= UIColor(hex: 0x5C6BC0)
		
		/// SwifterSwift: hex #3F51B5
		public static let indigo500				= UIColor(hex: 0x3F51B5)
		
		/// SwifterSwift: hex #3949AB
		public static let indigo600				= UIColor(hex: 0x3949AB)
		
		/// SwifterSwift: hex #303F9F
		public static let indigo700				= UIColor(hex: 0x303F9F)
		
		/// SwifterSwift: hex #283593
		public static let indigo800				= UIColor(hex: 0x283593)
		
		/// SwifterSwift: hex #1A237E
		public static let indigo900				= UIColor(hex: 0x1A237E)
		
		/// SwifterSwift: hex #8C9EFF
		public static let indigoA100			= UIColor(hex: 0x8C9EFF)
		
		/// SwifterSwift: hex #536DFE
		public static let indigoA200			= UIColor(hex: 0x536DFE)
		
		/// SwifterSwift: hex #3D5AFE
		public static let indigoA400			= UIColor(hex: 0x3D5AFE)
		
		/// SwifterSwift: hex #304FFE
		public static let indigoA700			= UIColor(hex: 0x304FFE)
		
		
		/// SwifterSwift: color blue500
		public static let blue					= blue500
		
		/// SwifterSwift: hex #E3F2FD
		public static let blue50				= UIColor(hex: 0xE3F2FD)
		
		/// SwifterSwift: hex #BBDEFB
		public static let blue100				= UIColor(hex: 0xBBDEFB)
		
		/// SwifterSwift: hex #90CAF9
		public static let blue200				= UIColor(hex: 0x90CAF9)
		
		/// SwifterSwift: hex #64B5F6
		public static let blue300				= UIColor(hex: 0x64B5F6)
		
		/// SwifterSwift: hex #42A5F5
		public static let blue400				= UIColor(hex: 0x42A5F5)
		
		/// SwifterSwift: hex #2196F3
		public static let blue500				= UIColor(hex: 0x2196F3)
		
		/// SwifterSwift: hex #1E88E5
		public static let blue600				= UIColor(hex: 0x1E88E5)
		
		/// SwifterSwift: hex #1976D2
		public static let blue700				= UIColor(hex: 0x1976D2)
		
		/// SwifterSwift: hex #1565C0
		public static let blue800				= UIColor(hex: 0x1565C0)
		
		/// SwifterSwift: hex #0D47A1
		public static let blue900				= UIColor(hex: 0x0D47A1)
		
		/// SwifterSwift: hex #82B1FF
		public static let blueA100				= UIColor(hex: 0x82B1FF)
		
		/// SwifterSwift: hex #448AFF
		public static let blueA200				= UIColor(hex: 0x448AFF)
		
		/// SwifterSwift: hex #2979FF
		public static let blueA400				= UIColor(hex: 0x2979FF)
		
		/// SwifterSwift: hex #2962FF
		public static let blueA700				= UIColor(hex: 0x2962FF)
		
		
		/// SwifterSwift: color lightBlue500
		public static let lightBlue				= lightBlue500
		
		/// SwifterSwift: hex #E1F5FE
		public static let lightBlue50			= UIColor(hex: 0xE1F5FE)
		
		/// SwifterSwift: hex #B3E5FC
		public static let lightBlue100			= UIColor(hex: 0xB3E5FC)
		
		/// SwifterSwift: hex #81D4FA
		public static let lightBlue200			= UIColor(hex: 0x81D4FA)
		
		/// SwifterSwift: hex #4FC3F7
		public static let lightBlue300			= UIColor(hex: 0x4FC3F7)
		
		/// SwifterSwift: hex #29B6F6
		public static let lightBlue400			= UIColor(hex: 0x29B6F6)
		
		/// SwifterSwift: hex #03A9F4
		public static let lightBlue500			= UIColor(hex: 0x03A9F4)
		
		/// SwifterSwift: hex #039BE5
		public static let lightBlue600			= UIColor(hex: 0x039BE5)
		
		/// SwifterSwift: hex #0288D1
		public static let lightBlue700			= UIColor(hex: 0x0288D1)
		
		/// SwifterSwift: hex #0277BD
		public static let lightBlue800			= UIColor(hex: 0x0277BD)
		
		/// SwifterSwift: hex #01579B
		public static let lightBlue900			= UIColor(hex: 0x01579B)
		
		/// SwifterSwift: hex #80D8FF
		public static let lightBlueA100			= UIColor(hex: 0x80D8FF)
		
		/// SwifterSwift: hex #40C4FF
		public static let lightBlueA200			= UIColor(hex: 0x40C4FF)
		
		/// SwifterSwift: hex #00B0FF
		public static let lightBlueA400			= UIColor(hex: 0x00B0FF)
		
		/// SwifterSwift: hex #0091EA
		public static let lightBlueA700			= UIColor(hex: 0x0091EA)
		
		
		/// SwifterSwift: color cyan500
		public static let cyan					= cyan500
		
		/// SwifterSwift: hex #E0F7FA
		public static let cyan50				= UIColor(hex: 0xE0F7FA)
		
		/// SwifterSwift: hex #B2EBF2
		public static let cyan100				= UIColor(hex: 0xB2EBF2)
		
		/// SwifterSwift: hex #80DEEA
		public static let cyan200				= UIColor(hex: 0x80DEEA)
		
		/// SwifterSwift: hex #4DD0E1
		public static let cyan300				= UIColor(hex: 0x4DD0E1)
		
		/// SwifterSwift: hex #26C6DA
		public static let cyan400				= UIColor(hex: 0x26C6DA)
		
		/// SwifterSwift: hex #00BCD4
		public static let cyan500				= UIColor(hex: 0x00BCD4)
		
		/// SwifterSwift: hex #00ACC1
		public static let cyan600				= UIColor(hex: 0x00ACC1)
		
		/// SwifterSwift: hex #0097A7
		public static let cyan700				= UIColor(hex: 0x0097A7)
		
		/// SwifterSwift: hex #00838F
		public static let cyan800				= UIColor(hex: 0x00838F)
		
		/// SwifterSwift: hex #006064
		public static let cyan900				= UIColor(hex: 0x006064)
		
		/// SwifterSwift: hex #84FFFF
		public static let cyanA100				= UIColor(hex: 0x84FFFF)
		
		/// SwifterSwift: hex #18FFFF
		public static let cyanA200				= UIColor(hex: 0x18FFFF)
		
		/// SwifterSwift: hex #00E5FF
		public static let cyanA400				= UIColor(hex: 0x00E5FF)
		
		/// SwifterSwift: hex #00B8D4
		public static let cyanA700				= UIColor(hex: 0x00B8D4)
		
		
		/// SwifterSwift: color teal500
		public static let teal					= teal500
		
		/// SwifterSwift: hex #E0F2F1
		public static let teal50				= UIColor(hex: 0xE0F2F1)
		
		/// SwifterSwift: hex #B2DFDB
		public static let teal100				= UIColor(hex: 0xB2DFDB)
		
		/// SwifterSwift: hex #80CBC4
		public static let teal200				= UIColor(hex: 0x80CBC4)
		
		/// SwifterSwift: hex #4DB6AC
		public static let teal300				= UIColor(hex: 0x4DB6AC)
		
		/// SwifterSwift: hex #26A69A
		public static let teal400				= UIColor(hex: 0x26A69A)
		
		/// SwifterSwift: hex #009688
		public static let teal500				= UIColor(hex: 0x009688)
		
		/// SwifterSwift: hex #00897B
		public static let teal600				= UIColor(hex: 0x00897B)
		
		/// SwifterSwift: hex #00796B
		public static let teal700				= UIColor(hex: 0x00796B)
		
		/// SwifterSwift: hex #00695C
		public static let teal800				= UIColor(hex: 0x00695C)
		
		/// SwifterSwift: hex #004D40
		public static let teal900				= UIColor(hex: 0x004D40)
		
		/// SwifterSwift: hex #A7FFEB
		public static let tealA100				= UIColor(hex: 0xA7FFEB)
		
		/// SwifterSwift: hex #64FFDA
		public static let tealA200				= UIColor(hex: 0x64FFDA)
		
		/// SwifterSwift: hex #1DE9B6
		public static let tealA400				= UIColor(hex: 0x1DE9B6)
		
		/// SwifterSwift: hex #00BFA5
		public static let tealA700				= UIColor(hex: 0x00BFA5)
		
		
		/// SwifterSwift: color green500
		public static let green					= green500
		
		/// SwifterSwift: hex #E8F5E9
		public static let green50				= UIColor(hex: 0xE8F5E9)
		
		/// SwifterSwift: hex #C8E6C9
		public static let green100				= UIColor(hex: 0xC8E6C9)
		
		/// SwifterSwift: hex #A5D6A7
		public static let green200				= UIColor(hex: 0xA5D6A7)
		
		/// SwifterSwift: hex #81C784
		public static let green300				= UIColor(hex: 0x81C784)
		
		/// SwifterSwift: hex #66BB6A
		public static let green400				= UIColor(hex: 0x66BB6A)
		
		/// SwifterSwift: hex #4CAF50
		public static let green500				= UIColor(hex: 0x4CAF50)
		
		/// SwifterSwift: hex #43A047
		public static let green600				= UIColor(hex: 0x43A047)
		
		/// SwifterSwift: hex #388E3C
		public static let green700				= UIColor(hex: 0x388E3C)
		
		/// SwifterSwift: hex #2E7D32
		public static let green800				= UIColor(hex: 0x2E7D32)
		
		/// SwifterSwift: hex #1B5E20
		public static let green900				= UIColor(hex: 0x1B5E20)
		
		/// SwifterSwift: hex #B9F6CA
		public static let greenA100				= UIColor(hex: 0xB9F6CA)
		
		/// SwifterSwift: hex #69F0AE
		public static let greenA200				= UIColor(hex: 0x69F0AE)
		
		/// SwifterSwift: hex #00E676
		public static let greenA400				= UIColor(hex: 0x00E676)
		
		/// SwifterSwift: hex #00C853
		public static let greenA700				= UIColor(hex: 0x00C853)
		
		
		/// SwifterSwift: color lightGreen500
		public static let lightGreen			= lightGreen500
		
		/// SwifterSwift: hex #F1F8E9
		public static let lightGreen50			= UIColor(hex: 0xF1F8E9)
		
		/// SwifterSwift: hex #DCEDC8
		public static let lightGreen100			= UIColor(hex: 0xDCEDC8)
		
		/// SwifterSwift: hex #C5E1A5
		public static let lightGreen200			= UIColor(hex: 0xC5E1A5)
		
		/// SwifterSwift: hex #AED581
		public static let lightGreen300			= UIColor(hex: 0xAED581)
		
		/// SwifterSwift: hex #9CCC65
		public static let lightGreen400			= UIColor(hex: 0x9CCC65)
		
		/// SwifterSwift: hex #8BC34A
		public static let lightGreen500			= UIColor(hex: 0x8BC34A)
		
		/// SwifterSwift: hex #7CB342
		public static let lightGreen600			= UIColor(hex: 0x7CB342)
		
		/// SwifterSwift: hex #689F38
		public static let lightGreen700			= UIColor(hex: 0x689F38)
		
		/// SwifterSwift: hex #558B2F
		public static let lightGreen800			= UIColor(hex: 0x558B2F)
		
		/// SwifterSwift: hex #33691E
		public static let lightGreen900			= UIColor(hex: 0x33691E)
		
		/// SwifterSwift: hex #CCFF90
		public static let lightGreenA100		= UIColor(hex: 0xCCFF90)
		
		/// SwifterSwift: hex #B2FF59
		public static let lightGreenA200		= UIColor(hex: 0xB2FF59)
		
		/// SwifterSwift: hex #76FF03
		public static let lightGreenA400		= UIColor(hex: 0x76FF03)
		
		/// SwifterSwift: hex #64DD17
		public static let lightGreenA700		= UIColor(hex: 0x64DD17)
		
		
		/// SwifterSwift: color lime500
		public static let lime					= lime500
		
		/// SwifterSwift: hex #F9FBE7
		public static let lime50				= UIColor(hex: 0xF9FBE7)
		
		/// SwifterSwift: hex #F0F4C3
		public static let lime100				= UIColor(hex: 0xF0F4C3)
		
		/// SwifterSwift: hex #E6EE9C
		public static let lime200				= UIColor(hex: 0xE6EE9C)
		
		/// SwifterSwift: hex #DCE775
		public static let lime300				= UIColor(hex: 0xDCE775)
		
		/// SwifterSwift: hex #D4E157
		public static let lime400				= UIColor(hex: 0xD4E157)
		
		/// SwifterSwift: hex #CDDC39
		public static let lime500				= UIColor(hex: 0xCDDC39)
		
		/// SwifterSwift: hex #C0CA33
		public static let lime600				= UIColor(hex: 0xC0CA33)
		
		/// SwifterSwift: hex #AFB42B
		public static let lime700				= UIColor(hex: 0xAFB42B)
		
		/// SwifterSwift: hex #9E9D24
		public static let lime800				= UIColor(hex: 0x9E9D24)
		
		/// SwifterSwift: hex #827717
		public static let lime900				= UIColor(hex: 0x827717)
		
		/// SwifterSwift: hex #F4FF81
		public static let limeA100				= UIColor(hex: 0xF4FF81)
		
		/// SwifterSwift: hex #EEFF41
		public static let limeA200				= UIColor(hex: 0xEEFF41)
		
		/// SwifterSwift: hex #C6FF00
		public static let limeA400				= UIColor(hex: 0xC6FF00)
		
		/// SwifterSwift: hex #AEEA00
		public static let limeA700				= UIColor(hex: 0xAEEA00)
		
		
		/// SwifterSwift: color yellow500
		public static let yellow				= yellow500
		
		/// SwifterSwift: hex #FFFDE7
		public static let yellow50				= UIColor(hex: 0xFFFDE7)
		
		/// SwifterSwift: hex #FFF9C4
		public static let yellow100				= UIColor(hex: 0xFFF9C4)
		
		/// SwifterSwift: hex #FFF59D
		public static let yellow200				= UIColor(hex: 0xFFF59D)
		
		/// SwifterSwift: hex #FFF176
		public static let yellow300				= UIColor(hex: 0xFFF176)
		
		/// SwifterSwift: hex #FFEE58
		public static let yellow400				= UIColor(hex: 0xFFEE58)
		
		/// SwifterSwift: hex #FFEB3B
		public static let yellow500				= UIColor(hex: 0xFFEB3B)
		
		/// SwifterSwift: hex #FDD835
		public static let yellow600				= UIColor(hex: 0xFDD835)
		
		/// SwifterSwift: hex #FBC02D
		public static let yellow700				= UIColor(hex: 0xFBC02D)
		
		/// SwifterSwift: hex #F9A825
		public static let yellow800				= UIColor(hex: 0xF9A825)
		
		/// SwifterSwift: hex #F57F17
		public static let yellow900				= UIColor(hex: 0xF57F17)
		
		/// SwifterSwift: hex #FFFF8D
		public static let yellowA100			= UIColor(hex: 0xFFFF8D)
		
		/// SwifterSwift: hex #FFFF00
		public static let yellowA200			= UIColor(hex: 0xFFFF00)
		
		/// SwifterSwift: hex #FFEA00
		public static let yellowA400			= UIColor(hex: 0xFFEA00)
		
		/// SwifterSwift: hex #FFD600
		public static let yellowA700			= UIColor(hex: 0xFFD600)
		
		
		/// SwifterSwift: color amber500
		public static let amber					= amber500
		
		/// SwifterSwift: hex #FFF8E1
		public static let amber50				= UIColor(hex: 0xFFF8E1)
		
		/// SwifterSwift: hex #FFECB3
		public static let amber100				= UIColor(hex: 0xFFECB3)
		
		/// SwifterSwift: hex #FFE082
		public static let amber200				= UIColor(hex: 0xFFE082)
		
		/// SwifterSwift: hex #FFD54F
		public static let amber300				= UIColor(hex: 0xFFD54F)
		
		/// SwifterSwift: hex #FFCA28
		public static let amber400				= UIColor(hex: 0xFFCA28)
		
		/// SwifterSwift: hex #FFC107
		public static let amber500				= UIColor(hex: 0xFFC107)
		
		/// SwifterSwift: hex #FFB300
		public static let amber600				= UIColor(hex: 0xFFB300)
		
		/// SwifterSwift: hex #FFA000
		public static let amber700				= UIColor(hex: 0xFFA000)
		
		/// SwifterSwift: hex #FF8F00
		public static let amber800				= UIColor(hex: 0xFF8F00)
		
		/// SwifterSwift: hex #FF6F00
		public static let amber900				= UIColor(hex: 0xFF6F00)
		
		/// SwifterSwift: hex #FFE57F
		public static let amberA100				= UIColor(hex: 0xFFE57F)
		
		/// SwifterSwift: hex #FFD740
		public static let amberA200				= UIColor(hex: 0xFFD740)
		
		/// SwifterSwift: hex #FFC400
		public static let amberA400				= UIColor(hex: 0xFFC400)
		
		/// SwifterSwift: hex #FFAB00
		public static let amberA700				= UIColor(hex: 0xFFAB00)
		
		
		/// SwifterSwift: color orange500
		public static let orange				= orange500
		
		/// SwifterSwift: hex #FFF3E0
		public static let orange50				= UIColor(hex: 0xFFF3E0)
		
		/// SwifterSwift: hex #FFE0B2
		public static let orange100				= UIColor(hex: 0xFFE0B2)
		
		/// SwifterSwift: hex #FFCC80
		public static let orange200				= UIColor(hex: 0xFFCC80)
		
		/// SwifterSwift: hex #FFB74D
		public static let orange300				= UIColor(hex: 0xFFB74D)
		
		/// SwifterSwift: hex #FFA726
		public static let orange400				= UIColor(hex: 0xFFA726)
		
		/// SwifterSwift: hex #FF9800
		public static let orange500				= UIColor(hex: 0xFF9800)
		
		/// SwifterSwift: hex #FB8C00
		public static let orange600				= UIColor(hex: 0xFB8C00)
		
		/// SwifterSwift: hex #F57C00
		public static let orange700				= UIColor(hex: 0xF57C00)
		
		/// SwifterSwift: hex #EF6C00
		public static let orange800				= UIColor(hex: 0xEF6C00)
		
		/// SwifterSwift: hex #E65100
		public static let orange900				= UIColor(hex: 0xE65100)
		
		/// SwifterSwift: hex #FFD180
		public static let orangeA100			= UIColor(hex: 0xFFD180)
		
		/// SwifterSwift: hex #FFAB40
		public static let orangeA200			= UIColor(hex: 0xFFAB40)
		
		/// SwifterSwift: hex #FF9100
		public static let orangeA400			= UIColor(hex: 0xFF9100)
		
		/// SwifterSwift: hex #FF6D00
		public static let orangeA700			= UIColor(hex: 0xFF6D00)
		
		
		/// SwifterSwift: color deepOrange500
		public static let deepOrange			= deepOrange500
		
		/// SwifterSwift: hex #FBE9E7
		public static let deepOrange50			= UIColor(hex: 0xFBE9E7)
		
		/// SwifterSwift: hex #FFCCBC
		public static let deepOrange100			= UIColor(hex: 0xFFCCBC)
		
		/// SwifterSwift: hex #FFAB91
		public static let deepOrange200			= UIColor(hex: 0xFFAB91)
		
		/// SwifterSwift: hex #FF8A65
		public static let deepOrange300			= UIColor(hex: 0xFF8A65)
		
		/// SwifterSwift: hex #FF7043
		public static let deepOrange400			= UIColor(hex: 0xFF7043)
		
		/// SwifterSwift: hex #FF5722
		public static let deepOrange500			= UIColor(hex: 0xFF5722)
		
		/// SwifterSwift: hex #F4511E
		public static let deepOrange600			= UIColor(hex: 0xF4511E)
		
		/// SwifterSwift: hex #E64A19
		public static let deepOrange700			= UIColor(hex: 0xE64A19)
		
		/// SwifterSwift: hex #D84315
		public static let deepOrange800			= UIColor(hex: 0xD84315)
		
		/// SwifterSwift: hex #BF360C
		public static let deepOrange900			= UIColor(hex: 0xBF360C)
		
		/// SwifterSwift: hex #FF9E80
		public static let deepOrangeA100		= UIColor(hex: 0xFF9E80)
		
		/// SwifterSwift: hex #FF6E40
		public static let deepOrangeA200		= UIColor(hex: 0xFF6E40)
		
		/// SwifterSwift: hex #FF3D00
		public static let deepOrangeA400		= UIColor(hex: 0xFF3D00)
		
		/// SwifterSwift: hex #DD2C00
		public static let deepOrangeA700		= UIColor(hex: 0xDD2C00)
		
		
		/// SwifterSwift: color brown500
		public static let brown					= brown500
		
		/// SwifterSwift: hex #EFEBE9
		public static let brown50				= UIColor(hex: 0xEFEBE9)
		
		/// SwifterSwift: hex #D7CCC8
		public static let brown100				= UIColor(hex: 0xD7CCC8)
		
		/// SwifterSwift: hex #BCAAA4
		public static let brown200				= UIColor(hex: 0xBCAAA4)
		
		/// SwifterSwift: hex #A1887F
		public static let brown300				= UIColor(hex: 0xA1887F)
		
		/// SwifterSwift: hex #8D6E63
		public static let brown400				= UIColor(hex: 0x8D6E63)
		
		/// SwifterSwift: hex #795548
		public static let brown500				= UIColor(hex: 0x795548)
		
		/// SwifterSwift: hex #6D4C41
		public static let brown600				= UIColor(hex: 0x6D4C41)
		
		/// SwifterSwift: hex #5D4037
		public static let brown700				= UIColor(hex: 0x5D4037)
		
		/// SwifterSwift: hex #4E342E
		public static let brown800				= UIColor(hex: 0x4E342E)
		
		/// SwifterSwift: hex #3E2723
		public static let brown900				= UIColor(hex: 0x3E2723)
		
		
		/// SwifterSwift: color grey500
		public static let grey					= grey500
		
		/// SwifterSwift: hex #FAFAFA
		public static let grey50				= UIColor(hex: 0xFAFAFA)
		
		/// SwifterSwift: hex #F5F5F5
		public static let grey100				= UIColor(hex: 0xF5F5F5)
		
		/// SwifterSwift: hex #EEEEEE
		public static let grey200				= UIColor(hex: 0xEEEEEE)
		
		/// SwifterSwift: hex #E0E0E0
		public static let grey300				= UIColor(hex: 0xE0E0E0)
		
		/// SwifterSwift: hex #BDBDBD
		public static let grey400				= UIColor(hex: 0xBDBDBD)
		
		/// SwifterSwift: hex #9E9E9E
		public static let grey500				= UIColor(hex: 0x9E9E9E)
		
		/// SwifterSwift: hex #757575
		public static let grey600				= UIColor(hex: 0x757575)
		
		/// SwifterSwift: hex #616161
		public static let grey700				= UIColor(hex: 0x616161)
		
		/// SwifterSwift: hex #424242
		public static let grey800				= UIColor(hex: 0x424242)
		
		/// SwifterSwift: hex #212121
		public static let grey900				= UIColor(hex: 0x212121)
		
		
		/// SwifterSwift: color blueGrey500
		public static let blueGrey				= blueGrey500
		
		/// SwifterSwift: hex #ECEFF1
		public static let blueGrey50			= UIColor(hex: 0xECEFF1)
		
		/// SwifterSwift: hex #CFD8DC
		public static let blueGrey100			= UIColor(hex: 0xCFD8DC)
		
		/// SwifterSwift: hex #B0BEC5
		public static let blueGrey200			= UIColor(hex: 0xB0BEC5)
		
		/// SwifterSwift: hex #90A4AE
		public static let blueGrey300			= UIColor(hex: 0x90A4AE)
		
		/// SwifterSwift: hex #78909C
		public static let blueGrey400			= UIColor(hex: 0x78909C)
		
		/// SwifterSwift: hex #607D8B
		public static let blueGrey500			= UIColor(hex: 0x607D8B)
		
		/// SwifterSwift: hex #546E7A
		public static let blueGrey600			= UIColor(hex: 0x546E7A)
		
		/// SwifterSwift: hex #455A64
		public static let blueGrey700			= UIColor(hex: 0x455A64)
		
		/// SwifterSwift: hex #37474F
		public static let blueGrey800			= UIColor(hex: 0x37474F)
		
		/// SwifterSwift: hex #263238
		public static let blueGrey900			= UIColor(hex: 0x263238)
		
		
		/// SwifterSwift: hex #000000
		public static let black					= UIColor(hex: 0x000000)
		
		/// SwifterSwift: hex #FFFFFF
		public static let white					= UIColor(hex: 0xFFFFFF)
	}
	
}


public extension UIColor {
	
	/// SwifterSwift: CSS colors.
	public struct css {
		// http://www.w3schools.com/colors/colors_names.asp
		
		/// SwifterSwift: hex #F0F8FF
		public static let aliceBlue				= UIColor(hex: 0xF0F8FF)
		
		/// SwifterSwift: hex #FAEBD7
		public static let antiqueWhite			= UIColor(hex: 0xFAEBD7)
		
		/// SwifterSwift: hex #00FFFF
		public static let aqua					= UIColor(hex: 0x00FFFF)
		
		/// SwifterSwift: hex #7FFFD4
		public static let aquamarine			= UIColor(hex: 0x7FFFD4)
		
		/// SwifterSwift: hex #F0FFFF
		public static let azure					= UIColor(hex: 0xF0FFFF)
		
		/// SwifterSwift: hex #F5F5DC
		public static let beige					= UIColor(hex: 0xF5F5DC)
		
		/// SwifterSwift: hex #FFE4C4
		public static let bisque				= UIColor(hex: 0xFFE4C4)
		
		/// SwifterSwift: hex #000000
		public static let black					= UIColor(hex: 0x000000)
		
		/// SwifterSwift: hex #FFEBCD
		public static let blanchedAlmond		= UIColor(hex: 0xFFEBCD)
		
		/// SwifterSwift: hex #0000FF
		public static let blue					= UIColor(hex: 0x0000FF)
		
		/// SwifterSwift: hex #8A2BE2
		public static let blueViolet			= UIColor(hex: 0x8A2BE2)
		
		/// SwifterSwift: hex #A52A2A
		public static let brown					= UIColor(hex: 0xA52A2A)
		
		/// SwifterSwift: hex #DEB887
		public static let burlyWood				= UIColor(hex: 0xDEB887)
		
		/// SwifterSwift: hex #5F9EA0
		public static let cadetBlue				= UIColor(hex: 0x5F9EA0)
		
		/// SwifterSwift: hex #7FFF00
		public static let chartreuse			= UIColor(hex: 0x7FFF00)
		
		/// SwifterSwift: hex #D2691E
		public static let chocolate				= UIColor(hex: 0xD2691E)
		
		/// SwifterSwift: hex #FF7F50
		public static let coral					= UIColor(hex: 0xFF7F50)
		
		/// SwifterSwift: hex #6495ED
		public static let cornflowerBlue		= UIColor(hex: 0x6495ED)
		
		/// SwifterSwift: hex #FFF8DC
		public static let cornsilk				= UIColor(hex: 0xFFF8DC)
		
		/// SwifterSwift: hex #DC143C
		public static let crimson				= UIColor(hex: 0xDC143C)
		
		/// SwifterSwift: hex #00FFFF
		public static let cyan					= UIColor(hex: 0x00FFFF)
		
		/// SwifterSwift: hex #00008B
		public static let darkBlue				= UIColor(hex: 0x00008B)
		
		/// SwifterSwift: hex #008B8B
		public static let darkCyan				= UIColor(hex: 0x008B8B)
		
		/// SwifterSwift: hex #B8860B
		public static let darkGoldenRod			= UIColor(hex: 0xB8860B)
		
		/// SwifterSwift: hex #A9A9A9
		public static let darkGray				= UIColor(hex: 0xA9A9A9)
		
		/// SwifterSwift: hex #A9A9A9
		public static let darkGrey				= UIColor(hex: 0xA9A9A9)
		
		/// SwifterSwift: hex #006400
		public static let darkGreen				= UIColor(hex: 0x006400)
		
		/// SwifterSwift: hex #BDB76B
		public static let darkKhaki				= UIColor(hex: 0xBDB76B)
		
		/// SwifterSwift: hex #8B008B
		public static let darkMagenta			= UIColor(hex: 0x8B008B)
		
		/// SwifterSwift: hex #556B2F
		public static let darkOliveGreen		= UIColor(hex: 0x556B2F)
		
		/// SwifterSwift: hex #FF8C00
		public static let darkOrange			= UIColor(hex: 0xFF8C00)
		
		/// SwifterSwift: hex #9932CC
		public static let darkOrchid			= UIColor(hex: 0x9932CC)
		
		/// SwifterSwift: hex #8B0000
		public static let darkRed				= UIColor(hex: 0x8B0000)
		
		/// SwifterSwift: hex #E9967A
		public static let darkSalmon			= UIColor(hex: 0xE9967A)
		
		/// SwifterSwift: hex #8FBC8F
		public static let darkSeaGreen			= UIColor(hex: 0x8FBC8F)
		
		/// SwifterSwift: hex #483D8B
		public static let darkSlateBlue			= UIColor(hex: 0x483D8B)
		
		/// SwifterSwift: hex #2F4F4F
		public static let darkSlateGray			= UIColor(hex: 0x2F4F4F)
		
		/// SwifterSwift: hex #2F4F4F
		public static let darkSlateGrey			= UIColor(hex: 0x2F4F4F)
		
		/// SwifterSwift: hex #00CED1
		public static let darkTurquoise			= UIColor(hex: 0x00CED1)
		
		/// SwifterSwift: hex #9400D3
		public static let darkViolet			= UIColor(hex: 0x9400D3)
		
		/// SwifterSwift: hex #FF1493
		public static let deepPink				= UIColor(hex: 0xFF1493)
		
		/// SwifterSwift: hex #00BFFF
		public static let deepSkyBlue			= UIColor(hex: 0x00BFFF)
		
		/// SwifterSwift: hex #696969
		public static let dimGray				= UIColor(hex: 0x696969)
		
		/// SwifterSwift: hex #696969
		public static let dimGrey				= UIColor(hex: 0x696969)
		
		/// SwifterSwift: hex #1E90FF
		public static let dodgerBlue			= UIColor(hex: 0x1E90FF)
		
		/// SwifterSwift: hex #B22222
		public static let fireBrick				= UIColor(hex: 0xB22222)
		
		/// SwifterSwift: hex #FFFAF0
		public static let floralWhite			= UIColor(hex: 0xFFFAF0)
		
		/// SwifterSwift: hex #228B22
		public static let forestGreen			= UIColor(hex: 0x228B22)
		
		/// SwifterSwift: hex #FF00FF
		public static let fuchsia				= UIColor(hex: 0xFF00FF)
		
		/// SwifterSwift: hex #DCDCDC
		public static let gainsboro				= UIColor(hex: 0xDCDCDC)
		
		/// SwifterSwift: hex #F8F8FF
		public static let ghostWhite			= UIColor(hex: 0xF8F8FF)
		
		/// SwifterSwift: hex #FFD700
		public static let gold					= UIColor(hex: 0xFFD700)
		
		/// SwifterSwift: hex #DAA520
		public static let goldenRod				= UIColor(hex: 0xDAA520)
		
		/// SwifterSwift: hex #808080
		public static let gray					= UIColor(hex: 0x808080)
		
		/// SwifterSwift: hex #808080
		public static let grey					= UIColor(hex: 0x808080)
		
		/// SwifterSwift: hex #008000
		public static let green					= UIColor(hex: 0x008000)
		
		/// SwifterSwift: hex #ADFF2F
		public static let greenYellow			= UIColor(hex: 0xADFF2F)
		
		/// SwifterSwift: hex #F0FFF0
		public static let honeyDew				= UIColor(hex: 0xF0FFF0)
		
		/// SwifterSwift: hex #FF69B4
		public static let hotPink				= UIColor(hex: 0xFF69B4)
		
		/// SwifterSwift: hex #CD5C5C
		public static let indianRed				= UIColor(hex: 0xCD5C5C)
		
		/// SwifterSwift: hex #4B0082
		public static let indigo				= UIColor(hex: 0x4B0082)
		
		/// SwifterSwift: hex #FFFFF0
		public static let ivory					= UIColor(hex: 0xFFFFF0)
		
		/// SwifterSwift: hex #F0E68C
		public static let khaki					= UIColor(hex: 0xF0E68C)
		
		/// SwifterSwift: hex #E6E6FA
		public static let lavender				= UIColor(hex: 0xE6E6FA)
		
		/// SwifterSwift: hex #FFF0F5
		public static let lavenderBlush			= UIColor(hex: 0xFFF0F5)
		
		/// SwifterSwift: hex #7CFC00
		public static let lawnGreen				= UIColor(hex: 0x7CFC00)
		
		/// SwifterSwift: hex #FFFACD
		public static let lemonChiffon			= UIColor(hex: 0xFFFACD)
		
		/// SwifterSwift: hex #ADD8E6
		public static let lightBlue				= UIColor(hex: 0xADD8E6)
		
		/// SwifterSwift: hex #F08080
		public static let lightCoral			= UIColor(hex: 0xF08080)
		
		/// SwifterSwift: hex #E0FFFF
		public static let lightCyan				= UIColor(hex: 0xE0FFFF)
		
		/// SwifterSwift: hex #FAFAD2
		public static let lightGoldenRodYellow	= UIColor(hex: 0xFAFAD2)
		
		/// SwifterSwift: hex #D3D3D3
		public static let lightGray				= UIColor(hex: 0xD3D3D3)
		
		/// SwifterSwift: hex #D3D3D3
		public static let lightGrey				= UIColor(hex: 0xD3D3D3)
		
		/// SwifterSwift: hex #90EE90
		public static let lightGreen			= UIColor(hex: 0x90EE90)
		
		/// SwifterSwift: hex #FFB6C1
		public static let lightPink				= UIColor(hex: 0xFFB6C1)
		
		/// SwifterSwift: hex #FFA07A
		public static let lightSalmon			= UIColor(hex: 0xFFA07A)
		
		/// SwifterSwift: hex #20B2AA
		public static let lightSeaGreen			= UIColor(hex: 0x20B2AA)
		
		/// SwifterSwift: hex #87CEFA
		public static let lightSkyBlue			= UIColor(hex: 0x87CEFA)
		
		/// SwifterSwift: hex #778899
		public static let lightSlateGray		= UIColor(hex: 0x778899)
		
		/// SwifterSwift: hex #778899
		public static let lightSlateGrey		= UIColor(hex: 0x778899)
		
		/// SwifterSwift: hex #B0C4DE
		public static let lightSteelBlue		= UIColor(hex: 0xB0C4DE)
		
		/// SwifterSwift: hex #FFFFE0
		public static let lightYellow			= UIColor(hex: 0xFFFFE0)
		
		/// SwifterSwift: hex #00FF00
		public static let lime					= UIColor(hex: 0x00FF00)
		
		/// SwifterSwift: hex #32CD32
		public static let limeGreen				= UIColor(hex: 0x32CD32)
		
		/// SwifterSwift: hex #FAF0E6
		public static let linen					= UIColor(hex: 0xFAF0E6)
		
		/// SwifterSwift: hex #FF00FF
		public static let magenta				= UIColor(hex: 0xFF00FF)
		
		/// SwifterSwift: hex #800000
		public static let maroon				= UIColor(hex: 0x800000)
		
		/// SwifterSwift: hex #66CDAA
		public static let mediumAquaMarine		= UIColor(hex: 0x66CDAA)
		
		/// SwifterSwift: hex #0000CD
		public static let mediumBlue			= UIColor(hex: 0x0000CD)
		
		/// SwifterSwift: hex #BA55D3
		public static let mediumOrchid			= UIColor(hex: 0xBA55D3)
		
		/// SwifterSwift: hex #9370DB
		public static let mediumPurple			= UIColor(hex: 0x9370DB)
		
		/// SwifterSwift: hex #3CB371
		public static let mediumSeaGreen		= UIColor(hex: 0x3CB371)
		
		/// SwifterSwift: hex #7B68EE
		public static let mediumSlateBlue		= UIColor(hex: 0x7B68EE)
		
		/// SwifterSwift: hex #00FA9A
		public static let mediumSpringGreen		= UIColor(hex: 0x00FA9A)
		
		/// SwifterSwift: hex #48D1CC
		public static let mediumTurquoise		= UIColor(hex: 0x48D1CC)
		
		/// SwifterSwift: hex #C71585
		public static let mediumVioletRed		= UIColor(hex: 0xC71585)
		
		/// SwifterSwift: hex #191970
		public static let midnightBlue			= UIColor(hex: 0x191970)
		
		/// SwifterSwift: hex #F5FFFA
		public static let mintCream				= UIColor(hex: 0xF5FFFA)
		
		/// SwifterSwift: hex #FFE4E1
		public static let mistyRose				= UIColor(hex: 0xFFE4E1)
		
		/// SwifterSwift: hex #FFE4B5
		public static let moccasin				= UIColor(hex: 0xFFE4B5)
		
		/// SwifterSwift: hex #FFDEAD
		public static let navajoWhite			= UIColor(hex: 0xFFDEAD)
		
		/// SwifterSwift: hex #000080
		public static let navy					= UIColor(hex: 0x000080)
		
		/// SwifterSwift: hex #FDF5E6
		public static let oldLace				= UIColor(hex: 0xFDF5E6)
		
		/// SwifterSwift: hex #808000
		public static let olive					= UIColor(hex: 0x808000)
		
		/// SwifterSwift: hex #6B8E23
		public static let oliveDrab				= UIColor(hex: 0x6B8E23)
		
		/// SwifterSwift: hex #FFA500
		public static let orange				= UIColor(hex: 0xFFA500)
		
		/// SwifterSwift: hex #FF4500
		public static let orangeRed				= UIColor(hex: 0xFF4500)
		
		/// SwifterSwift: hex #DA70D6
		public static let orchid				= UIColor(hex: 0xDA70D6)
		
		/// SwifterSwift: hex #EEE8AA
		public static let paleGoldenRod			= UIColor(hex: 0xEEE8AA)
		
		/// SwifterSwift: hex #98FB98
		public static let paleGreen				= UIColor(hex: 0x98FB98)
		
		/// SwifterSwift: hex #AFEEEE
		public static let paleTurquoise			= UIColor(hex: 0xAFEEEE)
		
		/// SwifterSwift: hex #DB7093
		public static let paleVioletRed			= UIColor(hex: 0xDB7093)
		
		/// SwifterSwift: hex #FFEFD5
		public static let papayaWhip			= UIColor(hex: 0xFFEFD5)
		
		/// SwifterSwift: hex #FFDAB9
		public static let peachPuff				= UIColor(hex: 0xFFDAB9)
		
		/// SwifterSwift: hex #CD853F
		public static let peru					= UIColor(hex: 0xCD853F)
		
		/// SwifterSwift: hex #FFC0CB
		public static let pink					= UIColor(hex: 0xFFC0CB)
		
		/// SwifterSwift: hex #DDA0DD
		public static let plum					= UIColor(hex: 0xDDA0DD)
		
		/// SwifterSwift: hex #B0E0E6
		public static let powderBlue			= UIColor(hex: 0xB0E0E6)
		
		/// SwifterSwift: hex #800080
		public static let purple				= UIColor(hex: 0x800080)
		
		/// SwifterSwift: hex #663399
		public static let rebeccaPurple			= UIColor(hex: 0x663399)
		
		/// SwifterSwift: hex #FF0000
		public static let red					= UIColor(hex: 0xFF0000)
		
		/// SwifterSwift: hex #BC8F8F
		public static let rosyBrown				= UIColor(hex: 0xBC8F8F)
		
		/// SwifterSwift: hex #4169E1
		public static let royalBlue				= UIColor(hex: 0x4169E1)
		
		/// SwifterSwift: hex #8B4513
		public static let saddleBrown			= UIColor(hex: 0x8B4513)
		
		/// SwifterSwift: hex #FA8072
		public static let salmon				= UIColor(hex: 0xFA8072)
		
		/// SwifterSwift: hex #F4A460
		public static let sandyBrown			= UIColor(hex: 0xF4A460)
		
		/// SwifterSwift: hex #2E8B57
		public static let seaGreen				= UIColor(hex: 0x2E8B57)
		
		/// SwifterSwift: hex #FFF5EE
		public static let seaShell				= UIColor(hex: 0xFFF5EE)
		
		/// SwifterSwift: hex #A0522D
		public static let sienna				= UIColor(hex: 0xA0522D)
		
		/// SwifterSwift: hex #C0C0C0
		public static let silver				= UIColor(hex: 0xC0C0C0)
		
		/// SwifterSwift: hex #87CEEB
		public static let skyBlue				= UIColor(hex: 0x87CEEB)
		
		/// SwifterSwift: hex #6A5ACD
		public static let slateBlue				= UIColor(hex: 0x6A5ACD)
		
		/// SwifterSwift: hex #708090
		public static let slateGray				= UIColor(hex: 0x708090)
		
		/// SwifterSwift: hex #708090
		public static let slateGrey				= UIColor(hex: 0x708090)
		
		/// SwifterSwift: hex #FFFAFA
		public static let snow					= UIColor(hex: 0xFFFAFA)
		
		/// SwifterSwift: hex #00FF7F
		public static let springGreen			= UIColor(hex: 0x00FF7F)
		
		/// SwifterSwift: hex #4682B4
		public static let steelBlue				= UIColor(hex: 0x4682B4)
		
		/// SwifterSwift: hex #D2B48C
		public static let tan					= UIColor(hex: 0xD2B48C)
		
		/// SwifterSwift: hex #008080
		public static let teal					= UIColor(hex: 0x008080)
		
		/// SwifterSwift: hex #D8BFD8
		public static let thistle				= UIColor(hex: 0xD8BFD8)
		
		/// SwifterSwift: hex #FF6347
		public static let tomato				= UIColor(hex: 0xFF6347)
		
		/// SwifterSwift: hex #40E0D0
		public static let turquoise				= UIColor(hex: 0x40E0D0)
		
		/// SwifterSwift: hex #EE82EE
		public static let violet				= UIColor(hex: 0xEE82EE)
		
		/// SwifterSwift: hex #F5DEB3
		public static let wheat					= UIColor(hex: 0xF5DEB3)
		
		/// SwifterSwift: hex #FFFFFF
		public static let white					= UIColor(hex: 0xFFFFFF)
		
		/// SwifterSwift: hex #F5F5F5
		public static let whiteSmoke			= UIColor(hex: 0xF5F5F5)
		
		/// SwifterSwift: hex #FFFF00
		public static let yellow				= UIColor(hex: 0xFFFF00)
		
		/// SwifterSwift: hex #9ACD32
		public static let yellowGreen			= UIColor(hex: 0x9ACD32)
		
	}
	
}
#endif
