require_relative '../../lib/capybara_engine.rb'

describe CapybaraEngine do
  let(:engine) { CapybaraEngine.new }
  let(:current_page) { engine.current_page }

  it "should be able to visit a site" do
    visit_action = stub(action: :visit_site, url: "http://rediff.com") 
    current_page.should_receive(:visit).with("http://rediff.com")
    engine.visit_site visit_action
  end

  it "should be able to fill up forms" 

  it "should be able to yank information" do
    action4 = stub(action: :yank_data, css: "div#matchcontent0")
    current_page.should_receive(:first).with(:css, action4.css)
    data = engine.yank_data action4
  end
end
