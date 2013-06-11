require_relative '../../lib/action'

describe Action do
  context "Visit" do
    let(:action) { Action.new action_type: :visit, url: "http://google.com" }

    it "should insist on url for visit action" do
      expect do 
        Action.new(action_type: :visit) 
      end.to raise_exception KeyError
    end
  end
end
