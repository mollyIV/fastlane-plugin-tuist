lib = File.expand_path("lib", __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'fastlane/plugin/tuist/version'

Gem::Specification.new do |spec|
  spec.name          = 'fastlane-plugin-tuist'
  spec.version       = Fastlane::Tuist::VERSION
  spec.author        = 'mollyIV'
  spec.email         = ''

  spec.summary       = 'Tuist Fastlane Plugin'
  spec.homepage      = "https://github.com/mollyIV/fastlane-plugin-tuist"
  spec.license       = "MIT"

  spec.files         = Dir["lib/**/*"] + %w(README.md LICENSE)
  spec.extensions  = ['ext/tuist/extconf.rb']
  spec.require_paths = ['lib']
  spec.metadata['rubygems_mfa_required'] = 'true'
  spec.required_ruby_version = '>= 3.0'

  spec.add_runtime_dependency 'rubyzip', '~> 2.3'
end
