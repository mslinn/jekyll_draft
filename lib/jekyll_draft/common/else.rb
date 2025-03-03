class ElseBase < JekyllSupport::JekyllTag
  VERSION = '0.1.0'.freeze

  ELSE_DRAFT              = 'else_if_draft'.freeze
  ELSE_IF_NOT_DRAFT       = 'else_if_not_draft'.freeze
  ELSE_IF_PAGE_DRAFT      = 'else_if_page_draft'.freeze
  ELSE_UNLESS_DRAFT       = 'else_unless_draft'.freeze
  ELSE_UNLESS_PAGE_DRAFT  = 'else_unless_page_draft'.freeze

  def render_impl
    RECORD_SEPARATOR
  end
end

class ElseDraft < ElseBase
  ::JekyllSupport::JekyllPluginHelper.register(self, ELSE_DRAFT, quiet: true)
end

class ElseNotDraft < ElseBase
  ::JekyllSupport::JekyllPluginHelper.register(self, ELSE_IF_NOT_DRAFT, quiet: true)
end

class ElsePageDraft < ElseBase
  ::JekyllSupport::JekyllPluginHelper.register(self, ELSE_IF_PAGE_DRAFT, quiet: true)
end

class ElseUnlessDraft < ElseBase
  ::JekyllSupport::JekyllPluginHelper.register(self, ELSE_UNLESS_DRAFT, quiet: true)
end

class ElseUnlessPageDraft < ElseBase
  ::JekyllSupport::JekyllPluginHelper.register(self, ELSE_UNLESS_PAGE_DRAFT, quiet: true)
end
