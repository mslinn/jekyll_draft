require 'jekyll_plugin_support'

# Jekyll block tags that detect draft documents
class JekyllDraft < JekyllSupport::JekyllBlock
  PLUGIN_NAME1 = 'if_draft'.freeze
  PLUGIN_NAME2 = 'unless_draft'.freeze
  VERSION = DraftVersion::VERSION

  def render_impl(content)
    true_value, false_value, extra = content.split(RECORD_SEPARATOR)
    raise DraftError, "Warning: More than one else clause detected" if extra

    return Jekyll::Draft.draft?(@page) ? true_value : false_value if @tag_name == PLUGIN_NAME1

    Jekyll::Draft.draft?(@page) ? false_value : true_value
  end

  JekyllPluginHelper.register(self, PLUGIN_NAME1)
  JekyllPluginHelper.register(self, PLUGIN_NAME2)
  PluginMetaLogger.instance.info { "Loaded #{PLUGIN_NAME1.class} and #{PLUGIN_NAME2.class}, v#{DraftVersion::VERSION} plugin." }
end
