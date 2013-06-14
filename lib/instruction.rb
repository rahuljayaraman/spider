class Instruction
  attr_accessor :action, :url, :fields, :text, :css

  def initialize params
    @action = params.fetch :action
    case @action
    when :visit_site
      @url = params.fetch :url
    when :fill_form
      @fields = params.fetch :fields
    when :yank_data
      @css = params.fetch :css
    end
  end
end
