//: [Table of Contents](00ToC)

//: [Previous](@previous)

import SwifterSwift

//: ## UIKit extensions

//: ### UIAlertController extensions

// Create a new alert controller from string or Error
let alert = UIAlertController(title: "Couldn't sign in", message: "Invalid username or password!")

// show alert with ease
alert.show()

//: ### UIBarButtonItem extensions

//: ### UIButton extensions

let button = UIButton()

// Set title, title color and image for all states at once!
button.setTitleForAllStates("Login")
button.setTitleColorForAllStates(UIColor.blue)
button.setImageForAllStates(UIImage(named: "login")!)

// or set each of them from code or storyboard
button.titleForHighlighted = "Login"

//: ### UICollectionView extensions

//: ### UIDatePicker extensions

//: ### UIFont extensions

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

var image1 = UIImage(named: "logo")!

// Crop images
let croppedImage = image1.cropped(to: CGRect(x: 0, y: 0, width: 100, height: 100))

// Create UIImage from color
let image2 = UIImage(color: UIColor.red, size: CGSize(width: 100, height: 100))

// scale to fit width or height
let scaledImage1 = image2.scaled(toHeight: 50)
let scaledImage2 = image2.scaled(toWidth: 50)

// Compress images
let compressedImage = image2.compressed(quality: 0.3)

// get image size
image2.kilobytesSize

//: ### UIImageView extensions

let imageView = UIImageView()

// Download an image from URL in background
imageView.download(from: URL(string: "https://camo.githubusercontent.com/5d919daa24d2e934b11f2155f21a0f86fbf3abba/68747470733a2f2f63646e2e7261776769742e636f6d2f5377696674657253776966742f5377696674657253776966742f6d61737465722f4173736574732f6c6f676f2e737667")!, contentMode: .scaleAspectFit, placeholder: image1, completionHandler: nil)

// Blur image view
imageView.blur(withStyle: .light)

//: ### UILabel extensions

//: ### UINavigationBar extensions

let navbar = UINavigationBar()

// Change navigation bar font and color

navbar.setTitleFont(UIFont.systemFont(ofSize: 10), color: UIColor.black)

//: ### UINavigationController extensions

let navController = UINavigationController()

// Pop ViewController with completion handler.
navController.popViewController(animated: true, nil)

// Push ViewController with completion handler.
navController.pushViewController(UIViewController(), completion: nil)

//: ### UINavigationItem extensions

//: ### UISearchBar extensions

//: ### UISegmentedControl extensions

//: ### UISlider extensions

//: ### UIStackView extensions

//: ### UIStoryboard extensions

//: ### UISwitch extensions

//: ### UITabBar extensions

//: ### UITableView extensions

let tableView = UITableView()

// Return index path for last row in section.
tableView.indexPathForLastRow(inSection: 2)

// Scroll to bottom or top of TableView.
tableView.scrollToBottom(animated: true)
tableView.scrollToTop(animated: true)

//: ### UITextField extensions

//: ### UITextView extensions

//: ### UIViewController extensions

//: ### UIView extensions

// Set borderColor, borderWidth, cornerRadius, shadowColor, and many other properties from code or storyboard

var view = UIView()

view.cornerRadius = 30

// Set some or all corners radiuses of view.
view.roundCorners([.bottomLeft, .topRight], radius: 30)


// Add shadow to view
view.addShadow(ofColor: .black, radius: 3, opacity: 0.5)

// Animate view with completion
view.fadeIn(duration: 1, completion: nil)
view.fadeOut(duration: 1, completion: nil)
view.rotate(byAngle: 90, ofType: .degrees, animated: true, duration: 1, completion: { _ in print("done") })
view.rotate(toAngle: -3, ofType: .radians, animated: false, duration: 1, completion: nil)
view.scale(by: CGPoint(x: 4, y: 4), animated: true, duration: 1, completion: nil)
view.shake(direction: .horizontal, duration: 1, animationType: .easeOut)

// save screenshot of a view
let image = view.screenshot

//: ### UIWindow extensions

//: [Next](@next)
