
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "nonsensor/version"

Gem::Specification.new do |spec|
  spec.name          = "nonsensor"
  spec.version       = Nonsensor::VERSION
  spec.authors       = ["Michał Musialik"]
  spec.email         = ["info@rubylogic.eu"]

  spec.summary       = "Generate streams of random data that look good on charts."
  spec.description   = "Generate streams of random data that look good on charts."
  spec.homepage      = "http://rubylogic.eu/"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.16"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "minitest", "~> 5.0"
  spec.add_development_dependency "minitest-reporters", "~> 1.3.5"
end
