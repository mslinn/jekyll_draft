# Jekyll filters that detect if the page that uniquely contains a string is a draft document
module Jekyll
  module OtherPageFilters
    def page_match_is_draft(path_portion)
      Draft.draft? Draft.page_match path_portion
    end

    def page_match_draft_html(path_portion)
      Draft.draft_html Draft.page_match path_portion
    end
  end

  Liquid::Template.register_filter(OtherPageFilters)
end
