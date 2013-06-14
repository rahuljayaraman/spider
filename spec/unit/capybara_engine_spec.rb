require_relative '../../lib/capybara_engine.rb'
require 'ostruct'

describe CapybaraEngine do
  before(:all) do
    @engine = CapybaraEngine.new
    visit_action = OpenStruct.
      new(action: :visit_site, url: "http://rediff.com") 
    @engine.visit_site visit_action
  end

  it "should be able to visit a site" do
    @engine.current_page.should have_content "Rediff"
  end

  it "should be able to fill up forms" do
    previous_page = @engine.current_page
    action2 = stub(action: :fill_form, fields: [{ field_name: "srchword", text: "cricket" }]) 
    @engine.fill_form action2
    @engine.current_page != previous_page
  end

  it "should be able to yank information" do
    action4 = stub(action: :yank_data, css: "div#matchcontent0")
    data = @engine.yank_data action4
    data.should include "Scorecard"
  end
end
