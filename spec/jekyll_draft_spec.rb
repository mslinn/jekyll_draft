# frozen_string_literal: true

require "jekyll"
require_relative "../lib/jekyll_draft"

RSpec.describe(jekyllDraftName) do
  include jekyllDraftName

  it "verifies basename" do
    expect(basename("a/b/c/d/e.html")).to be_true
  end
end
