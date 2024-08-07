# Change Log

## 2.0.2 / 2024-07-24

* Compatible with `jekyll_plugin_support` v1.0.0


## 2.0.1 / 2024-02-07

* Added Jekyll block tags `if_secret` and `unless_secret`.
* Added Jekyll inline tags: `unless_draft_only`, `else_if_secret` and `else_if_not_secret`.
* Added Liquid filter: `is_secret`.
* Added method `draft_only?` and `secret?` to API module `Jekyll::Draft`.


## 2.0.1 / 2023-11-30

* Jekyll block tags: `if_draft` and `unless_draft`.
* Jekyll inline tags: `else_if_not_draft` and `else_if_draft`.
* Jekyll inline tag `draft_html`.
* Liquid filters:
  * `is_draft`
  * `draft_html`
* Module `Jekyll::Draft` defines an API with the following methods:
  * `draft?` returns a boolean indicating if the document passed to it is a draft.
  * `draft_html` returns the same string the `draft_html` tag returns,
    indicating if the document passed to it is a draft.


## 2.0.0 / 2023-11-29

* This version was published prematurely by accident.
  It is broken, do not use it.
* This is a complete rewrite, incompatible with previous versions.


## 1.1.2 / 2023-02-25

* Avoids Jekyll generating the message `Deprecation: Document#published is now a key in the #data hash.`


## 1.1.1 / 2023-02-16

* Avoids Jekyll generating the message `Deprecation: Document#draft is now a key in the #data hash.`


## 1.1.0 / 2023-02-05

* Works with CSS classes instead of generating CSS styling
* Improved how unpublished documents are recognized


## 1.0.1 / 2022-08-05

* Improved how drafts are recognized


## 1.0.0 / 2022-04-02

* Initial version
