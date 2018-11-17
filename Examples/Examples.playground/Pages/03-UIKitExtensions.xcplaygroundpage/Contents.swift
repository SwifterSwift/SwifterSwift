//: [Table of Contents](00-ToC)

//: [Previous](@previous)

import SwifterSwift
import PlaygroundSupport

//: ## UIKit extensions

//: ### UIButton extensions

let button = UIButton(frame: CGRect(x: 0, y: 0, width: 100, height: 40))

// Set title, title color and image for all states at once!
button.setTitleForAllStates("Login")
button.setTitleColorForAllStates(UIColor.blue)
button.setImageForAllStates(UIImage(named: "login")!)

//: ### UIColor extensions

// Create new UIColor for RGB values
let color1 = UIColor(red: 121, green: 220, blue: 164)

// Create new UIColor for a hex string (including strings starting with #, 0x or in short css hex format)
let color2 = UIColor(hexString: "#00F")

// Create new UIColor for a hexadecimal value
let color3 = UIColor(hex: 0x45C91B)

// Blend two colors with ease
UIColor.blend(UIColor.red, intensity1: 0.5, with: UIColor.green, intensity2: 0.3)

// Return hexadecimal value string
UIColor.red.hexString

// Use Google Material design colors with ease
let indigo = UIColor.Material.indigo

// Use CSS colors with ease:
let beige = UIColor.CSS.beige

// Return brand colors from more than 30 social brands
let facebookColor = UIColor.Social.facebook

//: ### UIImage extensions

let image1 = UIImage(named: "logo")!

// Crop images
let croppedImage = image1.cropped(to: CGRect(x: 0, y: 0, width: 100, height: 100))

// scale to fit width or height
let scaledImage1 = image1.scaled(toHeight: 50)
let scaledImage2 = image1.scaled(toWidth: 50)

// Compress images
let compressedImage = image1.compressed(quality: 0.3)

// get image size
image1.kilobytesSize

//: ### UIImageView extensions

let imageView = UIImageView()

// Download an image from URL in background
PlaygroundPage.current.needsIndefiniteExecution = true
imageView.download(from: URL(string: "https://developer.apple.com/swift/images/swift-og.png")!,
                   contentMode: .scaleAspectFit,
                   placeholder: image1,
                   completionHandler: { downloadedImage in
                    downloadedImage
                    PlaygroundPage.current.needsIndefiniteExecution = false

                    imageView.sizeToFit()

                    // Blur image view
                    imageView.blur(withStyle: .light)
})

//: ### UINavigationBar extensions

let navbar = UINavigationBar(frame: CGRect(x: 0, y: 0, width: 100, height: 60))
let navItem = UINavigationItem(title: "Title")
navbar.pushItem(navItem, animated: false)

// Change navigation bar font and color

navbar.setTitleFont(UIFont.systemFont(ofSize: 10), color: UIColor.red)

//: ### UIView extensions

// Set borderColor, borderWidth, cornerRadius, shadowColor, and many other properties from code or storyboard

var view = UIView(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
view.backgroundColor = UIColor.red

// Set some or all corners radiuses of view.
view.roundCorners([.bottomLeft, .topRight], radius: 30)
view.cornerRadius = 30

// Add shadow to view
view.addShadow(ofColor: .black, radius: 3, opacity: 0.5)

//: [Next](@next)
