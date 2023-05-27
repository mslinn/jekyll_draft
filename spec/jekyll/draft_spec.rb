require 'jekyll'
require 'jekyll_plugin_logger'
require 'rspec/match_ignoring_whitespace'
require_relative '../../lib/jekyll_draft'
require_relative 'mocks'

RSpec.describe(Jekyll::Draft) do
  include described_class

  let(:logger) do
    PluginMetaLogger.instance.new_logger(self, PluginMetaLogger.instance.config)
  end

  let(:parse_context) { TestParseContext.new }

  it 'detects drafts' do
    # expect(result).to match_ignoring_whitespace <<-END_RESULT
    #   <img src="./blah.webp">
    # END_RESULT
  end
end
