# frozen_string_literal: true

require 'jekyll'
require 'jekyll_plugin_logger'
require_relative '../lib/jekyll_draft'

RSpec.describe(Jekyll::Draft) do
  include Jekyll::Draft

  let(:page_draft) do
    page_ = double('Jekyll::Page')
    allow(page_).to receive(:published) { true }
    allow(page_).to receive(:draft) { true }
    page_
  end
  let(:page_not_published) do
    page_ = double('Jekyll::Page')
    allow(page_).to receive(:published) { false } # higher priority
    allow(page_).to receive(:draft) { true } # lower priority
    page_
  end
  let(:page_not_published_or_draft) do
    page_ = double('Jekyll::Page')
    allow(page_).to receive(:published) { false } # higher priority
    allow(page_).to receive(:draft) { false } # lower priority
    page_
  end

  it 'detects drafts' do
    expect(draft?(page_draft)).to be_falsey
    expect(draft?(page_not_published)).to be_truthy
    expect(draft?(page_not_published_or_draft)).to be_truthy
  end
end
