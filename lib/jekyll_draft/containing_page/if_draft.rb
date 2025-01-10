# Jekyll block tags that detect draft documents
class DraftBase < JekyllSupport::JekyllBlock
  IF_DRAFT     = 'if_draft'.freeze
  UNLESS_DRAFT = 'unless_draft'.freeze
  VERSION      = DraftVersion::VERSION.freeze

  def render_impl(content)
    true_value, false_value, extra = content.split(RECORD_SEPARATOR)
    raise DraftError, 'Warning: More than one else clause detected' if extra

    if @tag_name == IF_DRAFT
      return ::Jekyll::Draft.draft?(@page) ? true_value : false_value
    end

    ::Jekyll::Draft.draft?(@page) ? false_value : true_value
  end
end

class IfDraft < DraftBase
  ::JekyllSupport::JekyllPluginHelper.register(self, IF_DRAFT)
end

class UnlessDraft < DraftBase
  ::JekyllSupport::JekyllPluginHelper.register(self, UNLESS_DRAFT, quiet: true)
end
