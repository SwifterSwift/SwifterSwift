Pod::Spec.new do |s|
  s.name = 'SwifterSwift'
  s.version = '5.0.0'
  s.summary = 'A handy collection of more than 500 native Swift extensions to boost your productivity.'
  s.description = <<-DESC
  SwifterSwift is a collection of over 500 native Swift extensions, with handy methods, syntactic sugar, and performance improvements for wide range of primitive data types, UIKit and Cocoa classes –over 500 in 1– for iOS, macOS, tvOS and watchOS.
                   DESC

  s.homepage = 'https://github.com/SwifterSwift/SwifterSwift'
  s.license = { type: 'MIT', file: 'LICENSE' }
  s.authors = { 'Omar Albeik' => 'omaralbeik@gmail.com' }
  s.social_media_url = 'http://twitter.com/omaralbeik'
  s.screenshot = 'https://raw.githubusercontent.com/SwifterSwift/SwifterSwift/master/Assets/logo.png'
  s.documentation_url = 'http://swifterswift.com/docs'

  s.ios.deployment_target = '8.0'
  s.osx.deployment_target = '10.10'
  s.tvos.deployment_target = '9.0'
  s.watchos.deployment_target = '2.0'

  s.swift_version = '5.0'
  s.requires_arc = true
  s.source = { git: 'https://github.com/SwifterSwift/SwifterSwift.git', tag: s.version.to_s }
  s.source_files = 'Sources/SwifterSwift/**/*.swift'

  # SwiftStdlib Extensions
  s.subspec 'SwiftStdlib' do |sp|
    sp.source_files  = 'Sources/SwifterSwift/SwiftStdlib/*.swift'
  end

  # Foundation Extensions
  s.subspec 'Foundation' do |sp|
    sp.source_files  = 'Sources/SwifterSwift/Foundation/*.swift'
  end

  # UIKit Extensions
  s.subspec 'UIKit' do |sp|
    sp.source_files  = 'Sources/SwifterSwift/Shared/*.swift', 'Sources/SwifterSwift/UIKit/*.swift'
  end

  # AppKit Extensions
  s.subspec 'AppKit' do |sp|
    sp.source_files  = 'Sources/SwifterSwift/Shared/*.swift', 'Sources/SwifterSwift/AppKit/*.swift'
  end

  # CoreGraphics Extensions
  s.subspec 'CoreGraphics' do |sp|
    sp.source_files  = 'Sources/SwifterSwift/CoreGraphics/*.swift'
  end

  # CoreLocation Extensions
  s.subspec 'CoreLocation' do |sp|
    sp.source_files  = 'Sources/SwifterSwift/CoreLocation/*.swift'
  end

  # MapKit Extensions
  s.subspec 'MapKit' do |sp|
    sp.source_files = 'Sources/SwifterSwift/MapKit/*.swift'
  end

  # SpriteKit Extensions
  s.subspec 'SpriteKit' do |sp|
    sp.source_files = 'Sources/SwifterSwift/SpriteKit/*.swift'
  end

  s.subspec 'SceneKit' do |sp|
    sp.source_files  =  'Sources/SwifterSwift/Shared/*.swift', 'Sources/SwifterSwift/SceneKit/*.swift'
  end

  # Dispatch Extensions
  s.subspec 'Dispatch' do |sp|
    sp.source_files = 'Sources/SwifterSwift/Dispatch/*.swift'
  end

end
