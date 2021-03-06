require_relative "lib/strings/inflection/version"

Gem::Specification.new do |spec|
  spec.name          = "strings-inflection"
  spec.version       = Strings::Inflection::VERSION
  spec.authors       = ["Piotr Murach"]
  spec.email         = ["piotr@piotrmurach.com"]
  spec.summary       = %q{Inflect English nouns and verbs.}
  spec.description   = %q{Inflect English nouns and verbs. The algorithms are based on the analysis of 7,000 most frequently used nouns and 6,000 most used verbs in English language.}
  spec.homepage      = "https://github.com/piotrmurach/strings-inflection"
  spec.license       = "MIT"
  spec.metadata["allowed_push_host"] = "https://rubygems.org"
  spec.metadata["changelog_uri"] = "https://github.com/piotrmurach/strings-inflection/blob/master/CHANGELOG.md"
  spec.metadata["documentation_uri"] = "https://www.rubydoc.info/gems/strings-inflection"
  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://github.com/piotrmurach/strings-inflection"
  spec.files         = Dir["lib/**/*", "README.md", "CHANGELOG.md", "LICENSE.txt"]
  spec.extra_rdoc_files = ["README.md", "CHANGELOG.md"]
  spec.bindir        = "exe"
  spec.require_paths = ["lib"]
  spec.required_ruby_version = ">= 2.0.0"

  spec.add_dependency "strings-numeral",  "~> 0.1.0"

  spec.add_development_dependency "bundler", ">= 1.5"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec", "~> 3.0"
end
