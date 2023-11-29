require 'jekyll_plugin_support'

# Jekyll inline plugin that detects draft documents
class JekyllDraft < JekyllSupport::JekyllBlock
  PLUGIN_NAME = 'if_draft'.freeze
  VERSION = DraftVersion::VERSION

  def if_draft
    true_value, false_value, extra = @content.split(RECORD_SEPARATOR)
    raise DraftError, "Warning: More than one else clause detected" if extra

    is_draft ? true_value : false_value
  end

  def is_draft # rubocop:disable Naming/PredicateName
    Draft.draft? @page
  end

  JekyllPluginHelper.register(self, PLUGIN_NAME)
  PluginMetaLogger.instance.info { "Loaded #{PLUGIN_NAME.class} v#{DraftVersion::VERSION} plugin." }
end
