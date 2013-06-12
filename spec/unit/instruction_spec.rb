require_relative '../../lib/instruction'

describe Instruction do
  let(:visit_instruction) { 
    Instruction.new action: :visit_site,
    url: "http://google.com"
  }

  let(:fill_instruction) {
    Instruction.new action: :fill_form,
    form_name: "f", field_name: "q", text: "Apple"
  }

  let(:yank_instruction) { 
    Instruction.new action: :yank_data, div: "#resultStats"
  }

  it "should fetch type correctly" do
    visit_instruction.action.should == :visit_site
    fill_instruction.action.should == :fill_form
    yank_instruction.action.should == :yank_data
  end

  context "Visit" do
    it "should insist on url" do
      expect do 
        Instruction.new(action: :visit_site) 
      end.to raise_exception KeyError
    end
    
    it "should fetch url correctly" do
      visit_instruction.url.should == "http://google.com"
    end
  end

  context "Fill form" do
    it "should insist on form_name & field_name" do
      expect do 
        Instruction.new(action: :fill_form) 
      end.to raise_exception KeyError
    end
    
    it "should fetch field_name, form_name & text correctly" do
      fill_instruction.form_name.should == "f"
      fill_instruction.field_name.should == "q"
      fill_instruction.text.should == "Apple"
    end
  end

  context "Yank Data" do
    it "should insist on div" do
      expect do 
        Instruction.new(action: :yank_data) 
      end.to raise_exception KeyError
    end
    
    it "should fetch field_name, form_name & text correctly" do
      yank_instruction.div.should == "#resultStats"
    end
  end
end
