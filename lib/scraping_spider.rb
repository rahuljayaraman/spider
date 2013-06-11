class YankNotAvailableError < StandardError
end
class VisitNotAvailableError < StandardError
end

require 'mechanize'

class ScrapingSpider
  attr_accessor :name
  def initialize name, agent
    @name = name
    @actions = []
    @agent = Mechanize.new
  end

  def get_agent
    @agent
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
    if @actions.last.action_type != :yank_data
      raise YankNotAvailableError 
    end
    if @actions.first.action_type != :visit_site
      raise VisitNotAvailableError 
    end
    perform_actions
  end

  private
  def perform_actions
    @actions.each do |action|
      case action.action_type
      when :visit_site
        visit_site action
      when :fill_form
        fill_form action
      when :yank_data
        yank_data action
      end
    end
  end

  def visit_site action
  end

  def fill_form action
  end

  def yank_data action
  end
end
