require 'jekyll'
require 'jekyll_plugin_logger'
require_relative '../../lib/jekyll_draft'

RSpec.describe(Jekyll::Draft) do
  include described_class

  it 'detects drafts' do
    pending('Not yet')
  end
end
