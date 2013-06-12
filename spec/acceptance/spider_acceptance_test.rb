require_relative '../../lib/scraping_spider'
require_relative '../../lib/action'
require_relative '../../lib/mechanize_engine'

describe "Spider" do
  let(:spider)  { ScrapingSpider.new "Test" }

  it "should be able to visit site & fetch data" do
    action1 = Action.new action_type: :visit_site, url: "http://www.google.com"
    action2 = Action.new action_type: :yank_data, div: "font#addlang"
    spider.add_to_web(action1, action2)
    spider.crawl.should include "offered in" 
  end

  it "should be able to visit site, fill form & fetch data" do
    action1 = Action.new action_type: :visit_site, url: "http://www.google.com"
    action2 = Action.new action_type: :fill_form, form_name: "f", field_name: "q", text: "Apple"
    action3 = Action.new action_type: :yank_data, div: "#resultStats"
    spider.add_to_web(action1, action2, action3)
    spider.crawl.should include "About" 
  end

  it "should raise error when unable to yank information" do
    action1 = Action.new action_type: :visit_site, url: "http://foobar.com"
    action2 = Action.new action_type: :yank_data, div: "#doesnotexist"
    spider.add_to_web(action1, action2)
    expect { spider.crawl }.to raise_exception DataNotFound
  end
end
