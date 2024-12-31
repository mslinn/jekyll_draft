# @author Copyright 2022 {https://www.mslinn.com Michael Slinn}

require 'jekyll_plugin_support'
require 'yaml'
require_relative 'jekyll_draft/version' unless defined?(VERSION)

# Unicode record separator https://www.compart.com/en/unicode/U+241E
RECORD_SEPARATOR = "\u{241E}".freeze

DraftError = JekyllSupport.define_error

# Common code
require_relative 'jekyll_draft/common/draft_html'
require_relative 'jekyll_draft/common/else'
require_relative 'jekyll_draft/common/filters'
require_relative 'jekyll_draft/common/module_functions'

# Code related to processing other pages
require_relative 'jekyll_draft/other_page/filters'
require_relative 'jekyll_draft/other_page/if_draft'

# Code related to processing the containing page
require_relative 'jekyll_draft/containing_page/if_draft'
