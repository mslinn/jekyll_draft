require 'jekyll_plugin_support'

class Else < JekyllSupport::JekyllTag
  VERSION = '0.1.0'.freeze
  PLUGIN_NAME = 'draft_html'.freeze

  def render_impl
    " <i class='jekyll_draft'>Draft</i>" if Jekyll::Draft.draft?(@page)
  end

  JekyllPluginHelper.register(self, PLUGIN_NAME)
  PluginMetaLogger.instance.info { "Loaded #{PLUGIN_NAME.class} v#{DraftVersion::VERSION} plugin." }
end
