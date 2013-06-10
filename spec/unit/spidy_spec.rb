require_relative '../../lib/spidy'

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

  it "should perform actions when asked to crawl" do
    action1 = stub(action_type: :visit)
    action2 = stub(action_type: :yank)
    spider.add_to_web(action1, action2)
    action1.should_receive :perform
    action2.should_receive :perform
    spider.crawl
  end

  it "should not crawl without a yank" do
    action1 = stub(action_type: :visit)
    action1.stub(:perform)
    spider.add_to_web(action1)
    expect { spider.crawl }.
      to raise_error YankNotAvailableError
  end
end
