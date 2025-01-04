# Jekyll block tags that detect draft documents
class DraftPageBase < JekyllSupport::JekyllBlock
  IF_DRAFT     = 'if_page_draft'.freeze
  UNLESS_DRAFT = 'unless_page_draft'.freeze
  VERSION      = DraftVersion::VERSION.freeze

  # Content has a true clause, and optionally might have an else clause
  # Clauses can reference two variables: path_portion and matched_page
  #   path_portion is specified as the sole argument to this block tag
  #   matched_path is the Jekyll::Page with a URL that uniquely includes path_portion,
  #                or nil if no matching Jekyll::Page was found
  def render_impl(content)
    true_content, false_content, extra_content = content.split(RECORD_SEPARATOR)
    raise DraftError, "Warning: More than one else clause detected" if extra_content

    @path_portion = @argument_string.strip
    raise DraftError, "Error: path_portion was not specified" unless @path_portion

    @matched_page = @path_portion.start_with?('#') ? @page : Jekyll::Draft.page_match(@path_portion)
    raise DraftError, "Error: path_portion='#{@path_portion}' does not specify a local page." if @matched_page == :non_local_url

    is_draft = Jekyll::Draft.draft? @matched_page
    clause_value = if @tag_name == IF_DRAFT
                     is_draft ? true_content : false_content
                   else # UNLESS_DRAFT
                     is_draft ? false_content : true_content
                   end
    process_variables clause_value
  rescue StandardError => e
    puts e.full_message
    exit!
  end

  def process_variables(markup)
    return '' unless markup

    path_portion = @path_portion # add this to the binding
    matched_page = @matched_page # add this to the binding
    _ = path_portion == matched_page # Just to keep the lint checker happy
    markup.gsub!(/(<<([^<>]*)>>)/) do
      token = Regexp.last_match[1] # gsub replaces token with the return value of this block
      expression = Regexp.last_match[2]
      if expression == 'matched_page' && matched_page.class != String
        @logger.warn do
          expression = 'matched_page.url'
          <<~END_MSG
            The expression #{token} should either specify a property, for example <<matched_page.url>>,
            or a hash value, for example <<matched_page['title']>>.
            The expression was modified to <<matched_page.url>> for you.
          END_MSG
        end
      end
      result = eval expression, binding # rubocop:disable Security/Eval
      result.to_s
    end
    markup
  rescue StandardError => e
    @logger.error { e.full_message }
  end
end

class IfPageDraft < DraftPageBase
  JekyllSupport::JekyllPluginHelper.register(self, IF_DRAFT)
end

class UnlessPageDraft < DraftPageBase
  JekyllSupport::JekyllPluginHelper.register(self, UNLESS_DRAFT)
end
