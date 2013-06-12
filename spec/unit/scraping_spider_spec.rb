require_relative '../../lib/scraping_spider'

class MechanizeEngine; end

describe ScrapingSpider do
  let(:spider) { ScrapingSpider.new "Test" }
  let(:action1) { stub(action_type: :visit_site, url: "http://google.com") }
  let(:action2) { stub(action_type: :fill_form, form_name: "f", field_name: "q", text: "Apple") }
  let(:action3) { stub(action_type: :yank_data, div: "resultStats") }

  it "should respond to name" do
    spider.name.should == "Test" 
  end

  it "should allow adding actions to its web" do
    spider.add_to_web(action1, action2)
    spider.actions.should == [action1, action2]
  end


  context "Crawl" do
    let(:engine) { spider.engine }

    it "should delegate actions in order and return data" do
      spider.add_to_web(action1, action2, action3)
      engine.should_receive(:visit_site).with(action1).ordered
      engine.should_receive(:fill_form).with(action2).ordered
      engine.should_receive(:yank_data).with(action3).ordered
      engine.stub(:visit_site)
      engine.stub(:fill_form)
      engine.stub(:yank_data).with(action3).and_return("data")
      spider.crawl
    end

    it "should raise exception when no data is found" do
      spider.add_to_web(action1, action3)
      engine.stub(:visit_site)
      engine.stub(:yank_data).and_return(nil)
      expect { spider.crawl }.to raise_exception DataNotFound
    end
  end

  context "Error Checking" do
    it "should not crawl without a yank" do
      spider.add_to_web(action1)
      expect { spider.crawl }.
        to raise_error YankNotAvailableError
    end

    it "should not crawl without a visit" do
      spider.add_to_web(action3)
      expect { spider.crawl }.
        to raise_error VisitNotAvailableError
    end
  end
end
