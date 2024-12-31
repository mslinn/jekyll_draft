# Define these methods outside of the JekyllDraft class so they can be invoked externally and tested more easily
module Jekyll
  module Draft
    class << self
      attr_accessor :logger
    end
    Draft.logger = PluginMetaLogger.instance.new_logger(self, PluginMetaLogger.instance.config)

    # @return true by checking in this order:
    #   - document is in _drafts directory, detectable by doc['draft']==true
    #   - document front matter contains 'published: false'
    def draft?(doc)
      if doc.respond_to?(:data) && (doc.data.respond_to? :key?)
        return !doc.data['published'] if doc.data.key? 'published'
        return doc.data['draft'] if doc.data.key? 'draft'
      end
      if doc.respond_to? :[]
        return !doc['published'] if doc.key? 'published'
        return  doc['draft']     if doc.key? 'draft'
      end

      return doc.draft if doc.respond_to? :draft

      false
    rescue StandardError => e
      Draft.logger.error { e }
      false
    end

    # @param doc [Jekyll::Drops::DocumentDrop]
    # @return HTML that indicates if a doc is a draft or not
    def draft_html(doc)
      return '' unless draft? doc

      " <i class='jekyll_draft'>Draft</i>"
    rescue StandardError => e
      Draft.logger.error { e.full_message }
      ''
    end

    # @return Jekyll page whose url uniquely contains path_portion
    def page_match(path_portion)
      matching_pages = ::AllCollectionsHooks.all_collections.select { |x| x.url.include? path_portion }
      case matching_pages.length
      when 0
        Draft.logger.error do
          "Error: No page path included the string '#{path_portion}'"
        end
        exit! 1
      when 1
        matching_pages.first
      else
        Draft.logger.error do
          "Error: More than one url matched '#{path_portion}':\n  #{matching_pages.map(&:url).join("\n  ")}"
        end
        exit! 2
      end
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

    module_function :draft?, :draft_html, :page_match, :root
  end
end