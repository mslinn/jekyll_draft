require 'jekyll_plugin_support'

class Else < JekyllSupport::JekyllTag
  VERSION = '0.1.0'.freeze
  PLUGIN_NAME1 = 'else_if_draft'.freeze
  PLUGIN_NAME2 = 'else_if_not_draft'.freeze

  def render_impl
    RECORD_SEPARATOR
  end

  JekyllPluginHelper.register(self, PLUGIN_NAME1)
  JekyllPluginHelper.register(self, PLUGIN_NAME2)
  PluginMetaLogger.instance.info { "Loaded #{PLUGIN_NAME1.class} and #{PLUGIN_NAME2.class}, v#{DraftVersion::VERSION} plugin." }
end
