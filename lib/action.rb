class Action
  attr_accessor :action_type, :url, :form_name, :field_name, :text, :div

  def initialize params
    @action_type = params.fetch :action_type
    case @action_type
    when :visit_site
      @url = params.fetch :url
    when :fill_form
      @form_name = params.fetch :form_name
      @field_name = params.fetch :field_name
      @text = params.fetch :text
    when :yank_data
      @div = params.fetch :div
    end
  end
end
