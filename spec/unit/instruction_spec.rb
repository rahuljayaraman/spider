require_relative '../../lib/instruction'

describe Instruction do
  let(:visit_instruction) { 
    Instruction.new action: :visit_site,
    url: "http://google.com"
  }

  let(:fill_instruction) { 
    Instruction.new(
      action: :fill_form, 
      fields: [{ field_name: "q", text: "Apple" }]
    ) 
  }

  let(:click_instruction) { 
    Instruction.new action: :click,
    link: "Me"
  }

  let(:yank_instruction) { 
    Instruction.new action: :yank_data, css: "#resultStats"
  }

  it "should fetch type correctly" do
    visit_instruction.action.should == :visit_site
    fill_instruction.action.should == :fill_form
    yank_instruction.action.should == :yank_data
  end

  it "should fetch list of available instructions" do
    Instruction.available_set.should == [:visit_site, :fill_form, :yank_data, :click]
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
      fill_instruction.fields.first.fetch(:field_name).
        should == "q"
      fill_instruction.fields.first.fetch(:text).
        should == "Apple"
    end
  end

  context "Click" do
    it "should insist on link" do
      expect do 
        Instruction.new(action: :click) 
      end.to raise_exception KeyError
    end
    
    it "should fetch link correctly" do
      click_instruction.link.should == "Me"
    end
  end

  context "Yank Data" do
    it "should insist on css" do
      expect do 
        Instruction.new(action: :yank_data) 
      end.to raise_exception KeyError
    end
    
    it "should fetch field_name, form_name & text correctly" do
      yank_instruction.css.should == "#resultStats"
    end
  end
end
