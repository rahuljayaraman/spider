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
    if @actions.last.action_type != :yank
      raise YankNotAvailableError 
    end
    if @actions.first.action_type != :visit
      raise VisitNotAvailableError 
    end
    perform_actions
  end

  private
  def perform_actions
    @actions.each do |action|
      case action.action_type
      when :visit
        visit action
      when :form
        form action
      when :yank
        yank action
      end
    end
  end

  def visit action
  end

  def form action
  end

  def yank action
  end
end
