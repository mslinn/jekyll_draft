require 'rspec/match_ignoring_whitespace'
require_relative 'lib/draft'

class JekyllPluginHelperOptionsTest
  RSpec.describe Jekyll::Draft do
    it 'does nothing' do
      # TODO: mock doc
      # described_class.draft? doc
      expect(true).to be_truthy
    end
  end
end
