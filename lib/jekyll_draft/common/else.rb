require 'jekyll_plugin_support'

class ElseBase < JekyllSupport::JekyllTag
  VERSION = '0.1.0'.freeze
  ELSE_DRAFT = 'else_if_draft'.freeze
  ELSE_NOT_DRAFT = 'else_if_not_draft'.freeze

  def render_impl
    RECORD_SEPARATOR
  end
end

class ElseDraft < ElseBase
  ::JekyllSupport::JekyllPluginHelper.register(self, ELSE_DRAFT)
end

class ElseNotDraft < ElseBase
  ::JekyllSupport::JekyllPluginHelper.register(self, ELSE_NOT_DRAFT)
end
