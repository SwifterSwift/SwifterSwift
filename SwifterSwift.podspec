Pod::Spec.new do |s|
  s.name = 'SwifterSwift'
  s.version = '8.0.0'
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

  s.ios.deployment_target = '12.0'
  s.osx.deployment_target = '10.13'
  s.tvos.deployment_target = '12.0'
  s.watchos.deployment_target = '4.0'

  s.swift_versions = ['6.0']
  s.requires_arc = true
  s.source = { git: 'https://github.com/SwifterSwift/SwifterSwift.git', tag: s.version.to_s }
  s.source_files = 'Sources/SwifterSwiftShared/**/*.swift',
                   'Sources/SwifterSwiftSwiftStdlib/**/*.swift',
                   'Sources/SwifterSwiftFoundation/**/*.swift',
                   'Sources/SwifterSwiftCoreAnimation/**/*.swift',
                   'Sources/SwifterSwiftCoreGraphics/**/*.swift',
                   'Sources/SwifterSwiftCoreLocation/**/*.swift',
                   'Sources/SwifterSwiftCryptoKit/**/*.swift',
                   'Sources/SwifterSwiftDispatch/**/*.swift',
                   'Sources/SwifterSwiftHealthKit/**/*.swift',
                   'Sources/SwifterSwiftMapKit/**/*.swift',
                   'Sources/SwifterSwiftSceneKit/**/*.swift',
                   'Sources/SwifterSwiftSpriteKit/**/*.swift',
                   'Sources/SwifterSwiftStoreKit/**/*.swift',
                   'Sources/SwifterSwiftUIKitCore/**/*.swift',
                   'Sources/SwifterSwiftUIKitIBInspectable/**/*.swift',
                   'Sources/SwifterSwiftAppKitCore/**/*.swift',
                   'Sources/SwifterSwiftAppKitIBInspectable/**/*.swift',
                   'Sources/SwifterSwiftWebKit/**/*.swift'

  # SwiftStdlib Extensions
  s.subspec 'SwiftStdlib' do |sp|
    sp.source_files = 'Sources/SwifterSwiftShared/*.swift', 'Sources/SwifterSwiftSwiftStdlib/*.swift'
  end

  # Foundation Extensions
  s.subspec 'Foundation' do |sp|
    sp.source_files = 'Sources/SwifterSwiftShared/*.swift', 'Sources/SwifterSwiftFoundation/*.swift'
    sp.resource_bundles = {
      'SwifterSwift_Privacy' => 'Sources/SwifterSwiftFoundation/PrivacyInfo.xcprivacy'
    }
  end

  # UIKit Extensions
  s.subspec 'UIKit' do |sp|
    sp.source_files = 'Sources/SwifterSwiftShared/*.swift',
                      'Sources/SwifterSwiftUIKitCore/**/*.swift',
                      'Sources/SwifterSwiftUIKitIBInspectable/**/*.swift'
  end

  # UIKit Without IBInspectable Extensions
  s.subspec 'UIKitNoIBInspectable' do |sp|
    sp.source_files = 'Sources/SwifterSwiftShared/*.swift', 'Sources/SwifterSwiftUIKitCore/**/*.swift'
  end

  # AppKit Extensions
  s.subspec 'AppKit' do |sp|
    sp.source_files = 'Sources/SwifterSwiftShared/*.swift',
                      'Sources/SwifterSwiftAppKitCore/**/*.swift',
                      'Sources/SwifterSwiftAppKitIBInspectable/**/*.swift'
  end

  # AppKit Without IBInspectable Extensions
  s.subspec 'AppKitNoIBInspectable' do |sp|
    sp.source_files = 'Sources/SwifterSwiftShared/*.swift', 'Sources/SwifterSwiftAppKitCore/**/*.swift'
  end

  # SwifterSwift Without IBInspectable Extensions
  s.subspec 'NoIBInspectable' do |sp|
    sp.source_files = 'Sources/SwifterSwiftShared/**/*.swift',
                      'Sources/SwifterSwiftSwiftStdlib/**/*.swift',
                      'Sources/SwifterSwiftFoundation/**/*.swift',
                      'Sources/SwifterSwiftCoreAnimation/**/*.swift',
                      'Sources/SwifterSwiftCoreGraphics/**/*.swift',
                      'Sources/SwifterSwiftCoreLocation/**/*.swift',
                      'Sources/SwifterSwiftCryptoKit/**/*.swift',
                      'Sources/SwifterSwiftDispatch/**/*.swift',
                      'Sources/SwifterSwiftHealthKit/**/*.swift',
                      'Sources/SwifterSwiftMapKit/**/*.swift',
                      'Sources/SwifterSwiftSceneKit/**/*.swift',
                      'Sources/SwifterSwiftSpriteKit/**/*.swift',
                      'Sources/SwifterSwiftStoreKit/**/*.swift',
                      'Sources/SwifterSwiftUIKitCore/**/*.swift',
                      'Sources/SwifterSwiftAppKitCore/**/*.swift',
                      'Sources/SwifterSwiftWebKit/**/*.swift'
  end

  # CoreGraphics Extensions
  s.subspec 'CoreGraphics' do |sp|
    sp.source_files = 'Sources/SwifterSwiftCoreGraphics/*.swift'
  end

  # CoreLocation Extensions
  s.subspec 'CoreLocation' do |sp|
    sp.source_files = 'Sources/SwifterSwiftCoreLocation/*.swift'
  end

  # CoreAnimation Extensions
  s.subspec 'CoreAnimation' do |sp|
    sp.source_files = 'Sources/SwifterSwiftShared/*.swift', 'Sources/SwifterSwiftCoreAnimation/*.swift'
  end

  # CryptoKit Extensions
  s.subspec 'CryptoKit' do |sp|
    sp.source_files = 'Sources/SwifterSwiftShared/*.swift', 'Sources/SwifterSwiftCryptoKit/*.swift'
  end

  # MapKit Extensions
  s.subspec 'MapKit' do |sp|
    sp.source_files = 'Sources/SwifterSwiftShared/*.swift', 'Sources/SwifterSwiftMapKit/*.swift'
  end

  # SpriteKit Extensions
  s.subspec 'SpriteKit' do |sp|
    sp.source_files = 'Sources/SwifterSwiftSpriteKit/*.swift'
  end

  s.subspec 'SceneKit' do |sp|
    sp.source_files = 'Sources/SwifterSwiftShared/*.swift', 'Sources/SwifterSwiftSceneKit/*.swift'
  end

  # StoreKit Extensions
  s.subspec 'StoreKit' do |sp|
    sp.source_files = 'Sources/SwifterSwiftStoreKit/*.swift'
  end

  # Dispatch Extensions
  s.subspec 'Dispatch' do |sp|
    sp.source_files = 'Sources/SwifterSwiftDispatch/*.swift'
  end

  # WebKit Extensions
  s.subspec 'WebKit' do |sp|
    sp.source_files = 'Sources/SwifterSwiftWebKit/*.swift'
  end

  # HealthKit Extensions
  s.subspec 'HealthKit' do |sp|
    sp.source_files = 'Sources/SwifterSwiftHealthKit/*.swift'
  end

end
