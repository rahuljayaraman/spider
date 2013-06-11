class Spidy
end
class Action
end

describe "Web Slinging" do
  it "should be able to hook onto sites & fetch information" do
    spider = Spidy.new "Test"
    action1 = Action.new action_type: :visit, url: "http://www.google.com"
    action2 = Action.new action_type: :fill, field: "q", text: "Apple"
    action3 = Action.new action_type: :yank, div: "#resultStats"
    spider.add_to_web(action1, action2, action3)
    spider.crawl
    spider.data.should.have_content "About"
  end
end
