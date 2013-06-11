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
    current_page.search(action.div).first.text
  end

  def current_page
    agent.current_page
  end
end
