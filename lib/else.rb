require 'jekyll_plugin_support'

class Else < JekyllSupport::JekyllTag
  VERSION = '0.1.0'.freeze
  PLUGIN_NAME = 'else'.freeze

  def render_impl
    RECORD_SEPARATOR
  end

  JekyllPluginHelper.register(self, PLUGIN_NAME)
  PluginMetaLogger.instance.info { "Loaded #{PLUGIN_NAME.class} v#{DraftVersion::VERSION} plugin." }
end
