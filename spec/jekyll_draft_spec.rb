# frozen_string_literal: true

require 'jekyll'
require 'jekyll_plugin_logger'
require_relative '../lib/jekyll_draft'

RSpec.describe(Jekyll::Draft) do # rubocop:disable Metrics/BlockLength
  include Jekyll::Draft

  let(:page_draft) do
    page_ = double('Jekyll::Page')
    allow(page_).to receive(:draft) { true }
    page_
  end
  let(:page_not_draft) do
    page_ = double('Jekyll::Page')
    allow(page_).to receive(:draft) { false }
    page_
  end
  let(:page_published) do
    page_ = double('Jekyll::Page')
    allow(page_).to receive(:published) { true }
    page_
  end
  let(:page_not_published) do
    page_ = double('Jekyll::Page')
    allow(page_).to receive(:published) { false }
    page_
  end

  it 'detects drafts' do
    expect(draft?(page_draft)).to be_truthy
    expect(draft?(page_not_draft)).to be_falsey
    expect(draft?(page_published)).to be_falsey
    expect(draft?(page_not_published)).to be_truthy
  end
end
