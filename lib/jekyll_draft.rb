# @author Copyright 2022 {https://www.mslinn.com Michael Slinn}

require 'jekyll_plugin_logger'
require 'yaml'

# Jekyll filter that detects draft documents
module Jekyll
  # Define these methods outside of module DraftFilter so they can be invoked externally and tested easily
  module Draft
    # @return true if document front matter contains published that is not true,
    # or document is in _drafts.
    # If draft and published are both specified in front matter then published has priority.
    def draft?(doc)
      abort 'Jekyll::Draft.draft? doc is nil!'.red if doc.nil?

      return is_unpublished(doc) if published_was_specified(doc)

      # Try Jekyll's naming convention to determine draft status
      return doc.data['draft'] if doc.respond_to?(:data) && doc.data.key?('draft')
      return doc.draft if doc.respond_to?(:draft)

      false
    end

    # @return HTML that indicates if a doc is a draft or not
    def draft_html(doc)
      return '' unless draft?(doc)

      " <i class='jekyll_draft'>Draft</i>"
    end

    # @return path to root of the collection that doc is a member of
    def root(doc, site)
      return '/index.html' unless doc.respond_to?(:collection)

      collection_name = doc.collection
      docs = site.key?(collection_name) ? site[collection_name] : site.collections[collection_name].docs
      index = docs.find { |d| d.url.end_with? 'index.html' }
      return index.url if index

      docs.min.url
    end

    # Non-standard name used so this method could be invoked from Liquid
    # @return true if published was specified in a document's front matter, and the value is false
    def published_was_specified(doc)
      return true if doc.respond_to?(:published)

      return false unless doc.respond_to?(:data)

      return true if doc.data.key?('published')

      false
    end

    # Non-standard name used so this method could be invoked from Liquid
    # @return true if published was specified in a document's front matter, and the value is false
    def is_unpublished(doc) # rubocop:disable Naming/PredicateName
      return !doc.published if doc.respond_to?(:published)

      return !doc['published'] if doc.key?('published')

      return !doc.data['published'] if doc.respond_to?(:data) && doc.data.key?('published')

      false
    end

    module_function :draft?, :draft_html, :is_unpublished, :published_was_specified, :root
  end

  # Jekyll filters interface
  module DraftFilter
    def is_draft(doc) # rubocop:disable Naming/PredicateName
      Draft.draft?(doc)
    end

    def draft_html(doc)
      Draft.draft_html(doc)
    end

    def is_unpublished(doc) # rubocop:disable Naming/PredicateName
      Draft.is_unpublished(doc)
    end

    def root(doc, site)
      Draft.root(doc, site)
    end
  end

  Liquid::Template.register_filter(DraftFilter)
  PluginMetaLogger.instance.info { 'Loaded DraftFilter plugin.' }
end
