class YankNotAvailableError < StandardError
end
class VisitNotAvailableError < StandardError
end
class DataNotFound < StandardError
end

class ScrapingSpider
  attr_accessor :name, :actions, :engine
  def initialize name
    @name = name
    @actions = []
    @engine = MechanizeEngine.new
  end

  def add_to_web *actions
    actions.each do |action|
      @actions << action if action.respond_to? :action_type
    end
  end

  def crawl
    if @actions.last.action_type != :yank_data
      raise YankNotAvailableError 
    end
    if @actions.first.action_type != :visit_site
      raise VisitNotAvailableError 
    end
    raise DataNotFound unless perform_actions
    perform_actions
  end

  private
  def perform_actions
    @actions.each do |action|
      case action.action_type
      when :visit_site
        @engine.visit_site action
      when :fill_form
        @engine.fill_form action
      when :yank_data
        return @engine.yank_data action
      end
    end
  end
end
