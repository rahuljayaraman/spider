require_relative '../../lib/scraping_spider'

class MechanizeEngine; end

describe ScrapingSpider do
  let(:spider) { ScrapingSpider.new "Test" }
  let(:instruction1) { stub(action: :visit_site, url: "http://google.com") }
  let(:instruction2) { stub(action: :fill_form, form_name: "f", field_name: "q", text: "Apple") }
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

    it "should raise exception when no data is found" do
      spider.feed_instructions(instruction1, instruction3)
      engine.stub(:visit_site)
      engine.stub(:yank_data).and_return(nil)
      expect { spider.crawl }.to raise_exception DataNotFound
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
