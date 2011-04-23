def create_my_user(params)
  unless user = User.find_by_email(params[:email])
    params[:password_confirmation] = params[:password]
    user = User.create!(params)
  end
end

Given /^I am logged in$/ do
  email = 'test@blueyfit.com'
  password = 'password'
  @current_user = create_my_user(:email => email, :password => password)
  steps %Q{
    Given I am on the new user session page
    And I fill in "Email" with "#{email}"
    And I fill in "Password" with "#{password}"
    And I press "Sign in"
    Then I should see "Signed in successfully"
  }
end
