require_relative '../../lib/mechanize_engine.rb'

describe MechanizeEngine do
  let(:engine) { MechanizeEngine.new }

  it "use mechanize actions to visit pages" do
    action = stub(action_type: :visit_site, url: "http://google.com") 
    engine.visit_site action
    engine.current_page.should respond_to :forms

    action2 = stub(action_type: :fill_form, form_name: "f", field_name: "q", text: "Apple") 
    previous_page = engine.current_page
    engine.fill_form action2
    previous_page.should_not == engine.current_page
    
    action3 = stub(action_type: :yank_data, div: "div#resultStats") 
    data = engine.yank_data action3
    data.should include "About"
  end
end
