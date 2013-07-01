require_relative '../../lib/scraping_spider'
require_relative '../../lib/instruction'

describe "Spider" do
  let(:spider)  { ScrapingSpider.new "Test" }

  it "should be able to visit site & fetch data" do
    instruction1 = Instruction.new action: :visit_site, url: "http://www.google.com"
    instruction2 = Instruction.new action: :yank_data, css: "font#addlang"
    spider.feed_instructions(instruction1, instruction2)
    spider.crawl.first.should include "offered in" 
  end

  it "should be able to visit a javascript enabled site & fetch data" do
    instruction1 = Instruction.new action: :visit_site, url: "http://www.rediff.com"
    instruction2 = Instruction.new action: :yank_data, css: "p.t_date"
    spider.feed_instructions(instruction1, instruction2)
    spider.crawl.first.should include "Last Updated" 
  end

  it "should be able to redirect by clicking on a link" do
    instruction1 = Instruction.new action: :visit_site, url: "http://www.rediff.com"
    instruction2 = Instruction.new action: :click, link: "Books"
    instruction3 = Instruction.new action: :yank_data, css: "h4.red_picks_hd"
    spider.feed_instructions(instruction1, instruction2, instruction3)
    spider.crawl.first.should include "PICKS" 
  end

  it "should be able to visit site, fill form & fetch data" do
    instruction1 = Instruction.new action: :visit_site, url: "http://google.com"
    instruction2 = Instruction.new(
      action: :fill_form, 
      fields: [
        { field_name: "q", text: "Lumia" }
      ]
    ) 
    instruction3 = Instruction.new action: :yank_data, css: "div#resultStats"
    spider.feed_instructions(instruction1, instruction2, instruction3)
    spider.crawl.first.should include "About" 
  end

  it "should be able to yank twice" do
    instruction1 = {"1" => { action: "visit_site", url: "http://www.google.com" } }
    instruction2 = {"2" => { action: :yank_data, css: "font#addlang" } }
    instruction3 = {"3" => { action: :yank_data, css: "span.gbts" } } 
    spider.feed_instructions(instruction1, instruction2, instruction3)
    data = spider.crawl
    data[0].should include "offered in" 
    data[1].should include "+You" 
  end

  it "should raise error when unable to yank information" do
    instruction1 = Instruction.new action: :visit_site, url: "http://foobar.com"
    instruction2 = Instruction.new action: :yank_data, css: "#doesnotexist"
    spider.feed_instructions(instruction1, instruction2)
    expect { spider.crawl }.to raise_exception DataNotFound
  end
end
