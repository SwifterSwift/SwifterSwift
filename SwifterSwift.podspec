Pod::Spec.new do |s|
  s.name = "SwifterSwift"
  s.module_name = "SwifterSwift"
  s.version = "3.1.0"
  s.summary = "A handy collection of more than 500 native Swift 3 extensions to boost your productivity."
  s.description = <<-DESC
  SwifterSwift is a collection of over 500 native Swift 3 extensions, with handy methods, syntactic sugar, and performance improvements for wide range of primitive data types, UIKit and Cocoa classes –over 500 in 1– for iOS, macOS, tvOS and watchOS.
                   DESC

  s.homepage = "https://github.com/SwifterSwift/SwifterSwift"
  s.license = { type: 'MIT', file: 'LICENSE' }
  s.authors = { "Omar Albeik" => 'omaralbeik@gmail.com' }
  s.social_media_url = "http://twitter.com/omaralbeik"
  s.screenshot  = 'https://raw.githubusercontent.com/SwifterSwift/SwifterSwift/master/Assets/logo.png'

  s.ios.deployment_target = '8.0'
  s.osx.deployment_target = '10.10'
  s.tvos.deployment_target = '9.0'
  s.watchos.deployment_target = '2.0'

  s.requires_arc = true
  s.source = { git: "https://github.com/SwifterSwift/SwifterSwift.git", tag: "#{s.version}" }
  s.source_files = "Sources/**/*.{swift,h}"
  s.public_header_files = 'Sources/SwifterSwift.h'
  s.pod_target_xcconfig = {
    'SWIFT_VERSION' => '3.0',
  }
  s.documentation_url = 'http://swifterswift.com/docs'

  # Foundation Extensions
  s.subspec 'Foundation' do |sp|
    sp.source_files  = "Sources/Extensions/Foundation/*.swift"
  end

  # UIKit Extensions
  s.subspec 'UIKit' do |sp|
    sp.source_files  = "Sources/Extensions/UIKit/*.swift"
  end

  # Cocoa Extensions
  s.subspec 'Cocoa' do |sp|
    sp.source_files  = "Sources/Extensions/Cocoa/*.swift"
  end

end
