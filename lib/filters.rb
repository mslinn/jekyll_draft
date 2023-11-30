require 'jekyll_plugin_logger'
require 'yaml'

# Jekyll filters that detect draft documents
module Jekyll
  module DraftFilter
    def is_draft(doc) # rubocop:disable Naming/PredicateName
      Draft.draft? doc
    end

    def draft_html(doc)
      Draft.draft_html doc
    end
  end
  Liquid::Template.register_filter(DraftFilter)
end
