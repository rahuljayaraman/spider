class Action
  def initialize params
    @action_type = params.fetch :action_type
    case @action_type
    when :visit_site
      @url = params.fetch :url
    when :fill_form
      @form_name = params.fetch :form_name
      @field_name = params.fetch :field_name
    end
  end
end
