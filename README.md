jekyll_draft
[![Gem Version](https://badge.fury.io/rb/jekyll_draft.svg)](https://badge.fury.io/rb/jekyll_draft)
===========

This is a Jekyll plugin that provides two Liquid filters called `is_draft` and `draft_html`.

More information is available on my web site about [my Jekyll plugins](https://www.mslinn.com/blog/2020/10/03/jekyll-plugins.html).


## Installation

Add this line to your Jekyll website's `Gemfile`, within the `jekyll_plugins` group:

```ruby
group :jekyll_plugins do
  gem 'jekyll_draft'
end
```

And then execute:

    $ bundle install

Or install it yourself as:

    $ gem install jekyll_draft


## Usage

### is_draft

Filters a string containing a path and returns the portion of th path before the filename and extension.
Example: Extracts "blah/blah" from the path.
```
{{ page | is_draft }} => true
```


## Development

After checking out the repo, run `bin/setup` to install dependencies. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

Install development dependencies like this:
```
$ BUNDLE_WITH="development" bundle install
```

To install this gem onto your local machine, run:
```shell
$ bundle exec rake install
```

To release a new version,
  1. Update the version number in `version.rb`.
  2. Commit all changes to git; if you don't the next step might fail with an unexplainable error message.
  3. Run the following:
     ```shell
     $ bundle exec rake release
     ```
     The above creates a git tag for the version, commits the created tag,
     and pushes the new `.gem` file to [RubyGems.org](https://rubygems.org).


## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/mslinn/jekyll_draft.


## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
