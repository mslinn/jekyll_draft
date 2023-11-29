require 'jekyll_plugin_logger'

# Define these methods outside of the JekyllDraft class so they can be invoked externally and tested more easily
module Jekyll
  module Draft
    @logger = PluginMetaLogger.instance.new_logger(self, PluginMetaLogger.instance.config)

    # @return true by checking in this order:
    #   - document is in _drafts directory, detectable by doc['draft']==true
    #   - document front matter contains 'published: false'
    def draft?(doc)
      if doc.respond_to? :data
        return  doc.data['draft']     if doc.data.key? 'draft'
        return !doc.data['published'] if doc.data.key? 'published'
      end
      if doc.respond_to? :[]
        return  doc['draft']     if doc.key? 'draft'
        return !doc['published'] if doc.key? 'published'
      end
      return doc.draft if doc.respond_to?(:draft)

      false
    rescue StandardError => e
      @logger.error { e }
      false
    end

    # @param doc [Jekyll::Drops::DocumentDrop]
    # @return HTML that indicates if a doc is a draft or not
    def draft_html(doc)
      return '' unless draft? doc

      " <i class='jekyll_draft'>Draft</i>"
    rescue StandardError => e
      @logger.error { e.full_message }
      ''
    end

    module_function :draft?, :draft_html
  end
end
