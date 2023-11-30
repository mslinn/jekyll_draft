require 'jekyll_plugin_support'

class Else < JekyllSupport::JekyllTag
  VERSION = '0.1.0'.freeze
  PLUGIN_NAME = 'draft_html'.freeze

  def render_impl
    is_draft = Jekyll::Draft.draft?(@page)

    published_output = @helper.parameter_specified? 'published_output'
    return published_output if is_draft && published_output
    return unless is_draft

    draft_output = @helper.parameter_specified? 'draft_output'
    return draft_output if draft_output

    draft_class = @helper.parameter_specified? 'draft_class'
    dc = " #{draft_class}" if draft_class

    draft_style = @helper.parameter_specified? 'draft_style'
    ds = " style='#{draft_style}'" if draft_style

    " <i class='jekyll_draft#{dc}'#{ds}>Draft</i>"
  end

  JekyllPluginHelper.register(self, PLUGIN_NAME)
  PluginMetaLogger.instance.info { "Loaded #{PLUGIN_NAME.class} v#{DraftVersion::VERSION} plugin." }
end
