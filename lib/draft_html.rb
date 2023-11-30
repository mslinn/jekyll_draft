require 'jekyll_plugin_support'

class DraftHtml < JekyllSupport::JekyllTag
  VERSION = '0.1.0'.freeze
  DRAFT_HTML = 'draft_html'.freeze unless defined? Else::VERSION

  def render_impl
    is_draft = Jekyll::Draft.draft?(@page)

    published_output = @helper.parameter_specified? 'published_output'
    return published_output if !is_draft && published_output
    return unless is_draft

    draft_output = @helper.parameter_specified? 'draft_output'
    return draft_output if draft_output

    draft_class = @helper.parameter_specified? 'class'
    dc = " #{draft_class}" if draft_class

    draft_style = @helper.parameter_specified? 'style'
    ds = " style='#{draft_style}'" if draft_style

    " <i class='jekyll_draft#{dc}'#{ds}>Draft</i>"
  end

  JekyllPluginHelper.register(self, DRAFT_HTML)
end
