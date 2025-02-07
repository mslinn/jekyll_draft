source "https://rubygems.org"

# Specify your gem's dependencies in jekyll_draft.gemspec
gemspec

gem 'jekyll_all_collections', '>= 0.4.0' # Putting this in gemspec causes a circular dependency
# If you need jekyll_draft, be sure to always depend on jekyll_all_collections as well
# This problem will go away when jekyll_all_collections is folded into jekyll_plugin_support

group :test, :development do
  gem 'debug', '>= 1.0.0', require: false
  gem 'pry', require: false
  gem 'rake', require: false
  gem 'rspec', require: false
  gem 'rubocop', require: false
  gem 'rubocop-md', require: false
  gem 'rubocop-performance', require: false
  gem 'rubocop-rake', require: false
  gem 'rubocop-rspec', require: false
end

group :development do
  gem 'rspec-match_ignoring_whitespace'
end
