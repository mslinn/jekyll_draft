# frozen_string_literal: true

# @author Copyright 2022 {https://www.mslinn.com Michael Slinn}

require "jekyll_plugin_logger"
require 'yaml'

# Detects draft documents
module Draft
  PLUGIN_NAME = "draft"

  def draft?(doc)
    return !doc.data['published'] if doc.respond_to?(:data) && doc.data.key?('published')

    return !doc['published'] if doc.respond_to?(:key) && doc.key?('published')

    return !doc.published if doc.respond_to?(:published)

    return doc['draft'] if doc.respond_to?(:key) && doc.key?('draft')

    false
  end

  def draft_html(doc)
    return '' unless draft?(doc)

    " <i class='bg_light_yellow' style='padding-left: 0.5em; padding-right: 0.5em;'>Draft</i>"
  end

  def root(doc)
    docs = @context.registers[:site].collections[doc.collection].docs
    index = docs.find { |d| d.url.end_with? "index.html" }
    return index.url if index

    docs.min.url
  end

  module_function :draft?, :draft_html, :root
end

PluginMetaLogger.instance.info { "Loaded Draft plugin." }
Liquid::Template.register_filter(Draft)
