class Instruction
  attr_accessor :action, :url, :fields, :text, :css, :link

  def initialize params
    @action = params.fetch :action
    case @action
    when :visit_site
      @url = params.fetch :url
    when :fill_form
      @fields = params.fetch :fields
    when :yank_data
      @css = params.fetch :css
    when :click
      @link = params.fetch :link
    end
  end

  def self.available_set
    [:visit_site, :fill_form, :yank_data, :click]
  end
end
