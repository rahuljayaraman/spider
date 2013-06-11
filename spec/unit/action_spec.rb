require_relative '../../lib/action'

describe Action do
  context "Visit" do
    it "should insist on url for visit action" do
      expect do 
        Action.new(action_type: :visit_site) 
      end.to raise_exception KeyError
    end
  end
end
