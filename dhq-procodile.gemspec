require_relative './lib/procodile/version'
Gem::Specification.new do |s|
  s.name          = "dhq-procodile"
  s.description   = %q{A sophisticated process manager for applications running on Linux & macOS. This is DeployHQ's maintained fork of Adam Cooke's procodile, which has had no release since 2019.}
  s.summary       = %q{This gem will help you run processes from a Procfile on Linux/macOS machines in the background or the foreground. DeployHQ's maintained fork of procodile.}
  s.homepage      = "https://github.com/deployhq/procodile"
  s.version       = Procodile::VERSION
  s.files         = Dir.glob("{lib,bin}/**/*") + ['MIT-LICENCE', 'README.md']
  s.require_paths = ["lib"]
  s.authors       = ["Adam Cooke", "DeployHQ"]
  s.email         = ["support@deployhq.com"]
  s.licenses      = ['MIT']
  # Matches the Ruby versions exercised by .github/workflows/tests.yml
  s.required_ruby_version = '>= 2.7'
  s.metadata      = {
    'source_code_uri' => 'https://github.com/deployhq/procodile',
    'bug_tracker_uri' => 'https://github.com/deployhq/procodile/issues'
  }
  s.bindir = "bin"
  s.executables << 'procodile'
  s.add_runtime_dependency 'json'
  # `logger` is still a default gem on Ruby 3.x but is being removed from the
  # default set in Ruby 4.0, which already warns on require. lib/procodile/logger.rb
  # requires it, so declare it rather than relying on it being present.
  s.add_runtime_dependency 'logger'
end
