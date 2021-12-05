# frozen_string_literal: true

require_relative "lib/guard/codespell/version"

Gem::Specification.new do |spec|
  spec.name          = "guard-codespell"
  spec.version       = Guard::CodespellVersion::VERSION
  spec.authors       = ["Guillaume Loubier"]
  spec.email         = ["guillaume.loubier@hooktstudios.com"]

  spec.summary       = "Guard plugin for codespell"
  spec.description   = "Guard::Codespell uses codespell to automatically look for typos in your codebase."
  spec.homepage      = "https://github.com/hooktstudios/guard-codespell"
  spec.license       = "MIT"
  spec.required_ruby_version = ">= 2.6"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://github.com/hooktstudios/guard-codespell"
  spec.metadata["changelog_uri"] = "https://github.com/hooktstudios/guard-codespell/CHANGELOG.md"
  spec.metadata["rubygems_mfa_required"] = "true"

  spec.files         = `git ls-files`.split($INPUT_RECORD_SEPARATOR)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^spec/})
  spec.require_paths = ["lib"]

  spec.add_runtime_dependency "guard", "~> 2.0"
  spec.add_runtime_dependency "guard-compat", "~> 1.1"
end
