require 'spec_helper'

describe RobotsController do

  describe "GET 'fetch'" do
    it "returns http success" do
      get 'fetch'
      response.should be_success
    end
  end

end
