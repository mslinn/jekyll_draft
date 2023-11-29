# @author Copyright 2022 {https://www.mslinn.com Michael Slinn}

require 'jekyll_plugin_support'
require 'yaml'
require_relative 'jekyll_draft/version'

# Unicode record separator https://www.compart.com/en/unicode/U+241E
RECORD_SEPARATOR = "\u{241E}".freeze

DraftError = JekyllSupport.define_error

require_relative 'draft'
require_relative 'else'
require_relative 'if_draft'
