class DataNotFound < StandardError
end

require 'mechanize'

class MechanizeEngine
  attr_accessor :agent

  def visit_site action
    @agent = Mechanize.new
    agent.get(action.url)
  end

  def fill_form action
    form = current_page.form_with name: action.form_name
    field = form.field_with name: action.field_name
    field.value = action.text
    @agent.submit(form)
  end

  def yank_data action
    page = current_page.search(action.div)
    raise DataNotFound if page.empty?
    page.first.text
  end

  def current_page
    raise DataNotFound unless agent.current_page
    agent.current_page
  end
end
