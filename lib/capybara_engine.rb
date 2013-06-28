require "capybara"
require "capybara/dsl"
require 'capybara/poltergeist'

Capybara.run_server = false
Capybara.default_wait_time = 10

class CapybaraEngine
  attr_accessor :current_page

  def initialize
    @current_page = Capybara::Session.new(:poltergeist)
    # @current_page.driver.headers = {
    #   "User-Agent" => "Mozilla/5.0 (X11; Linux i686) AppleWebKit/537.31 (KHTML, like Gecko) Chrome/26.0.1410.63 Safari/537.31"
    # }
  end

  def visit_site action
    current_page.visit action.url
  end

  def fill_form action
    fields = action.fields
    fields.each do |field|
      current_page.fill_in field.fetch(:field_name), with: field.fetch(:text)
    end
    form = current_page.find(:fillable_field, fields.last.
                             fetch(:field_name)).
                             first(:xpath, "ancestor::form")
    submit_button = form.first(:xpath, ".//*[@type='submit']") || form.first(:xpath, ".//a")
    submit_button.click
  end

  def click action
    current_page.first(:link_or_button, action.link).click
  end

  def yank_data action
    current_page.first(:css, action.css).text rescue nil
  end
end
