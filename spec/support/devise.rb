module ControllerMacros
  def login_user
    before(:each) do
      @request.env["devise.mapping"] = Devise.mappings[:user]
      @current_user = Factory.create(:user)
      @current_user.user_profile.update_attributes(:name => "Alex")
      sign_in @current_user
    end
  end
end

RSpec.configure do |config|
  config.include Devise::TestHelpers, :type => :controller
  config.extend ControllerMacros, :type => :controller
end
