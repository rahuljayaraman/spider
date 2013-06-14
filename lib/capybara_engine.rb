require "capybara"
require "capybara/dsl"
require "capybara-webkit"
Capybara.run_server = false
Capybara.default_wait_time = 10

class CapybaraEngine
  attr_accessor :current_page

  def initialize
    @current_page = Capybara::Session.new(:webkit)
  end

  def visit_site action
    current_page.visit action.url
  end

  def fill_form action
    fields = action.fields
    fields.each do |field|
      current_page.fill_in field.fetch(:field_name), with: field.fetch(:text)
    end
    current_page.first("input[type=submit]").click
  end

  def click_on action
    current_page.click_on(action.link)
  end

  def yank_data action
    current_page.first(:css, action.css).text rescue nil
  end
end
