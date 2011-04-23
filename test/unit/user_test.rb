require 'test_helper'

class UserTest < ActiveSupport::TestCase
  test "should not save without email" do
    user = User.new
    assert !user.save, "Saved user without email"
  end

  test "should not update without name" do
    user = users(:newly_registered)
    assert !user.update_attributes
  end
end
