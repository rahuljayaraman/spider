require_relative '../../lib/scraping_spider'
require_relative '../../lib/instruction'
require_relative '../../lib/mechanize_engine'
require 'vcr_helper'

describe "Spider" do
  let(:spider)  { ScrapingSpider.new "Test" }

  it "should be able to visit site & fetch data" do
    VCR.use_cassette('google_fetch') do
      instruction1 = Instruction.new action: :visit_site, url: "http://www.google.com"
      instruction2 = Instruction.new action: :yank_data, div: "font#addlang"
      spider.feed_instructions(instruction1, instruction2)
      spider.crawl.should include "offered in" 
    end
  end

  it "should be able to visit site, fill form & fetch data" do
    VCR.use_cassette('google_fill_form_and_fetch') do
      instruction1 = Instruction.new action: :visit_site, url: "http://www.google.com"
      instruction2 = Instruction.new action: :fill_form, form_name: "f", field_name: "q", text: "Apple"
      instruction3 = Instruction.new action: :yank_data, div: "#resultStats"
      spider.feed_instructions(instruction1, instruction2, instruction3)
      spider.crawl.should include "About" 
    end
  end

  it "should raise error when unable to yank information" do
    VCR.use_cassette('invalid_site') do
      instruction1 = Instruction.new action: :visit_site, url: "http://foobar.com"
      instruction2 = Instruction.new action: :yank_data, div: "#doesnotexist"
      spider.feed_instructions(instruction1, instruction2)
      expect { spider.crawl }.to raise_exception DataNotFound
    end
  end
end
