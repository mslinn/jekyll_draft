# jekyll_draft [![Gem Version](https://badge.fury.io/rb/jekyll_draft.svg)](https://badge.fury.io/rb/jekyll_draft)

This is a Jekyll plugin that provides the following:

* Jekyll block tags: `if_draft` and `unless_draft`.
* Jekyll inline tags: `else_if_not_draft` and `else_if_draft`.
  These are meant for use within `if_draft` and `unless_draft`, respectively.
  Both of them are identical; they are both provided so usage seems natural.
* Jekyll inline tag: `draft_html`.
  It generates HTML that indicates if the document it is embedded within is a draft.
* Liquid filters:
  * `is_draft` returns a boolean indicating if the document passed to it is a draft.
  * `draft_html` returns the same string the `draft_html` tag returns,
    indicating if the document passed to it is a draft.
* Module `Jekyll::Draft` defines an API with the following methods:
  * `draft?` returns a boolean indicating if the document passed to it is a draft.
  * `draft_html` returns the same string the `draft_html` tag returns,
    indicating if the document passed to it is a draft.

The difference between the tag called `draft_html` and the filter of the same name
is that the tag only works on the document that it is embedded within,
while the filter works on any document passed to it.
Both the tag and the filter call the API defined in the `Jekyll::Draft` module.

See the [demo](demo) subdirectory for working examples that you can play with.

More information is available on [my website](https://www.mslinn.com/jekyll_plugins/jekyll_draft.html).


## Installation

### For Use In A Jekyll Website

Add the CSS found in [`demo/assets/css/jekyll_draft.css`](demo/assets/css/jekyll_draft.css) to your Jekyll layout(s).

Add the following to your Jekyll website's `Gemfile`, within the `jekyll_plugins` group:

```ruby
group :jekyll_plugins do
  gem 'jekyll_draft', '>2.0.0' # v2.0.0 was a dud, do not use it
end
```

And then type:

```shell
$ bundle
```


### For Use In a Gem

Add the following to your gem&rsquo;s `.gemspec`:

```ruby
spec.add_dependency 'jekyll_draft', '>2.0.0' # v2.0.0 was a dud, do not use it
```

And then type:

```shell
$ bundle
```


## Usage

### `if_draft` and `unless_draft` Block Tags

The `if_draft` block tag acts as an `if-then` or an `if-then-else` programming construct.

```html
{% if_draft %}
  <p>This is a draft document!</p>
{% endif_draft %}
```

```html
{% if_draft %}
  <p>This is a draft document!</p>
{% else_if_not_draft %}
  <p>This is not a draft document!</p>
{% endif_draft %}
```

The `unless_draft` block tag acts as a Ruby [unless-then](https://rubystyle.guide/#unless-for-negatives) or
an [unless-then-else](https://rubystyle.guide/#no-else-with-unless) programming construct.

```html
{% unless_draft %}
  <p>This is not a draft document!</p>
{% endunless_draft %}
```

```html
{% unless_draft %}
  <p>This is not a draft document!</p>
{% else_if_draft %}
  <p>This is a draft document!</p>
{% endunless_draft %}
```

You can use `else_if_draft` and `else_if_not_draft` interchangeably.
They are actually made by registering the same code twice under different names.
Use the one that makes better sense to you.


### `draft_html` Inline Tag

```html
  <p>Is this a draft document? Look here to see: {% draft_html %}</p>
```


### Filters

#### `is_draft`

This filter detects if a page is invisible when published in `production` mode,
and either returns `true` or `false`.

```html
{{ page | is_draft }} => true
```


#### `draft_html`

This filter generates HTML to display if a page is invisible when published in `production` mode.
If the page is not a draft then the empty string is returned.
The generated HTML for draft pages is:<br>
`" <i class='jekyll_draft'>Draft</i>"`

```html
{{ page | draft_html }} => " <i class='jekyll_draft'>Draft</i>"
```


### Invoking From Another Jekyll Plugin

```ruby
require 'jekyll_draft'

puts 'Found a draft' if Jekyll::Draft.is_draft post

draft = Jekyll::Draft.draft_html post
```


## Demo

The [`demo/`](demo) directory contains a demonstration website, which uses the plugin.
To run, type:

```console
$ demo/_bin/debug -r
```

Now point your web browser to http://localhost:4444


## Development

### Setup

After checking out the repo, run `bin/setup` to install dependencies.
You can also run `bin/console` for an interactive prompt that will allow you to experiment.

Install development dependencies like this:

```shell
$ BUNDLE_WITH=development bundle
```

To install this gem onto your local machine, run:

```shell
$ bundle exec rake install
```

### Debugging The Demo

Set breakpoints, then use the Visual Studio Code launch configuration called `Debug Demo`.


### Debugging From Another Jekyll Site

Run `bin/attach` and pass the directory name of a Jekyll website that has a suitable script called `_bin/debug`.
The `demo` subdirectory fits this description.

```console
$ bin/attach demo
Successfully uninstalled jekyll_draft-1.1.2
Successfully uninstalled jekyll_draft-2.0.0
jekyll_draft 2.0.0 built to pkg/jekyll_draft-2.0.0.gem.
jekyll_draft (2.0.0) installed.
jekyll_draft 2.0.0 built to pkg/jekyll_draft-2.0.0.gem.
jekyll_draft (2.0.0) installed.
Fetching gem metadata from https://rubygems.org/..........
Resolving dependencies...
Bundle complete! 21 Gemfile dependencies, 104 gems now installed.
Use `bundle info [gemname]` to see where a bundled gem is installed.


INFO PluginMetaLogger: Loaded else_if_draft v0.1.0 plugin.
INFO PluginMetaLogger: Loaded else_if_not_draft v0.1.0 plugin.
INFO PluginMetaLogger: Loaded String and String, v2.0.0 plugin.
INFO PluginMetaLogger: Loaded if_draft v2.0.0 plugin.
INFO PluginMetaLogger: Loaded unless_draft v2.0.0 plugin.
INFO PluginMetaLogger: Loaded String and String, v2.0.0 plugin.
INFO PluginMetaLogger: Loaded exec v1.4.2 plugin.
INFO PluginMetaLogger: Loaded noselect v1.4.2 plugin.
INFO PluginMetaLogger: Loaded pre v1.4.2 plugin.
INFO PluginMetaLogger: Loaded jekyll_pre v1.4.2 plugin.
Configuration file: /mnt/f/work/jekyll/my_plugins/jekyll_draft/demo/_config.yml
           Cleaner: Removing /mnt/f/work/jekyll/my_plugins/jekyll_draft/demo/_site...
           Cleaner: Removing /mnt/f/work/jekyll/my_plugins/jekyll_draft/demo/.jekyll-metadata...
           Cleaner: Removing /mnt/f/work/jekyll/my_plugins/jekyll_draft/demo/.jekyll-cache...
           Cleaner: Nothing to do for .sass-cache.
DEBUGGER: Debugger can attach via TCP/IP (127.0.0.1:45409)
DEBUGGER: wait for debugger connection...
```

Now attach to the debugger process.
This git repo includes a [Visual Studio Code launcher](.vscode/launch.json) for this purpose labeled `Attach rdbg`.
It uses TCP/IP port 45409 to attach; you might need to modify that value.

Now point your web browser to http://localhost:4444


### Releasing A New Version

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
