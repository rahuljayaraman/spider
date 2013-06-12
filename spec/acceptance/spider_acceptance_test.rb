require_relative '../../lib/scraping_spider'
require_relative '../../lib/action'
require_relative '../../lib/mechanize_engine'

describe "Spider" do
  it "should be able to hook onto sites & fetch information" do
    spider = ScrapingSpider.new "Test"
    action1 = Action.new action_type: :visit_site, url: "http://www.google.com"
    action2 = Action.new action_type: :fill_form, form_name: "f", field_name: "q", text: "Apple"
    action3 = Action.new action_type: :yank_data, div: "#resultStats"
    spider.add_to_web(action1, action2, action3)
    spider.crawl.should include "About" 
  end
end
