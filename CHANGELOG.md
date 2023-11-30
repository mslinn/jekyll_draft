# Change Log

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
