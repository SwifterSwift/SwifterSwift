Pod::Spec.new do |spec|
  spec.name = "SwifterSwift"
  spec.version = "1.3.8"
  spec.summary = "A handy collection of more than 375 native Swift 3 extensions to boost your productivity."
  spec.description = <<-DESC
  SwifterSwift is a library of over 370 properties and methods for more than 36 types, designed to extend Swift's functionality and productivity, staying faithful to the original design guidelines of swift 3

  List Of Extensions
    - Array extensions
    - Bool extensions
    - Character extensions
    - Collection extensions
    - Data extensions
    - Date extensions
    - Dictionary extensions
    - Double extensions
    - Float extensions
    - Int extensions
    - String extensions
    - SwifterSwift
    - CGFloat extensions
    - CGPoint extensions
    - CGSize extensions
    - NSAttributedString extensions
    - UIAlertController extensions
    - UIBarButtonItem extensions
    - UIButton extensions
    - UICollectionView extensions
    - UIColor extensions
    - UIImage extensions
    - UIImageView extensions
    - UILabel extensions
    - UINavigationBar extensions
    - UINavigationController extensions
    - UINavigationItem extensions
    - UISearchBar extensions
    - UISegmentedControl extensions
    - UISlider extensions
    - UISwitch extensions
    - UITabBar extensions
    - UITableView extensions
    - UITextField extensions
    - UITextView extensions
    - UIView extensions
    - UIViewController extensions
                   DESC
  spec.homepage = "https://github.com/omaralbeik/SwifterSwift"
  spec.license = { type: 'MIT', file: 'LICENSE' }
  spec.authors = { "Omar Albeik" => 'omaralbeik@gmail.com' }
  spec.social_media_url = "http://twitter.com/omaralbeik"
  spec.screenshot  = 'https://raw.githubusercontent.com/omaralbeik/SwifterSwift/master/logo.png'

  spec.platform = :ios, "8.0"
  spec.ios.deployment_target = '8.0'
  spec.requires_arc = true
  spec.source = { git: "https://github.com/omaralbeik/SwifterSwift.git", tag: "v#{spec.version}" }
  spec.source_files = "SwifterSwift/SwifterSwift/Extensions/**/*.swift"
  spec.documentation_url = 'https://github.com/omaralbeik/SwifterSwift/wiki'
  spec.frameworks   = ['Foundation', 'UIKit']
end
