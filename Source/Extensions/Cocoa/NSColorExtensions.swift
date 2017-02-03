//
//  NSColorExtensions.swift
//  SwifterSwift
//
//  Created by Omar Albeik on 03/02/2017.
//  Copyright © 2017 omaralbeik. All rights reserved.
//

#if os(macOS)
import Cocoa


public extension NSColor {
	
	/// SwifterSwift: Create NSColor from hexadecimal value with optional transparency.
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
	
	/// SwifterSwift: Create NSColor from hexadecimal string with optional transparency (if applicable).
	///
	/// - Parameters:
	///   - hexString: hexadecimal string (examples: EDE7F6, 0xEDE7F6, #EDE7F6, #0ff, 0xF0F, ..).
	///   - transparency: optional transparency value (default is 1).
	public convenience init?(hexString: String, transparency: CGFloat = 1) {
		var string = ""
		if hexString.lowercased().start(with: "0x") {
			string =  hexString.replacing("0x", with: "")
		} else if hexString.start(with: "#") {
			string = hexString.replacing("#", with: "")
		} else {
			string = hexString
		}
		
		if string.characters.count == 3 { // convert hex to 6 digit format if in short format
			var str = ""
			string.characters.forEach({ str.append($0 * 2) })
			string = str
		}
		
		guard let hexValue = Int(string, radix: 16) else {
			return nil
		}
		
		self.init(hex: Int(hexValue), transparency: transparency)
	}
	
	/// SwifterSwift: Create NSColor from RGB values with optional transparency.
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
	
}



//MARK: - Social Colors
public extension NSColor {
	
	/// SwifterSwift: Brand identity color of popular social media platform.
	public struct social {
		// https://www.lockedowndesign.com/social-media-colors/
		public static let facebook = NSColor(red: 59, green: 89, blue: 152)
		public static let twitter = NSColor(red: 0, green: 182, blue: 241)
		public static let googlePlus = NSColor(red: 223, green: 74, blue: 50)
		public static let linkedIn = NSColor(red: 0, green: 123, blue: 182)
		public static let vimeo = NSColor(red: 69, green: 187, blue: 255)
		public static let youtube = NSColor(red: 179, green: 18, blue: 23)
		public static let instagram = NSColor(red: 195, green: 42, blue: 163)
		public static let pinterest = NSColor(red: 203, green: 32, blue: 39)
		public static let flickr = NSColor(red: 244, green: 0, blue: 131)
		public static let yahoo = NSColor(red: 67, green: 2, blue: 151)
		public static let soundCloud = NSColor(red: 255, green: 85, blue: 0)
		public static let tumblr = NSColor(red: 44, green: 71, blue: 98)
		public static let foursquare = NSColor(red: 252, green: 69, blue: 117)
		public static let swarm = NSColor(red: 255, green: 176, blue: 0)
		public static let dribbble = NSColor(red: 234, green: 76, blue: 137)
		public static let reddit = NSColor(red: 255, green: 87, blue: 0)
		public static let devianArt = NSColor(red: 74, green: 93, blue: 78)
		public static let pocket = NSColor(red: 238, green: 64, blue: 86)
		public static let quora = NSColor(red: 170, green: 34, blue: 182)
		public static let slideShare = NSColor(red: 247, green: 146, blue: 30)
		public static let px500 = NSColor(red: 0, green: 153, blue: 229)
		public static let listly = NSColor(red: 223, green: 109, blue: 70)
		public static let vine = NSColor(red: 0, green: 180, blue: 137)
		public static let skype = NSColor(red: 0, green: 175, blue: 240)
		public static let stumbleUpon = NSColor(red: 235, green: 73, blue: 36)
		public static let snapchat = NSColor(red: 255, green: 252, blue: 0)
	}
}


//MARK: - Material colors
public extension NSColor {
	
	/// SwifterSwift: Google Material design colors palette.
	public struct material {
		// https://material.google.com/style/color.html
		
		public static let red					= red500
		public static let red50					= NSColor(hex: 0xFFEBEE)
		public static let red100				= NSColor(hex: 0xFFCDD2)
		public static let red200				= NSColor(hex: 0xEF9A9A)
		public static let red300				= NSColor(hex: 0xE57373)
		public static let red400				= NSColor(hex: 0xEF5350)
		public static let red500				= NSColor(hex: 0xF44336)
		public static let red600				= NSColor(hex: 0xE53935)
		public static let red700				= NSColor(hex: 0xD32F2F)
		public static let red800				= NSColor(hex: 0xC62828)
		public static let red900				= NSColor(hex: 0xB71C1C)
		public static let redA100				= NSColor(hex: 0xFF8A80)
		public static let redA200				= NSColor(hex: 0xFF5252)
		public static let redA400				= NSColor(hex: 0xFF1744)
		public static let redA700				= NSColor(hex: 0xD50000)
		
		public static let pink					= pink500
		public static let pink50				= NSColor(hex: 0xFCE4EC)
		public static let pink100				= NSColor(hex: 0xF8BBD0)
		public static let pink200				= NSColor(hex: 0xF48FB1)
		public static let pink300				= NSColor(hex: 0xF06292)
		public static let pink400				= NSColor(hex: 0xEC407A)
		public static let pink500				= NSColor(hex: 0xE91E63)
		public static let pink600				= NSColor(hex: 0xD81B60)
		public static let pink700				= NSColor(hex: 0xC2185B)
		public static let pink800				= NSColor(hex: 0xAD1457)
		public static let pink900				= NSColor(hex: 0x880E4F)
		public static let pinkA100				= NSColor(hex: 0xFF80AB)
		public static let pinkA200				= NSColor(hex: 0xFF4081)
		public static let pinkA400				= NSColor(hex: 0xF50057)
		public static let pinkA700				= NSColor(hex: 0xC51162)
		
		public static let purple				= purple500
		public static let purple50				= NSColor(hex: 0xF3E5F5)
		public static let purple100				= NSColor(hex: 0xE1BEE7)
		public static let purple200				= NSColor(hex: 0xCE93D8)
		public static let purple300				= NSColor(hex: 0xBA68C8)
		public static let purple400				= NSColor(hex: 0xAB47BC)
		public static let purple500				= NSColor(hex: 0x9C27B0)
		public static let purple600				= NSColor(hex: 0x8E24AA)
		public static let purple700				= NSColor(hex: 0x7B1FA2)
		public static let purple800				= NSColor(hex: 0x6A1B9A)
		public static let purple900				= NSColor(hex: 0x4A148C)
		public static let purpleA100			= NSColor(hex: 0xEA80FC)
		public static let purpleA200			= NSColor(hex: 0xE040FB)
		public static let purpleA400			= NSColor(hex: 0xD500F9)
		public static let purpleA700			= NSColor(hex: 0xAA00FF)
		
		public static let deepPurple			= deepPurple500
		public static let deepPurple50			= NSColor(hex: 0xEDE7F6)
		public static let deepPurple100			= NSColor(hex: 0xD1C4E9)
		public static let deepPurple200			= NSColor(hex: 0xB39DDB)
		public static let deepPurple300			= NSColor(hex: 0x9575CD)
		public static let deepPurple400			= NSColor(hex: 0x7E57C2)
		public static let deepPurple500			= NSColor(hex: 0x673AB7)
		public static let deepPurple600			= NSColor(hex: 0x5E35B1)
		public static let deepPurple700			= NSColor(hex: 0x512DA8)
		public static let deepPurple800			= NSColor(hex: 0x4527A0)
		public static let deepPurple900			= NSColor(hex: 0x311B92)
		public static let deepPurpleA100		= NSColor(hex: 0xB388FF)
		public static let deepPurpleA200		= NSColor(hex: 0x7C4DFF)
		public static let deepPurpleA400		= NSColor(hex: 0x651FFF)
		public static let deepPurpleA700		= NSColor(hex: 0x6200EA)
		
		public static let indigo				= indigo500
		public static let indigo50				= NSColor(hex: 0xE8EAF6)
		public static let indigo100				= NSColor(hex: 0xC5CAE9)
		public static let indigo200				= NSColor(hex: 0x9FA8DA)
		public static let indigo300				= NSColor(hex: 0x7986CB)
		public static let indigo400				= NSColor(hex: 0x5C6BC0)
		public static let indigo500				= NSColor(hex: 0x3F51B5)
		public static let indigo600				= NSColor(hex: 0x3949AB)
		public static let indigo700				= NSColor(hex: 0x303F9F)
		public static let indigo800				= NSColor(hex: 0x283593)
		public static let indigo900				= NSColor(hex: 0x1A237E)
		public static let indigoA100			= NSColor(hex: 0x8C9EFF)
		public static let indigoA200			= NSColor(hex: 0x536DFE)
		public static let indigoA400			= NSColor(hex: 0x3D5AFE)
		public static let indigoA700			= NSColor(hex: 0x304FFE)
		
		public static let blue					= blue500
		public static let blue50				= NSColor(hex: 0xE3F2FD)
		public static let blue100				= NSColor(hex: 0xBBDEFB)
		public static let blue200				= NSColor(hex: 0x90CAF9)
		public static let blue300				= NSColor(hex: 0x64B5F6)
		public static let blue400				= NSColor(hex: 0x42A5F5)
		public static let blue500				= NSColor(hex: 0x2196F3)
		public static let blue600				= NSColor(hex: 0x1E88E5)
		public static let blue700				= NSColor(hex: 0x1976D2)
		public static let blue800				= NSColor(hex: 0x1565C0)
		public static let blue900				= NSColor(hex: 0x0D47A1)
		public static let blueA100				= NSColor(hex: 0x82B1FF)
		public static let blueA200				= NSColor(hex: 0x448AFF)
		public static let blueA400				= NSColor(hex: 0x2979FF)
		public static let blueA700				= NSColor(hex: 0x2962FF)
		
		public static let lightBlue				= lightBlue500
		public static let lightBlue50			= NSColor(hex: 0xE1F5FE)
		public static let lightBlue100			= NSColor(hex: 0xB3E5FC)
		public static let lightBlue200			= NSColor(hex: 0x81D4FA)
		public static let lightBlue300			= NSColor(hex: 0x4FC3F7)
		public static let lightBlue400			= NSColor(hex: 0x29B6F6)
		public static let lightBlue500			= NSColor(hex: 0x03A9F4)
		public static let lightBlue600			= NSColor(hex: 0x039BE5)
		public static let lightBlue700			= NSColor(hex: 0x0288D1)
		public static let lightBlue800			= NSColor(hex: 0x0277BD)
		public static let lightBlue900			= NSColor(hex: 0x01579B)
		public static let lightBlueA100			= NSColor(hex: 0x80D8FF)
		public static let lightBlueA200			= NSColor(hex: 0x40C4FF)
		public static let lightBlueA400			= NSColor(hex: 0x00B0FF)
		public static let lightBlueA700			= NSColor(hex: 0x0091EA)
		
		public static let cyan					= cyan500
		public static let cyan50				= NSColor(hex: 0xE0F7FA)
		public static let cyan100				= NSColor(hex: 0xB2EBF2)
		public static let cyan200				= NSColor(hex: 0x80DEEA)
		public static let cyan300				= NSColor(hex: 0x4DD0E1)
		public static let cyan400				= NSColor(hex: 0x26C6DA)
		public static let cyan500				= NSColor(hex: 0x00BCD4)
		public static let cyan600				= NSColor(hex: 0x00ACC1)
		public static let cyan700				= NSColor(hex: 0x0097A7)
		public static let cyan800				= NSColor(hex: 0x00838F)
		public static let cyan900				= NSColor(hex: 0x006064)
		public static let cyanA100				= NSColor(hex: 0x84FFFF)
		public static let cyanA200				= NSColor(hex: 0x18FFFF)
		public static let cyanA400				= NSColor(hex: 0x00E5FF)
		public static let cyanA700				= NSColor(hex: 0x00B8D4)
		
		public static let teal					= teal500
		public static let teal50				= NSColor(hex: 0xE0F2F1)
		public static let teal100				= NSColor(hex: 0xB2DFDB)
		public static let teal200				= NSColor(hex: 0x80CBC4)
		public static let teal300				= NSColor(hex: 0x4DB6AC)
		public static let teal400				= NSColor(hex: 0x26A69A)
		public static let teal500				= NSColor(hex: 0x009688)
		public static let teal600				= NSColor(hex: 0x00897B)
		public static let teal700				= NSColor(hex: 0x00796B)
		public static let teal800				= NSColor(hex: 0x00695C)
		public static let teal900				= NSColor(hex: 0x004D40)
		public static let tealA100				= NSColor(hex: 0xA7FFEB)
		public static let tealA200				= NSColor(hex: 0x64FFDA)
		public static let tealA400				= NSColor(hex: 0x1DE9B6)
		public static let tealA700				= NSColor(hex: 0x00BFA5)
		
		public static let green					= green500
		public static let green50				= NSColor(hex: 0xE8F5E9)
		public static let green100				= NSColor(hex: 0xC8E6C9)
		public static let green200				= NSColor(hex: 0xA5D6A7)
		public static let green300				= NSColor(hex: 0x81C784)
		public static let green400				= NSColor(hex: 0x66BB6A)
		public static let green500				= NSColor(hex: 0x4CAF50)
		public static let green600				= NSColor(hex: 0x43A047)
		public static let green700				= NSColor(hex: 0x388E3C)
		public static let green800				= NSColor(hex: 0x2E7D32)
		public static let green900				= NSColor(hex: 0x1B5E20)
		public static let greenA100				= NSColor(hex: 0xB9F6CA)
		public static let greenA200				= NSColor(hex: 0x69F0AE)
		public static let greenA400				= NSColor(hex: 0x00E676)
		public static let greenA700				= NSColor(hex: 0x00C853)
		
		public static let lightGreen			= lightGreen500
		public static let lightGreen50			= NSColor(hex: 0xF1F8E9)
		public static let lightGreen100			= NSColor(hex: 0xDCEDC8)
		public static let lightGreen200			= NSColor(hex: 0xC5E1A5)
		public static let lightGreen300			= NSColor(hex: 0xAED581)
		public static let lightGreen400			= NSColor(hex: 0x9CCC65)
		public static let lightGreen500			= NSColor(hex: 0x8BC34A)
		public static let lightGreen600			= NSColor(hex: 0x7CB342)
		public static let lightGreen700			= NSColor(hex: 0x689F38)
		public static let lightGreen800			= NSColor(hex: 0x558B2F)
		public static let lightGreen900			= NSColor(hex: 0x33691E)
		public static let lightGreenA100		= NSColor(hex: 0xCCFF90)
		public static let lightGreenA200		= NSColor(hex: 0xB2FF59)
		public static let lightGreenA400		= NSColor(hex: 0x76FF03)
		public static let lightGreenA700		= NSColor(hex: 0x64DD17)
		
		public static let lime					= lime500
		public static let lime50				= NSColor(hex: 0xF9FBE7)
		public static let lime100				= NSColor(hex: 0xF0F4C3)
		public static let lime200				= NSColor(hex: 0xE6EE9C)
		public static let lime300				= NSColor(hex: 0xDCE775)
		public static let lime400				= NSColor(hex: 0xD4E157)
		public static let lime500				= NSColor(hex: 0xCDDC39)
		public static let lime600				= NSColor(hex: 0xC0CA33)
		public static let lime700				= NSColor(hex: 0xAFB42B)
		public static let lime800				= NSColor(hex: 0x9E9D24)
		public static let lime900				= NSColor(hex: 0x827717)
		public static let limeA100				= NSColor(hex: 0xF4FF81)
		public static let limeA200				= NSColor(hex: 0xEEFF41)
		public static let limeA400				= NSColor(hex: 0xC6FF00)
		public static let limeA700				= NSColor(hex: 0xAEEA00)
		
		public static let yellow				= yellow500
		public static let yellow50				= NSColor(hex: 0xFFFDE7)
		public static let yellow100				= NSColor(hex: 0xFFF9C4)
		public static let yellow200				= NSColor(hex: 0xFFF59D)
		public static let yellow300				= NSColor(hex: 0xFFF176)
		public static let yellow400				= NSColor(hex: 0xFFEE58)
		public static let yellow500				= NSColor(hex: 0xFFEB3B)
		public static let yellow600				= NSColor(hex: 0xFDD835)
		public static let yellow700				= NSColor(hex: 0xFBC02D)
		public static let yellow800				= NSColor(hex: 0xF9A825)
		public static let yellow900				= NSColor(hex: 0xF57F17)
		public static let yellowA100			= NSColor(hex: 0xFFFF8D)
		public static let yellowA200			= NSColor(hex: 0xFFFF00)
		public static let yellowA400			= NSColor(hex: 0xFFEA00)
		public static let yellowA700			= NSColor(hex: 0xFFD600)
		
		public static let amber					= amber500
		public static let amber50				= NSColor(hex: 0xFFF8E1)
		public static let amber100				= NSColor(hex: 0xFFECB3)
		public static let amber200				= NSColor(hex: 0xFFE082)
		public static let amber300				= NSColor(hex: 0xFFD54F)
		public static let amber400				= NSColor(hex: 0xFFCA28)
		public static let amber500				= NSColor(hex: 0xFFC107)
		public static let amber600				= NSColor(hex: 0xFFB300)
		public static let amber700				= NSColor(hex: 0xFFA000)
		public static let amber800				= NSColor(hex: 0xFF8F00)
		public static let amber900				= NSColor(hex: 0xFF6F00)
		public static let amberA100				= NSColor(hex: 0xFFE57F)
		public static let amberA200				= NSColor(hex: 0xFFD740)
		public static let amberA400				= NSColor(hex: 0xFFC400)
		public static let amberA700				= NSColor(hex: 0xFFAB00)
		
		public static let orange				= orange500
		public static let orange50				= NSColor(hex: 0xFFF3E0)
		public static let orange100				= NSColor(hex: 0xFFE0B2)
		public static let orange200				= NSColor(hex: 0xFFCC80)
		public static let orange300				= NSColor(hex: 0xFFB74D)
		public static let orange400				= NSColor(hex: 0xFFA726)
		public static let orange500				= NSColor(hex: 0xFF9800)
		public static let orange600				= NSColor(hex: 0xFB8C00)
		public static let orange700				= NSColor(hex: 0xF57C00)
		public static let orange800				= NSColor(hex: 0xEF6C00)
		public static let orange900				= NSColor(hex: 0xE65100)
		public static let orangeA100			= NSColor(hex: 0xFFD180)
		public static let orangeA200			= NSColor(hex: 0xFFAB40)
		public static let orangeA400			= NSColor(hex: 0xFF9100)
		public static let orangeA700			= NSColor(hex: 0xFF6D00)
		
		public static let deepOrange			= deepOrange500
		public static let deepOrange50			= NSColor(hex: 0xFBE9E7)
		public static let deepOrange100			= NSColor(hex: 0xFFCCBC)
		public static let deepOrange200			= NSColor(hex: 0xFFAB91)
		public static let deepOrange300			= NSColor(hex: 0xFF8A65)
		public static let deepOrange400			= NSColor(hex: 0xFF7043)
		public static let deepOrange500			= NSColor(hex: 0xFF5722)
		public static let deepOrange600			= NSColor(hex: 0xF4511E)
		public static let deepOrange700			= NSColor(hex: 0xE64A19)
		public static let deepOrange800			= NSColor(hex: 0xD84315)
		public static let deepOrange900			= NSColor(hex: 0xBF360C)
		public static let deepOrangeA100		= NSColor(hex: 0xFF9E80)
		public static let deepOrangeA200		= NSColor(hex: 0xFF6E40)
		public static let deepOrangeA400		= NSColor(hex: 0xFF3D00)
		public static let deepOrangeA700		= NSColor(hex: 0xDD2C00)
		
		public static let brown					= brown500
		public static let brown50				= NSColor(hex: 0xEFEBE9)
		public static let brown100				= NSColor(hex: 0xD7CCC8)
		public static let brown200				= NSColor(hex: 0xBCAAA4)
		public static let brown300				= NSColor(hex: 0xA1887F)
		public static let brown400				= NSColor(hex: 0x8D6E63)
		public static let brown500				= NSColor(hex: 0x795548)
		public static let brown600				= NSColor(hex: 0x6D4C41)
		public static let brown700				= NSColor(hex: 0x5D4037)
		public static let brown800				= NSColor(hex: 0x4E342E)
		public static let brown900				= NSColor(hex: 0x3E2723)
		
		public static let grey					= grey500
		public static let grey50				= NSColor(hex: 0xFAFAFA)
		public static let grey100				= NSColor(hex: 0xF5F5F5)
		public static let grey200				= NSColor(hex: 0xEEEEEE)
		public static let grey300				= NSColor(hex: 0xE0E0E0)
		public static let grey400				= NSColor(hex: 0xBDBDBD)
		public static let grey500				= NSColor(hex: 0x9E9E9E)
		public static let grey600				= NSColor(hex: 0x757575)
		public static let grey700				= NSColor(hex: 0x616161)
		public static let grey800				= NSColor(hex: 0x424242)
		public static let grey900				= NSColor(hex: 0x212121)
		
		public static let blueGrey				= blueGrey500
		public static let blueGrey50			= NSColor(hex: 0xECEFF1)
		public static let blueGrey100			= NSColor(hex: 0xCFD8DC)
		public static let blueGrey200			= NSColor(hex: 0xB0BEC5)
		public static let blueGrey300			= NSColor(hex: 0x90A4AE)
		public static let blueGrey400			= NSColor(hex: 0x78909C)
		public static let blueGrey500			= NSColor(hex: 0x607D8B)
		public static let blueGrey600			= NSColor(hex: 0x546E7A)
		public static let blueGrey700			= NSColor(hex: 0x455A64)
		public static let blueGrey800			= NSColor(hex: 0x37474F)
		public static let blueGrey900			= NSColor(hex: 0x263238)
		
		public static let black					= NSColor(hex: 0x000000)
		public static let white					= NSColor(hex: 0xFFFFFF)
	}
	
}


public extension NSColor {
	
	/// SwifterSwift: CSS colors.
	public struct css {
		// http://www.w3schools.com/colors/colors_names.asp
		public static let aliceBlue				= NSColor(hex: 0xF0F8FF)
		public static let antiqueWhite			= NSColor(hex: 0xFAEBD7)
		public static let aqua					= NSColor(hex: 0x00FFFF)
		public static let aquamarine			= NSColor(hex: 0x7FFFD4)
		public static let azure					= NSColor(hex: 0xF0FFFF)
		public static let beige					= NSColor(hex: 0xF5F5DC)
		public static let bisque				= NSColor(hex: 0xFFE4C4)
		public static let black					= NSColor(hex: 0x000000)
		public static let blanchedAlmond		= NSColor(hex: 0xFFEBCD)
		public static let blue					= NSColor(hex: 0x0000FF)
		public static let blueViolet			= NSColor(hex: 0x8A2BE2)
		public static let brown					= NSColor(hex: 0xA52A2A)
		public static let burlyWood				= NSColor(hex: 0xDEB887)
		public static let cadetBlue				= NSColor(hex: 0x5F9EA0)
		public static let chartreuse			= NSColor(hex: 0x7FFF00)
		public static let chocolate				= NSColor(hex: 0xD2691E)
		public static let coral					= NSColor(hex: 0xFF7F50)
		public static let cornflowerBlue		= NSColor(hex: 0x6495ED)
		public static let cornsilk				= NSColor(hex: 0xFFF8DC)
		public static let crimson				= NSColor(hex: 0xDC143C)
		public static let cyan					= NSColor(hex: 0x00FFFF)
		public static let darkBlue				= NSColor(hex: 0x00008B)
		public static let darkCyan				= NSColor(hex: 0x008B8B)
		public static let darkGoldenRod			= NSColor(hex: 0xB8860B)
		public static let darkGray				= NSColor(hex: 0xA9A9A9)
		public static let darkGrey				= NSColor(hex: 0xA9A9A9)
		public static let darkGreen				= NSColor(hex: 0x006400)
		public static let darkKhaki				= NSColor(hex: 0xBDB76B)
		public static let darkMagenta			= NSColor(hex: 0x8B008B)
		public static let darkOliveGreen		= NSColor(hex: 0x556B2F)
		public static let darkOrange			= NSColor(hex: 0xFF8C00)
		public static let darkOrchid			= NSColor(hex: 0x9932CC)
		public static let darkRed				= NSColor(hex: 0x8B0000)
		public static let darkSalmon			= NSColor(hex: 0xE9967A)
		public static let darkSeaGreen			= NSColor(hex: 0x8FBC8F)
		public static let darkSlateBlue			= NSColor(hex: 0x483D8B)
		public static let darkSlateGray			= NSColor(hex: 0x2F4F4F)
		public static let darkSlateGrey			= NSColor(hex: 0x2F4F4F)
		public static let darkTurquoise			= NSColor(hex: 0x00CED1)
		public static let darkViolet			= NSColor(hex: 0x9400D3)
		public static let deepPink				= NSColor(hex: 0xFF1493)
		public static let deepSkyBlue			= NSColor(hex: 0x00BFFF)
		public static let dimGray				= NSColor(hex: 0x696969)
		public static let dimGrey				= NSColor(hex: 0x696969)
		public static let dodgerBlue			= NSColor(hex: 0x1E90FF)
		public static let fireBrick				= NSColor(hex: 0xB22222)
		public static let floralWhite			= NSColor(hex: 0xFFFAF0)
		public static let forestGreen			= NSColor(hex: 0x228B22)
		public static let fuchsia				= NSColor(hex: 0xFF00FF)
		public static let gainsboro				= NSColor(hex: 0xDCDCDC)
		public static let ghostWhite			= NSColor(hex: 0xF8F8FF)
		public static let gold					= NSColor(hex: 0xFFD700)
		public static let goldenRod				= NSColor(hex: 0xDAA520)
		public static let gray					= NSColor(hex: 0x808080)
		public static let grey					= NSColor(hex: 0x808080)
		public static let green					= NSColor(hex: 0x008000)
		public static let greenYellow			= NSColor(hex: 0xADFF2F)
		public static let honeyDew				= NSColor(hex: 0xF0FFF0)
		public static let hotPink				= NSColor(hex: 0xFF69B4)
		public static let indianRed				= NSColor(hex: 0xCD5C5C)
		public static let indigo				= NSColor(hex: 0x4B0082)
		public static let ivory					= NSColor(hex: 0xFFFFF0)
		public static let khaki					= NSColor(hex: 0xF0E68C)
		public static let lavender				= NSColor(hex: 0xE6E6FA)
		public static let lavenderBlush			= NSColor(hex: 0xFFF0F5)
		public static let lawnGreen				= NSColor(hex: 0x7CFC00)
		public static let lemonChiffon			= NSColor(hex: 0xFFFACD)
		public static let lightBlue				= NSColor(hex: 0xADD8E6)
		public static let lightCoral			= NSColor(hex: 0xF08080)
		public static let lightCyan				= NSColor(hex: 0xE0FFFF)
		public static let lightGoldenRodYellow	= NSColor(hex: 0xFAFAD2)
		public static let lightGray				= NSColor(hex: 0xD3D3D3)
		public static let lightGrey				= NSColor(hex: 0xD3D3D3)
		public static let lightGreen			= NSColor(hex: 0x90EE90)
		public static let lightPink				= NSColor(hex: 0xFFB6C1)
		public static let lightSalmon			= NSColor(hex: 0xFFA07A)
		public static let lightSeaGreen			= NSColor(hex: 0x20B2AA)
		public static let lightSkyBlue			= NSColor(hex: 0x87CEFA)
		public static let lightSlateGray		= NSColor(hex: 0x778899)
		public static let lightSlateGrey		= NSColor(hex: 0x778899)
		public static let lightSteelBlue		= NSColor(hex: 0xB0C4DE)
		public static let lightYellow			= NSColor(hex: 0xFFFFE0)
		public static let lime					= NSColor(hex: 0x00FF00)
		public static let limeGreen				= NSColor(hex: 0x32CD32)
		public static let linen					= NSColor(hex: 0xFAF0E6)
		public static let magenta				= NSColor(hex: 0xFF00FF)
		public static let maroon				= NSColor(hex: 0x800000)
		public static let mediumAquaMarine		= NSColor(hex: 0x66CDAA)
		public static let mediumBlue			= NSColor(hex: 0x0000CD)
		public static let mediumOrchid			= NSColor(hex: 0xBA55D3)
		public static let mediumPurple			= NSColor(hex: 0x9370DB)
		public static let mediumSeaGreen		= NSColor(hex: 0x3CB371)
		public static let mediumSlateBlue		= NSColor(hex: 0x7B68EE)
		public static let mediumSpringGreen		= NSColor(hex: 0x00FA9A)
		public static let mediumTurquoise		= NSColor(hex: 0x48D1CC)
		public static let mediumVioletRed		= NSColor(hex: 0xC71585)
		public static let midnightBlue			= NSColor(hex: 0x191970)
		public static let mintCream				= NSColor(hex: 0xF5FFFA)
		public static let mistyRose				= NSColor(hex: 0xFFE4E1)
		public static let moccasin				= NSColor(hex: 0xFFE4B5)
		public static let navajoWhite			= NSColor(hex: 0xFFDEAD)
		public static let navy					= NSColor(hex: 0x000080)
		public static let oldLace				= NSColor(hex: 0xFDF5E6)
		public static let olive					= NSColor(hex: 0x808000)
		public static let oliveDrab				= NSColor(hex: 0x6B8E23)
		public static let orange				= NSColor(hex: 0xFFA500)
		public static let orangeRed				= NSColor(hex: 0xFF4500)
		public static let orchid				= NSColor(hex: 0xDA70D6)
		public static let paleGoldenRod			= NSColor(hex: 0xEEE8AA)
		public static let paleGreen				= NSColor(hex: 0x98FB98)
		public static let paleTurquoise			= NSColor(hex: 0xAFEEEE)
		public static let paleVioletRed			= NSColor(hex: 0xDB7093)
		public static let papayaWhip			= NSColor(hex: 0xFFEFD5)
		public static let peachPuff				= NSColor(hex: 0xFFDAB9)
		public static let peru					= NSColor(hex: 0xCD853F)
		public static let pink					= NSColor(hex: 0xFFC0CB)
		public static let plum					= NSColor(hex: 0xDDA0DD)
		public static let powderBlue			= NSColor(hex: 0xB0E0E6)
		public static let purple				= NSColor(hex: 0x800080)
		public static let rebeccaPurple			= NSColor(hex: 0x663399)
		public static let red					= NSColor(hex: 0xFF0000)
		public static let rosyBrown				= NSColor(hex: 0xBC8F8F)
		public static let royalBlue				= NSColor(hex: 0x4169E1)
		public static let saddleBrown			= NSColor(hex: 0x8B4513)
		public static let salmon				= NSColor(hex: 0xFA8072)
		public static let sandyBrown			= NSColor(hex: 0xF4A460)
		public static let seaGreen				= NSColor(hex: 0x2E8B57)
		public static let seaShell				= NSColor(hex: 0xFFF5EE)
		public static let sienna				= NSColor(hex: 0xA0522D)
		public static let silver				= NSColor(hex: 0xC0C0C0)
		public static let skyBlue				= NSColor(hex: 0x87CEEB)
		public static let slateBlue				= NSColor(hex: 0x6A5ACD)
		public static let slateGray				= NSColor(hex: 0x708090)
		public static let slateGrey				= NSColor(hex: 0x708090)
		public static let snow					= NSColor(hex: 0xFFFAFA)
		public static let springGreen			= NSColor(hex: 0x00FF7F)
		public static let steelBlue				= NSColor(hex: 0x4682B4)
		public static let tan					= NSColor(hex: 0xD2B48C)
		public static let teal					= NSColor(hex: 0x008080)
		public static let thistle				= NSColor(hex: 0xD8BFD8)
		public static let tomato				= NSColor(hex: 0xFF6347)
		public static let turquoise				= NSColor(hex: 0x40E0D0)
		public static let violet				= NSColor(hex: 0xEE82EE)
		public static let wheat					= NSColor(hex: 0xF5DEB3)
		public static let white					= NSColor(hex: 0xFFFFFF)
		public static let whiteSmoke			= NSColor(hex: 0xF5F5F5)
		public static let yellow				= NSColor(hex: 0xFFFF00)
		public static let yellowGreen			= NSColor(hex: 0x9ACD32)
		
	}
	
}
#endif
