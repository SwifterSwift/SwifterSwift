Pod::Spec.new do |spec|
  spec.name = "SwifterSwift"
  spec.version = "1.0.3"
  spec.summary = "A handy collection of native Swift 3 extensions to boost your productivity."
  spec.homepage = "https://github.com/omaralbeik/SwifterSwift"
  spec.license = { type: 'MIT', file: 'LICENSE' }
  spec.authors = { "Omar Albeik" => 'omaralbeik@gmail.com' }
  spec.social_media_url = "http://twitter.com/omaralbeik"

  spec.platform = :ios, "8.0"
  spec.requires_arc = true
  spec.source = { git: "https://github.com/omaralbeik/SwifterSwift.git", tag: "v#{spec.version}" }
  spec.source_files = "SwifterSwift/SwifterSwift/Extensions/**/*.swift"
  spec.frameworks   = 'Foundation'
end
