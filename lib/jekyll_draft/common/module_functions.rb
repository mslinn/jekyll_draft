# Define these methods outside of the JekyllDraft class so they can be invoked externally and tested more easily
module Jekyll
  module Draft
    class << self
      attr_accessor :logger
    end
    Draft.logger = PluginMetaLogger.instance.new_logger(self, PluginMetaLogger.instance.config)

    # @parameter doc [AllCollectionsHooks::APage|Jekyll::Page|Jekyll::Document]
    # @return true by checking in this order:
    #   - document is in _drafts directory, detectable by doc['draft']==true
    #   - document front matter contains 'published: false'
    def draft?(doc)
      if doc.respond_to?(:data) && doc.data.respond_to?(:key?)
        return !doc.data['published'] if doc.data.key? 'published'
        return doc.data['draft']      if doc.data.key? 'draft'
      end
      if doc.respond_to?(:key?)
        return !doc['published'] if doc.key? 'published'
        return  doc['draft']     if doc.key? 'draft'
      end

      return doc.draft if doc.respond_to? :draft

      false
    rescue StandardError => e
      msg = e.full_message
      if msg.length < 250
        Draft.logger.error { msg }
      else
        Draft.logger.error { "#{msg[0..125]} ... #{msg[-125..msg.length]}" }
      end
      false
    end

    # @param doc [Jekyll::Drops::DocumentDrop]
    # @return HTML that indicates if a doc is a draft or not
    def draft_html(doc)
      return '' unless draft? doc

      " <i class='jekyll_draft'>Draft</i>"
    rescue StandardError => e
      msg = e.full_message
      if msg.length < 250
        Draft.logger.error { msg }
      else
        Draft.logger.error { "#{msg[0..125]} ... #{msg[-125..msg.length]}" }
      end
      ''
    end

    # @return APage whose href uniquely contains path_portion,
    #         or `path_portion` as a String for non-local URLs.
    def page_match(path_portion, error_if_no_match: true, verify_unique_match: false)
      return :non_local_url if path_portion.start_with? 'http:', 'https:', 'mailto'

      matching_pages = if verify_unique_match
                         ::AllCollectionsHooks.sorted_lru_files.find(path_portion)
                       else
                         match = ::AllCollectionsHooks.sorted_lru_files.find(path_portion)
                         match.nil? ? [] : [match]
                       end
      case matching_pages.size
      when 0
        return '' unless error_if_no_match

        Draft.logger.error do
          "No page or asset path has a href that includes the string '#{path_portion}'"
        end
        exit! 1 if @error_if_no_match
      when 1
        matching_pages.first
      else
        Draft.logger.error do # :\n  #{matching_pages.map(&:href).join("\n  ")}
          "More than one page or asset path has a href that includes the string '#{path_portion}'"
        end
        exit! 2 # The user should fix this problem before allowing the website to generate
      end
    rescue StandardError => e
      msg = e.full_message
      if msg.length < 250
        Draft.logger.error { msg }
      else
        Draft.logger.error { "#{msg[0..125]} ... #{msg[-125..msg.length]}" }
      end
    end

    # @return path to root of the collection that doc is a member of
    def root(doc, site)
      return '/index.html' unless doc.respond_to?(:collection)

      collection_name = doc.collection
      docs = site.key?(collection_name) ? site[collection_name] : site.collections[collection_name].docs
      index = docs.find { |d| d.href.end_with? 'index.html' }
      return index.href if index

      docs.min.href
    rescue StandardError => e
      msg = e.full_message
      if msg.length < 250
        Draft.logger.error { msg }
      else
        Draft.logger.error { "#{msg[0..150]} ... #{msg[-150..msg.length]}" }
      end
    end

    module_function :draft?, :draft_html, :page_match, :root
  end
end
