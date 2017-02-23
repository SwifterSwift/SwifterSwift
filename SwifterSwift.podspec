Pod::Spec.new do |s|
  s.name = "SwifterSwift"
  s.version = "1.6.2"
  s.summary = "A handy collection of more than 500 native Swift 3 extensions to boost your productivity."
  s.description = <<-DESC
  SwifterSwift is a collection of over 500 native Swift 3 extensions, with handy methods, syntactic sugar, and performance improvements for wide range of primitive data types, UIKit and Cocoa classes –over 500 in 1– for iOS, macOS, tvOS and watchOS.

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
    - URL extensions
    - SwifterSwift

  List of UIKit Extensions
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

  List of Cocoa Extensions
    - CGColor extensions
    - CGFloat extensions
    - CGPoint extensions
    - CGSize extensions
    - NSAttributedString extensions
    - NSColor extensions

                   DESC

  s.homepage = "https://github.com/SwifterSwift/SwifterSwift"
  s.license = { type: 'MIT', file: 'LICENSE' }
  s.authors = { "Omar Albeik" => 'omaralbeik@gmail.com' }
  s.social_media_url = "http://twitter.com/omaralbeik"
  s.screenshot  = 'https://raw.githubusercontent.com/SwifterSwift/SwifterSwift/master/logo.png'

  s.ios.deployment_target = '8.0'
  s.osx.deployment_target = '10.10'
  s.tvos.deployment_target = '9.0'
  s.watchos.deployment_target = '3.0'

  s.requires_arc = true
  s.source = { git: "https://github.com/SwifterSwift/SwifterSwift.git", tag: "#{s.version}" }
  s.source_files = "Source/**/*.swift"
  s.pod_target_xcconfig = {
    'SWIFT_VERSION' => '3.0',
  }
  s.documentation_url = 'https://github.com/SwifterSwift/SwifterSwiftDocs'
end
