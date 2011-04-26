require 'test_helper'

class UserImageTest < ActiveSupport::TestCase
  test "should not save without a name or picture" do
    user_image = UserImage.new
    assert !user_image.save
  end

  test "should not save without picture" do
    user_image = UserImage.new(:name => 'Hello')
    assert !user_image.save
  end

  test "should not save without name" do
    user_image = UserImage.new(:picture => sample_file('sample.png'))
    assert !user_image.save
  end

  test "should save with name and picture" do
    user_image = UserImage.new(:name => 'Test', :picture => sample_file('sample.png'))
    assert user_image.save
  end
end
