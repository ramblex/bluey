require 'test_helper'

class UserProfileTest < ActiveSupport::TestCase
  # Replace this with your real tests.
  test "should not save without city" do
    user_profile = UserProfile.new(:country => 'uk')
    assert !user_profile.save
  end

  test "should not save without country" do
    user_profile = UserProfile.new(:city => 'Bristol')
    assert !user_profile.save
  end

  test "should save with country and city" do
    user_profile = UserProfile.new(:city => 'Bristol', :country => 'uk')
    assert user_profile.save
  end
end
