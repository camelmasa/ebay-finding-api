
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "ebay/finding/api/version"

Gem::Specification.new do |spec|
  spec.name          = "ebay-finding-api"
  spec.version       = Ebay::Finding::Api::VERSION
  spec.authors       = ["camelmasa"]
  spec.email         = ["camelmasa@gmail.com"]

  spec.summary       = %q{eBay finding API client}
  spec.description   = %q{eBay finding API client}
  spec.homepage      = "https://github.com/camelmasa/ebay-finding-api"
  spec.license       = "MIT"
  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency "faraday", "~> 0.15"
  spec.add_development_dependency "bundler", "~> 1.16"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"
end
