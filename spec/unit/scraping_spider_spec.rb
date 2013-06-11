require_relative '../../lib/scraping_spider'

describe ScrapingSpider do
  let(:spider) { ScrapingSpider.new "Test", :mechanize }
  let(:action1) { stub(action_type: :visit, url: "http://google.com") }
  let(:action2) { stub(action_type: :form, field_name: "q", text: "Apple") }
  let(:action3) { stub(action_type: :yank, div: "resultStats") }

  it "should set scraping agent on initialization" do
    spider.get_agent.should_not be_nil
  end

  it "should respond to name" do
    spider.name.should == "Test" 
  end

  it "should allow adding actions to its web" do
    spider.add_to_web(action1, action2)
    spider.actions.should == [action1, action2]
  end

  it "should delegate 
  actions correctly when asked to crawl" do
    spider.add_to_web(action1, action2, action3)
    spider.should_receive(:visit).with(action1).ordered
    spider.should_receive(:form).with(action2).ordered
    spider.should_receive(:yank).with(action3).ordered
    spider.crawl
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
