require_relative '../../lib/scraping_spider'
require_relative '../../lib/instruction'

describe "Spider" do
  let(:spider)  { ScrapingSpider.new "Test" }

  it "should be able to visit site & fetch data" do
    instruction1 = Instruction.new action: :visit_site, url: "http://www.google.com"
    instruction2 = Instruction.new action: :yank_data, css: "font#addlang"
    spider.feed_instructions(instruction1, instruction2)
    spider.crawl.should include "offered in" 
  end

  it "should be able to visit a javascript enabled site & fetch data" do
    instruction1 = Instruction.new action: :visit_site, url: "http://www.rediff.com"
    instruction2 = Instruction.new action: :yank_data, css: "p.t_date"
    spider.feed_instructions(instruction1, instruction2)
    spider.crawl.should include "Last Updated" 
  end

  it "should be able to visit site, fill form & fetch data" do
    instruction1 = Instruction.new action: :visit_site, url: "http://www.google.com"
    instruction2 = Instruction.new(
      action: :fill_form, 
      fields: [{ field_name: "q", text: "Apple" }]
    ) 
    instruction3 = Instruction.new action: :yank_data, css: "#resultStats"
    spider.feed_instructions(instruction1, instruction2, instruction3)
    spider.crawl.should include "About" 
  end

  it "should raise error when unable to yank information" do
    instruction1 = Instruction.new action: :visit_site, url: "http://foobar.com"
    instruction2 = Instruction.new action: :yank_data, css: "#doesnotexist"
    spider.feed_instructions(instruction1, instruction2)
    expect { spider.crawl }.to raise_exception DataNotFound
  end
end
