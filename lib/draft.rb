# Define these methods outside of the JekyllDraft class so they can be invoked externally and tested more easily
module Draft
  # @return true by checking in this order:
  #   - document is in _drafts directory, detectable by doc['draft']==true
  #   - document front matter contains 'published: false'
  def draft?(doc)
    return true if doc.respond_to?(:draft) && doc.draft

    return true if doc.key?('draft') && doc['draft'] # ignore !doc['draft']

    return false unless doc.respond_to?(:hash_for_json)

    hash = doc.entries # FIXME: might cause infinite recursion

    return hash['draft'] if hash.key?('draft') && hash['draft']
    return hash['published'] if hash.key?('published') && hash['published']

    false
  rescue StandardError => e
    @logger.error { e }
    false
  end

  # @param doc [Jekyll::Drops::DocumentDrop]
  # @return HTML that indicates if a doc is a draft or not
  def draft_html
    return '' unless is_draft

    " <i class='jekyll_draft'>Draft</i>"
  rescue StandardError => e
    @logger.error { e }
    ''
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

  # Non-standard name used so this method could be invoked from Liquid.
  # Looks in data before checking for property.
  # @return true if published was specified in a document's front matter, and the value is false
  def is_unpublished(doc) # rubocop:disable Naming/PredicateName
    return !doc.data['published'] if doc.respond_to?(:data) && doc.data.key?('published')

    return !doc.published if doc.respond_to?(:published)

    return !doc['published'] if doc.key?('published')

    false
  end

  module_function :draft?, :draft_html, :is_unpublished, :published_was_specified, :root
end
