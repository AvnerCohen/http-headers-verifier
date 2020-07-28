
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require_relative "./lib/version"

Gem::Specification.new do |spec|
  spec.name          = "http-headers-verifier"
  spec.version       = HttpHeadersVerifier::VERSION
  spec.platform      = Gem::Platform::RUBY
  spec.authors       = ["Avner Cohen"]
  spec.email         = ["israbirding@gmail.com"]

  spec.summary       = %q{Verify a pre-defined HTTP headers configurations.}
  spec.description   = %q{Verify a pre-defined HTTP headers configurations. Unlike some other similar projects, this is not meant to enforce best practices, instead it is meant to define policies on top of headers and enforce them.}
  spec.homepage      = "https://github.com/AvnerCohen/http-headers-verifier"
  spec.license       = "MIT"

  if spec.respond_to?(:metadata)
    spec.metadata["allowed_push_host"] = "https://rubygems.org"

    spec.metadata["homepage_uri"] = spec.homepage
  else
    raise "RubyGems 2.0 or newer is required to protect against " \
      "public gem pushes."
  end

  spec.files         = Dir.chdir(File.expand_path('..', __FILE__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end

  spec.bindir = "exe"
  spec.executables      = ["http-headers-verifier.rb"]
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler"
  spec.add_development_dependency "rspec", "~> 3.0"
  spec.add_development_dependency "byebug", "~> 9.0"

  spec.add_runtime_dependency     "typhoeus", "~> 1.4"

  spec.metadata['source_code_uri'] = 'https://github.com/AvnerCohen/http-headers-verifier'
  spec.metadata['bug_tracker_uri'] = 'https://github.com/AvnerCohen/http-headers-verifier/issues'
end
