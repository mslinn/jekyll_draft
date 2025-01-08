Registers = Struct.new(:page, :site)

# Mock for Collections
class Collections
  def values
    []
  end
end

# Mock for Site
class SiteMock
  attr_reader :config

  def initialize
    @config = YAML.safe_load(File.read('../demo/_config.yml'))
    @config['env'] = { 'JEKYLL_ENV' => 'development' }
  end

  def collections
    Collections.new
  end
end

# Mock for Liquid::Context
class TestLiquidContext < Liquid::Context
  def initialize
    super

    page = {
      "content"     => "blah blah",
      "description" => "Jekyll draft demo",
      "dir"         => "/",
      "excerpt"     => nil,
      "href"        => "/index.html",
      "layout"      => "default",
      "name"        => "index.html",
      "path"        => "index.html",
      "title"       => "Welcome",
      "url"         => "/",
    }

    @content = "This is the content"
    @registers = Registers.new(
      page,
      SiteMock.new
    )
  end
end

# Mock for Liquid::ParseContent
class TestParseContext < Liquid::ParseContext
  attr_reader :line_number, :registers

  def initialize
    super
    @line_number = 123

    @registers = Registers.new(
      { 'path' => 'path/to/page.html' },
      SiteMock.new
    )
  end
end
