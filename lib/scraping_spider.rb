class YankNotAvailableError < StandardError
end
class VisitNotAvailableError < StandardError
end
class DataNotFound < StandardError
end

class ScrapingSpider
  attr_accessor :name, :instructions, :engine
  def initialize name
    @name = name
    @instructions = []
    @engine = MechanizeEngine.new
  end

  def feed_instructions *instructions
    instructions.each do |action|
      @instructions << action if action.respond_to? :action
    end
  end

  def forget_instructions!
    @instructions = []
  end

  def crawl
    if @instructions.last.action != :yank_data
      raise YankNotAvailableError 
    end
    if @instructions.first.action != :visit_site
      raise VisitNotAvailableError 
    end
    raise DataNotFound unless perform
    perform
  end

  private
  def perform
    @instructions.each do |instruction|
      case instruction.action
      when :visit_site
        @engine.visit_site instruction
      when :fill_form
        @engine.fill_form instruction
      when :yank_data
        return @engine.yank_data instruction
      end
    end
  end
end
