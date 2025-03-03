require_relative 'lib/jekyll_draft/version'

Gem::Specification.new do |spec|
  github = 'https://github.com/mslinn/jekyll_draft'

  spec.authors     = ['Mike Slinn']
  spec.bindir      = 'exe'
  spec.description = <<~END_OF_DESC
    This Jekyll filter detects draft documents.
  END_OF_DESC
  spec.email    = ['mslinn@mslinn.com']
  spec.files    = Dir['.rubocop.yml', 'LICENSE.*', 'Rakefile', '{lib,spec}/**/*', '*.gemspec', '*.md']
  spec.homepage = 'https://www.mslinn.com/jekyll_plugins/jekyll_draft.html'
  spec.license  = 'MIT'
  spec.metadata = {
    'allowed_push_host' => 'https://rubygems.org',
    'bug_tracker_uri'   => "#{github}/issues",
    'changelog_uri'     => "#{github}/CHANGELOG.md",
    'homepage_uri'      => spec.homepage,
    'source_code_uri'   => github,
  }
  spec.name                 = 'jekyll_draft'
  spec.platform             = Gem::Platform::RUBY
  spec.post_install_message = <<~END_MESSAGE

    Thanks for installing #{spec.name}!

  END_MESSAGE
  spec.require_paths         = ['lib']
  spec.required_ruby_version = '>= 3.2.0'
  spec.summary               = 'This Jekyll filter detects draft documents.'
  spec.test_files            = spec.files.grep(%r{^(test|spec|features)/})
  spec.version               = DraftVersion::VERSION

  spec.add_dependency 'jekyll', '>= 4.4.0'
  spec.add_dependency 'jekyll_plugin_support', '>=3.0.0'
  spec.add_dependency 'sorted_set'
end
