# Jekyll filters that detects if the containing page is a draft document
module Jekyll
  module ContainingPageFilters
    def is_draft(doc) # rubocop:disable Naming/PredicateName
      Draft.draft? doc
    end

    def draft_html(doc)
      Draft.draft_html doc
    end

    def root(doc, site)
      Draft.root(doc, site)
    end
  end

  Liquid::Template.register_filter(ContainingPageFilters)
end
