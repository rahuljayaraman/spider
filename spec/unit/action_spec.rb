require_relative '../../lib/action'

describe Action do
  let(:visit_action) { 
    Action.new action_type: :visit_site,
    url: "http://google.com"
  }

  let(:fill_action) {
    Action.new action_type: :fill_form,
    form_name: "f", field_name: "q", text: "Apple"
  }

  let(:yank_action) { 
    Action.new action_type: :yank_data, div: "#resultStats"
  }

  it "should fetch type correctly" do
    visit_action.action_type.should == :visit_site
    fill_action.action_type.should == :fill_form
    yank_action.action_type.should == :yank_data
  end

  context "Visit" do
    it "should insist on url" do
      expect do 
        Action.new(action_type: :visit_site) 
      end.to raise_exception KeyError
    end
    
    it "should fetch url correctly" do
      visit_action.url.should == "http://google.com"
    end
  end

  context "Fill form" do
    it "should insist on form_name & field_name" do
      expect do 
        Action.new(action_type: :fill_form) 
      end.to raise_exception KeyError
    end
    
    it "should fetch field_name, form_name & text correctly" do
      fill_action.form_name.should == "f"
      fill_action.field_name.should == "q"
      fill_action.text.should == "Apple"
    end
  end

  context "Yank Data" do
    it "should insist on div" do
      expect do 
        Action.new(action_type: :yank_data) 
      end.to raise_exception KeyError
    end
    
    it "should fetch field_name, form_name & text correctly" do
      yank_action.div.should == "#resultStats"
    end
  end
end
