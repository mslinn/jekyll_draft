# jekyll_draft [![Gem Version](https://badge.fury.io/rb/jekyll_draft.svg)](https://badge.fury.io/rb/jekyll_draft)

Jekyll has various ways of specifying that a page or document is
visible when the website is published in `production` mode.
The Jekyll documentation is scattered and incomplete regarding this topic.
This plugin&rsquo;s filters provide a simple means for marking draft pages in `development` mode.

A secret document is a special form of a draft document.
Secrets are always drafts, but not the converse.

`Jekyll_draft` provides the following:

* Jekyll block tags: `if_draft` and `unless_draft`.
* Jekyll block tags: `if_secret` and `unless_secret`.
* Jekyll inline tags: `else_if_not_draft`, `else_if_draft`, `else_if_not_secret` and `else_if_secret`.
  These are meant for use within `if_draft`, `unless_draft`, `if_secret` and `unless_secret`, respectively.
  Both of them are identical; they are both provided so usage seems natural.
* Jekyll inline tag `draft_html`, which generates HTML that indicates if the document
  it is embedded within is a draft or a secret.
* Liquid filters:
  * `is_draft` returns a boolean indicating if the document passed to it is a draft.
  * `is_secret` returns a boolean indicating if the document passed to it is a secret.
  * `draft_html` returns the same string the `draft_html` tag returns,
    indicating if the document passed to it is a draft.
* Module `Jekyll::Draft` defines an API that your plugin can call.
  It has the following methods:
  * `draft?` returns a boolean indicating if the document passed to it is a draft or a secret.
  * `draft_only?` returns a boolean indicating if the document passed to it is a draft and not a secret.
  * `draft_html` returns the same string that `draft_html` tag returns;
    the response indicates if the document passed to it is a draft.
  * `root` returns the path to the root of the collection that the document passed to it is a member of.
    This method is not functionally related to Jekyll draft documents;
    it should be packaged separately ... maybe one day...
  * `secret?` returns a boolean indicating if the document passed to it is a draft.

The difference between the tag called `draft_html` and the filter of the same name
is that the tag only works on the document that it is embedded in,
while the filter works on any document passed to it.
Both the tag and the filter call the same API methods defined in the `Jekyll::Draft` module.

More information is available on [Mike Slinn&rsquo;s website](https://www.mslinn.com/jekyll_plugins/jekyll_draft.html).


## Front Matter

To mark a blog as a draft, put it in the `_drafts` directory.

To mark any other article as a draft, add the following to its front matter:

```text
published: false
```

To mark any article (including blog posts) as a secret, add the following to its front matter:

```text
secret: true
```

Secret documents are a type of draft document, so the above implies:

```text
published: false
secret: true
```


## Demo

The [demo](demo) subdirectory has working examples of this Jekyll plugin's functionality
in a demonstration website.
It can be used to debug the plugin or it can run freely.
Please examine the <code>HTML</code> files in the demo to see how the plugin works.

To run the demo freely from the command line, type:

```console
$ demo/_bin/debug -r
```

Now point your web browser to http://localhost:4444.
You should see:

![jekyll_draft demo](jekyll_draft_demo.png)

When the demonstration is running, any time you modify the <code>.html</code> files,
the demo website will regenerate.
Each time you make a change, the website instantly regenerates.
This helps the learning experience.

Please play with the contents of the <code>.html</code> files,
so you can learn how to write Jekyll pages that include this functionality.


## Installation

### For Use In A Jekyll Website

1. Add the CSS found in [`demo/assets/css/jekyll_draft.css`](demo/assets/css/jekyll_draft.css) to your Jekyll layout(s).

2. Add the following to your Jekyll website's `Gemfile`, within the `jekyll_plugins` group:

   ```ruby
   group :jekyll_plugins do
     gem 'jekyll_draft', '>2.0.0' # v2.0.0 was a dud, do not use it
   end
   ```

3. Type:

   ```shell
   $ bundle
   ```


### For Use In a Gem

1. Add the following to your gem&rsquo;s `.gemspec`:

   ```ruby
   spec.add_dependency 'jekyll_draft', '>2.0.0' # v2.0.0 was a dud, do not use it
   ```

2. Type:

   ```shell
   $ bundle
   ```


## Usage

### `if_draft`, `unless_draft`, `if_secret` and `unless_secret` Block Tags

The `if_draft` and `if_secret` block tags acts as `if-then` or `if-then-else` programming constructs.

The following generates `<p>This is a draft or a secret document!</p>`
if the document it is embedded in is a draft, and the Jekyll website generation was performed in development mode:

```html
{% if_draft %}
  <p>This is a draft or a secret document!</p>
{% endif_draft %}
```

The following generates `<p>This is a draft document!</p>`
if the document it is embedded in is a draft and not a secret, and the Jekyll website generation was performed in development mode:

```html
{% if_draft_only %}
  <p>This is a draft document!</p>
{% endif_draft %}
```

The following generates `<p>This is a secret document!</p>`
if the document it is embedded in is a secret, and the Jekyll website generation was performed in development mode:

```html
{% if_secret %}
  <p>This is a secret document!</p>
{% endif_draft %}
```

The following enhances the previous example by also generating `<p>This is not a draft or a secret document!</p>`
when in production mode:

```html
{% if_draft %}
  <p>This is a draft or a secret document!</p>
{% else_if_not_secret %}
  <p>This is not a secret document, but might be a draft!</p>
{% else_if_not_draft %}
  <p>This is not a draft or a secret document!</p>
{% endif_draft %}
```

The `unless_draft`, `unless_draft_only` and `unless_secret` block tags acts as Ruby
[unless-then](https://rubystyle.guide/#unless-for-negatives) or
an [unless-then-else](https://rubystyle.guide/#no-else-with-unless) programming constructs.

```html
{% unless_draft %}
  <p>This is not a draft or a secret document!</p>
{% endunless_draft %}
```

```html
{% unless_draft_only %}
  <p>This is not a draft document, but might be a secret!</p>
{% endunless_draft %}
```

```html
{% unless_secret %}
  <p>This is not a secret document, but might be a draft!</p>
{% endunless_draft %}
```

This is how you can specify an `else` clause for `unless_draft`:

```html
{% unless_draft %}
  <p>This is not a draft document!</p>
{% else_if_draft %}
  <p>This is a draft document!</p>
{% endunless_draft %}
```

```html
{% unless_draft %}
  <p>This is not a draft document!</p>
{% else_if_draft %}
  <p>This is a draft or a secret document!</p>
{% else_if_draft_only %}
  <p>This is a draft document!</p>
{% else_if_secret %}
  <p>This is a secret document!</p>
{% endunless_draft %}
```

You can use the keywords `else_if_draft` and `else_if_not_draft` interchangeably.
They are actually made by registering the same code twice with different subclass names.
Use the keyword that makes the most sense to you.


### `draft_html` Inline Tag

Here is an example of embedding the `draft_html` inline tag into an HTML document:

```html
  <p>Is this a draft document? Look here to see: {% draft_html %}</p>
```

By default, if the document is a draft or a secret, and the Jekyll website generation was performed in development mode,
`draft_html` emits ` <i class='jekyll_draft>Draft</i>` or ` <i class='jekyll_secret>Secret</i>` ,
otherwise it does not emit anything.

You can change this behavior several ways:

* Add the `published_output` parameter to specify the HTML that should be emitted if the document is not a draft or a secret,
and the Jekyll website generation was performed in development mode.
The default message will continue to be output for draft documents when the `published_output` parameter is used.

  ```html
  {% draft_html published_output="<p>Not a draft or a secret</p>" %}
  ```

* Add the `draft_output` parameter to specify the HTML that should be emitted if the document is a draft,
the `secret_output` parameter to specify the HTML that should be emitted if the document is a secret,
and the Jekyll website generation was performed in development mode:

  ```html
  {% draft_html
    draft_output="<p>Is a draft</p>"
  %}
  {% draft_html
    draft_output="<p>Is a draft</p>"
    published_output="<p>Not a draft</p>"
  %}
  {% draft_html
    secret_output="<p>Is a secret</p>"
  %}
  {% draft_html
    draft_output="<p>Is a draft</p>"
    published_output="<p>Not a draft or a secret</p>"
    secret_output="<p>Is a secret</p>"
  %}
  ```

* Add the `draft_class` parameter to specify the CSS class that should be added
  to the emitted HTML if the document is a draft,
  add the `secret_class` parameter to specify the CSS class that should be added
  to the emitted HTML if the document is a secret,
  and the Jekyll website generation was performed in development mode:

  ```html
  {% draft_html draft_class="my_draft_class" %}
  {% draft_html
    draft_class="my_draft_class"
    published_output="<p>Not a draft or a secret</p>"
  %}
  {% draft_html draft_class="my_draft_class" secret_class="my_secret_class" %}
  {% draft_html
    draft_class="my_draft_class"
    published_output="<p>Not a draft or a secret</p>"
    secret_class="my_secret_class"
  %}
  ```

* Add the `draft_style` parameter to specify the CSS class that should be added
  to the emitted HTML if the document is a draft,
  and the Jekyll website generation was performed in development mode:

  ```html
  {% draft_html draft_style="font-size: 24pt;" %}
  {% draft_html secret_style="font-size: 24pt; color: red;" %}
  {% draft_html
    draft_class="my_draft_class"
    draft_style="font-size: 24pt;"
    secret_class="my_secret_class"
    secret_style="font-size: 24pt; color: red;"
  %}
  {% draft_html
    draft_class="my_draft_class"
    draft_style="font-size: 24pt;"
    published_output="<p>Not a draft or a secret</p>"
    secret_class="my_secret_class"
    secret_style="font-size: 24pt; color: red;"
  %}
  ```


### Liquid Filters

#### `draft_html`

By default, the draft_html Liquid filter generates HTML if a page is invisible when published in `production` mode.
If the page is not a draft then the empty string is returned.

The optional parameters for the `draft_html` inline tag are not available for
use with the `draft_html` filter.

The default generated HTML for draft pages is:<br>
`" <i class='jekyll_draft'>Draft</i>"`

The default generated HTML for secret pages is:<br>
`" <i class='jekyll_secret'>Secret</i>"`

Invoke the filter like the following; the output depends on whether the document is a draft or a secret:

```html
{{ page | draft_html }} => " <i class='jekyll_draft'>Draft</i>"
{{ page | draft_html }} => " <i class='jekyll_secret'>Secret</i>"
```

Here is a code snippet that shows the <code>draft_html</code> filter in use:

```html
{% assign docs = site.myCollection | sort: "order" %}
<ol id="titles">
{% for doc in docs %}
  <li>
    <a href="{{doc.url}}" class="title">{{doc.title}}</a>{{ doc | draft_html }}
  </li>
{% endfor %}
</ol>
```


#### `is_draft`

This filter detects if a page is invisible when published in `production` mode,
and either returns `true` or `false`.

```html
{{ page | is_draft }} <!-- true for draft and secret documents in development mode -->
```


#### `is_draft_only`

This filter detects if a page is invisible when published in `production` mode,
and either returns `true` or `false`.

```html
{{ page | is_draft_only }} <!-- true for draft documents in development mode, but not secret documents -->
```


#### `is_secret`

This filter detects if a page is invisible when published in `production` mode,
and either returns `true` or `false`.

```html
{{ page | is_secret }} <!-- true for secret documents in development mode, but not draft documents -->
```


### Invoking From Another Jekyll Plugin

```ruby
require 'jekyll_draft'

puts 'Found a draft or a secret' if Jekyll::Draft.is_draft post

draft_or_secret = Jekyll::Draft.draft_html post
```



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
