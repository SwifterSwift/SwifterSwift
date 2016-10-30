Pod::Spec.new do |spec|
  spec.name = "SwifterSwift"
  spec.version = "1.2.1"
  spec.summary = "A handy collection of more than 290 native Swift 3 extensions to boost your productivity."
  spec.description = <<-DESC
  Swifter Swift is a library of over 280 properties and methods, designed to extend Swift's functionality and productivity, staying faithful to the original design guidelines of swift 3

  List Of Extensions
    - Array extensions
    - Character extensions
    - Convenience extensions
    - Date extensions
    - Dictionary extensions
    - Double extensions
    - Float extensions
    - Int extensions
    - String extensions
    - CGFloat extensions
    - CGSize extensions
    - UIAlertController extensions
    - UIButton extensions
    - UIColor extensions
    - UIImage extensions
    - UIImageView extensions
    - UINavigationBar extensions
    - UINavigationController extensions
    - UINavigationItem extensions
    - UISearchBar extensions
    - UISegmentedControl extensions
    - UISlider extensions
    - UILabel extensions
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
