# Jekyll block tags that detect draft documents
class DraftPageBase < JekyllSupport::JekyllBlock
  IF_DRAFT     = 'if_page_draft'.freeze
  UNLESS_DRAFT = 'unless_page_draft'.freeze
  VERSION      = DraftVersion::VERSION.freeze

  def render_impl(content)
    true_value, false_value, extra = content.split(RECORD_SEPARATOR)
    raise DraftError, "Warning: More than one else clause detected" if extra

    page_fragment = @argument_string.strip
    is_draft = ::Jekyll::Draft.draft? ::Jekyll::Draft.page_match page_fragment

    if @tag_name == IF_DRAFT
      return is_draft ? true_value : false_value
    end

    is_draft ? false_value : true_value # unless_draft
  end
end

class IfPageDraft < DraftPageBase
  ::JekyllSupport::JekyllPluginHelper.register(self, IF_DRAFT)
end

class UnlessPageDraft < DraftPageBase
  ::JekyllSupport::JekyllPluginHelper.register(self, UNLESS_DRAFT)
end
