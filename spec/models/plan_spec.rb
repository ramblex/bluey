require 'spec_helper'

describe Plan do
  before(:each) do
    @plan = Plan.new
  end

  it "is invalid without a name" do
    @plan.should have(1).error_on(:name)
    @plan.should_not be_valid
  end
end
