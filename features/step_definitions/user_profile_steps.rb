def create_my_user(params)
  unless user = User.find_by_email(params[:email])
    params[:password_confirmation] = params[:password]
    user = User.create!(params)
  end
end

Given /^I am logged in as "(.*)" with name "(.*)"$/ do |email, name|
  password = 'password'
  @current_user = create_my_user(:email => email, :password => password)
  steps %Q{
    Given I am on the new user session page
    And I fill in "Email" with "#{email}"
    And I fill in "Password" with "#{password}"
    And I press "Sign in"
    Then I should see "Signed in successfully"
  }
  unless name.empty?
    @current_user.user_profile.update_attributes(:name => name)
  end
end
