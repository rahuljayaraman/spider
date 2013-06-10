class YankNotAvailableError < StandardError
end

class Spidy
  attr_accessor :name
  def initialize name
    @name = name
    @actions = []
  end

  def add_to_web *actions
    actions.each do |action|
      @actions << action if action.respond_to? :action_type
    end
  end

  def actions
    @actions
  end

  def crawl
    if @actions.last.action_type != :yank
      raise YankNotAvailableError 
    end

    @actions.each do |action|
      action.perform
    end
  end
end
