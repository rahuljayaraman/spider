require_relative '../../lib/spidy'

class Agent; end

describe Spidy do
  let(:spider) { Spidy.new "Test" }

  it "should respond to name" do
    spider.name.should == "Test" 
  end

  it "should allow adding actions to its web" do
    action1 = stub(action_type: :visit)
    action2 = stub(action_type: :yank)
    spider.add_to_web(action1, action2)
    spider.actions.should == [action1, action2]
  end

  it "should delegate actions correctly when asked to crawl" do
    action1 = stub(action_type: :visit, url: "http://google.com")
    action2 = stub(action_type: :form, field_name: "q", text: "Apple")
    action3 = stub(action_type: :yank, div: "resultStats")
    spider.add_to_web(action1, action2, action3)
    spider.should_receive(:visit).with(action1).ordered
    spider.should_receive(:form).with(action2).ordered
    spider.should_receive(:yank).with(action3).ordered
    spider.crawl
  end

  it "should not crawl without a yank" do
    action1 = stub(action_type: :visit)
    spider.add_to_web(action1)
    expect { spider.crawl }.
      to raise_error YankNotAvailableError
  end
end
