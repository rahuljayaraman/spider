require_relative '../../lib/scraping_spider'

class MechanizeEngine; end

describe ScrapingSpider do
  let(:spider) { ScrapingSpider.new "Test" }
  let(:instruction1) { stub(action: :visit_site, url: "http://google.com") }
  let(:instruction2) { stub(action: :fill_form, fields: [{ field_name: "srchword", text: "cricket" }]) }
  let(:instruction3) { stub(action: :yank_data, div: "resultStats") }

  it "should respond to name" do
    spider.name.should == "Test" 
  end

  it "should eat instructions & forget them when required" do
    spider.feed_instructions(instruction1, instruction2)
    spider.instructions.should == [instruction1, instruction2]
    spider.forget_instructions!
    spider.instructions.should be_empty
  end

  it "should raise error on invalid instruction" do
    instruction = [:action => "foo"]
    expect {
      spider.feed_instructions(instruction)
    }.to raise_exception InvalidInstruction
  end

  it "should be able to receive instructions in the form of a hash" do
    class Instruction; def initialize(hash); end; end
    instruction = { "1" => { action: "visit_site", url: "http://google.com" } }
    spider.feed_instructions instruction
    spider.instructions.first.should be_an_instance_of Instruction
  end


  context "Crawl" do
    let(:engine) { spider.engine }

    it "should delegate instructions in order and return data" do
      spider.feed_instructions(instruction1, instruction2, instruction3)
      engine.should_receive(:visit_site).with(instruction1).ordered
      engine.should_receive(:fill_form).with(instruction2).ordered
      engine.should_receive(:yank_data).with(instruction3).ordered
      engine.stub(:visit_site)
      engine.stub(:fill_form)
      engine.stub(:yank_data).with(instruction3).and_return("data")
      spider.crawl
    end
  end

  context "Error Checking" do
    it "should not crawl without a yank" do
      spider.feed_instructions(instruction1)
      expect { spider.crawl }.
        to raise_error YankNotAvailableError
    end

    it "should not crawl without a visit" do
      spider.feed_instructions(instruction3)
      expect { spider.crawl }.
        to raise_error VisitNotAvailableError
    end
  end
end
