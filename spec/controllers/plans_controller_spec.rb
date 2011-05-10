require 'spec_helper'

describe PlansController do
  login_user

  describe "Adding a plan" do
    it "should create a plan with a creator" do
      post :create, :plan => {:name => "test", :description => "hello world"}
      assigns[:plan].creator.user_profile.should_not be_nil
      assigns[:plan].creator.user_profile.user.should_not be_nil
      assigns[:plan].creator.user_profile.name.should_not be_empty
    end
  end
end
