
require_relative "lib/telesink"

Gem::Specification.new do |spec|
  spec.name = "telesink"
  spec.version = Telesink::VERSION
  spec.authors = ["Kyrylo Silin"]
  spec.email = ["kyrylo@telesink.com"]

  spec.summary = "Track events with Telesink using the official Ruby SDK."

  spec.homepage = "https://telesink.com"
  spec.required_ruby_version = ">= 3.0.0"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://github.com/telesink/telesink-ruby"

  spec.files = Dir.chdir(__dir__) do
    `git ls-files -z`.split("\x0").reject do |f|
      (File.expand_path(f) == __FILE__) ||
        f.start_with?(*%w[bin/ test/ .git .github Gemfile])
    end
  end
  spec.bindir = "exe"
  spec.executables = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.metadata["rubygems_mfa_required"] = "true"

  spec.add_runtime_dependency "logger", "~> 1.7"

  spec.add_development_dependency "minitest", "~> 5.0"
  spec.add_development_dependency "rake",     "~> 13.0"
end
