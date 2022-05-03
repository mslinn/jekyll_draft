# frozen_string_literal: true

# @author Copyright 2022 {https://www.mslinn.com Michael Slinn}

require "jekyll_plugin_logger"
require 'yaml'

# Detects draft documents
module Jekyll
  # Define these methods outside of the filter module so they can be invoked externally
  module Draft
    def draft?(doc)
      abort "Jekyll:Draft.draft? doc is nil!".red if doc.nil?

      # puts "draft? invoked from #{doc.path}"
      return !doc.data['published'] if doc.respond_to?(:data) && doc.data.key?('published')

      return doc.published==false if doc.respond_to?(:published)

      return doc['published']==false if doc.respond_to?(:[]) || (doc.respond_to?(:key) && doc.key?('published'))

      return doc.draft if doc.respond_to?(:draft)

      return doc['draft'] if doc.respond_to?(:[]) || (doc.respond_to?(:key) && doc.key?('draft'))

      false
    end

    def draft_html(doc)
      # puts "draft_html invoked from #{doc.path}"
      return '' unless draft?(doc)

      " <i class='bg_light_yellow' style='padding-left: 0.5em; padding-right: 0.5em;'>Draft</i>"
    end

    def root(doc, site)
      # puts "root invoked from #{doc.path}"
      return "/index.html" unless doc.respond_to?(:collection)

      collection_name = doc.collection
      docs = site.key?(collection_name) ? site[collection_name] : site.collections[collection_name].docs
      index = docs.find { |d| d.url.end_with? "index.html" }
      return index.url if index

      docs.min.url
    end

    module_function :draft?, :draft_html, :root
  end

  module DraftFilter
    def is_draft(doc)
      Draft::draft?(doc)
    end

    def draft_html(doc)
      Draft::draft_html(doc)
    end

    # DraftFilter.singleton_class.included_modules
    #   [JSON::Ext::Generator::GeneratorMethods::Object, PP::ObjectMixin, Kernel]
    def root(doc, site)
      Draft::root(doc, site)
    end
  end

  Liquid::Template.register_filter(DraftFilter)
  PluginMetaLogger.instance.info { "Loaded DraftFilter plugin." }
end
