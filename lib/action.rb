class Action
  def initialize params
    @action_type = params.fetch :action_type
    case @action_type
    when :visit
      @url = params.fetch :url
    end
  end
end
