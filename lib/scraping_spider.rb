class YankNotAvailableError < StandardError
end
class VisitNotAvailableError < StandardError
end
class DataNotFound < StandardError
end
class InstructionsNotSet < StandardError
end
class InvalidInstruction < StandardError
end
require 'capybara_engine'
require 'instruction'

class ScrapingSpider
  attr_accessor :name, :instructions, :engine
  def initialize name
    @name = name
    @instructions = []
    # @engine = MechanizeEngine.new
    @engine = CapybaraEngine.new
  end

  def feed_instructions *instructions
    if instructions.first.respond_to? :action
      instructions.each do |instruction|
        @instructions << instruction
      end
    elsif instructions.first.respond_to? :values
      instructions.each do |inst|
        value = inst.values.first
        value[:action] = value[:action].to_sym
        instruction = Instruction.new value
        @instructions << instruction if instruction.respond_to? :action
      end
    else
      raise InvalidInstruction
    end
  end

  def forget_instructions!
    @instructions = []
  end

  def crawl
    raise InstructionsNotSet if @instructions.empty?
    if @instructions.last.action != :yank_data
      raise YankNotAvailableError 
    end
    if @instructions.first.action != :visit_site
      raise VisitNotAvailableError 
    end
    perform
  end

  private
  def perform
    @data_returned = []
    @instructions.each do |instruction|
      case instruction.action
      when :visit_site
        @engine.visit_site instruction
      when :fill_form
        @engine.fill_form instruction
      when :click
        @engine.click instruction
      when :yank_data
        @data_returned << @engine.yank_data(instruction)
      end
    end
    @data_returned
  end
end
