# Jekyll block tags that detect draft documents
class DraftPageBase < JekyllSupport::JekyllBlock
  IF_DRAFT     = 'if_page_draft'.freeze
  UNLESS_DRAFT = 'unless_page_draft'.freeze
  VERSION      = DraftVersion::VERSION.freeze

  # Content has a true clause, and optionally might have an else clause
  # Clauses can reference two variables: path_portion and matched_page
  #   path_portion is specified as the sole argument to this block tag
  #   matched_path is the APage with an href that uniquely includes path_portion,
  #                or nil if no matching APage was found
  def render_impl(content)
    true_content, false_content, extra_content = content.split(RECORD_SEPARATOR)
    raise DraftError, 'Warning: More than one else clause detected' if extra_content

    @path_portion = @argument_string.strip
    raise DraftError, 'Error: path_portion was not specified' unless @path_portion

    configure

    @matched_page = if @path_portion.start_with?('#')
                      @page
                    else
                      Jekyll::Draft.page_match(@path_portion, error_if_no_match:   @error_if_no_match,
                                                              verify_unique_match: @verify_unique_match)
                    end
    raise DraftError, "Error: path_portion='#{@path_portion}' does not specify a local page." if @matched_page == :non_local_url

    is_draft = Jekyll::Draft.draft? @matched_page
    clause_value = if @tag_name == IF_DRAFT
                     is_draft ? true_content : false_content
                   else # UNLESS_DRAFT
                     is_draft ? false_content : true_content
                   end
    process_variables clause_value
  rescue StandardError => e
    msg = e.full_message
    if msg.length < 250
      @logger.error { msg }
    else
      @logger.error { "#{msg[0..125]} ... #{msg[-125..msg.length]}" }
    end
    exit!
  end

  private

  def configure
    tag_config = @config['if_draft']
    if tag_config
      @error_if_no_match = tag_config['error_if_no_match'] # defaults true
      @error_if_no_match = @error_if_no_match ? @error_if_no_match == true : true

      @verify_unique_match = true # tag_config['verify_unique_match'] == true # defaults false
    else
      @logger.warn { "There is no entry for #{@tag_name} in _config.yml; default values were applied." }
    end

    env_var = ENV.fetch('if_draft_error_if_no_match', nil) # Environment variable overrides _config.yml setting
    @error_if_no_match = env_var != 'false' if env_var

    env_var = ENV.fetch('if_draft_verify_unique_match', nil) # Environment variable overrides _config.yml setting
    @verify_unique_match = env_var != 'false' if env_var
  end

  # @param markup [String] might contain <<path_portion>> or <<matched_page.url>>
  def process_variables(markup)
    return '' unless markup

    path_portion = @path_portion # add this to the binding
    matched_page = @matched_page.instance_of?(Enumerator) ? @matched_page.first : @matched_page # add this to the binding
    _ = path_portion == matched_page # Just to keep the lint checker happy
    markup.gsub!(/(<<([^<>]*)>>)/) do # gsub replaces token with the return value of this block
      replace_token Regexp.last_match[1], Regexp.last_match[2], binding
    end
    markup
  rescue StandardError => e
    msg = e.full_message
    if msg.length < 250
      @logger.error { msg }
    else
      @logger.error { "#{msg[0..125]} ... #{msg[-125..msg.length]}" }
    end
  end

  def replace_token(token, expression, binding)
    if expression == 'matched_page'
      expression = case matched_page
                   when String
                     matched_page
                   when APage
                     'matched_page&.href'
                   when LruFile
                     'matched_page&.url'
                   else
                     @logger.warn do
                       <<~END_MSG
                         The type #{matched_page.class} has an invalid valueexpression #{token}.
                       END_MSG
                     end
                     exit!
                   end
      @logger.warn do
        <<~END_MSG
          The expression #{token} should either specify a property, for example <<matched_page&.href>>,
          or a hash value, for example <<matched_page['title']>>.
          The expression was modified to <<#{expression}>> for you.
        END_MSG
      end
    else
      puts expression
    end
    result = eval expression, binding # rubocop:disable Security/Eval
    result.to_s
  end
end

class IfPageDraft < DraftPageBase
  JekyllSupport::JekyllPluginHelper.register(self, IF_DRAFT, quiet: true)
end

class UnlessPageDraft < DraftPageBase
  JekyllSupport::JekyllPluginHelper.register(self, UNLESS_DRAFT, quiet: true)
end
