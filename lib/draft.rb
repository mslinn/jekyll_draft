# Define these methods outside of the JekyllDraft class so they can be invoked externally and tested more easily
module Draft
  # @return true by checking in this order:
  #   - document is in _drafts directory, detectable by doc['draft']==true
  #   - document front matter contains 'published: false'
  def draft?(doc)
    return true if doc.respond_to?(:draft) && doc.draft
    return true if doc.key?('draft') && doc['draft'] # ignore !doc['draft']
    return !doc['published'] if doc.key?('published')

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

  module_function :draft?, :draft_html
end
