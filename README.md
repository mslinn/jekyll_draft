jekyll_draft
[![Gem Version](https://badge.fury.io/rb/jekyll_draft.svg)](https://badge.fury.io/rb/jekyll_draft)
===========

This is a Jekyll plugin that provides two Liquid filters: `is_draft` and `draft_html`.

More information is available on my website about [my Jekyll plugins](https://www.mslinn.com/blog/2020/10/03/jekyll-plugins.html).


## Installation

Add the following to your CSS:
```css
.jekyll_draft {
  background-color: #fefeab;
  padding-bottom: 2px;
  padding-left: 0.5em;
  padding-right: 0.5em;
  padding-top: 2px;
}
```

Add this line to your Jekyll website's `Gemfile`, within the `jekyll_plugins` group:

```ruby
group :jekyll_plugins do
  gem 'jekyll_draft'
end
```

And then execute:

    $ bundle install


## Usage

### `is_draft`

Filters a page according to the directory it resides in, and its front matter.
```
{{ page | is_draft }} => true
```

### `draft_html`
Filters a page according to the directory it resides in, and its front matter.
If the page is not a draft then the empty string is returned.
```
{{ page | draft_html }} => " <i class='bg_light_yellow' style='padding-left: 0.5em; padding-right: 0.5em;'>Draft</i>"
```

### Invoking From Another Jekyll Plugin
```ruby
require 'jekyll_draft'

p 'Found a draft' if Jekyll::Draft.is_draft post

draft = Jekyll::Draft.draft_html post
```

## Demo
The [`demo`](./demo) directory contains a demonstration website, which uses the plugin.
To run, type:
```console
$ demo/_bin/debug -r
```
Now point your web browser to http://localhost:4444


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

### Debugging
Run `bin/attach` and pass the directory name of a Jekyll website that has a suitable script called `_bin/debug`.
The `demo` subdirectory fits this description.
```console
$ bin/attach demo
Successfully uninstalled jekyll_draft-0.1.0
jekyll_draft 0.1.0 built to pkg/jekyll_draft-0.1.0.gem.
jekyll_draft (0.1.0) installed.
Fast Debugger (ruby-debug-ide 0.7.3, debase 0.2.4.1, file filtering is supported) listens on 0.0.0.0:1234
```
Now attach to the debugger process.
This git repo includes a [Visual Studio Code launcher](./.vscode/launch.json) for this purpose labeled `Listen for rdebug-ide`.

Now point your web browser to http://localhost:4444


## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/mslinn/jekyll_draft.


## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
