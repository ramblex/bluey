Given /^no user exists with an email of "(.*)"$/ do |email|
  assert_nil User.find(:first, :conditions => { :email => email })
end

Given /^I am a user named "([^"]*)" with an email "([^"]*)" and password "([^"]*)"$/ do |name, email, password|
  new_user = User.new(:email => email,
                      :password => password,
                      :password_confirmation => password)
  new_user.save!
  new_user.user_profile.update_attributes(:name => name)
end

Given /^I am a new, authenticated user$/ do
  email = 'testing@man.net'
  login = 'Testing man'
  password = 'secretpass'

  Given %{I have one user "#{email}" with password "#{password}"}
  And %{I go to login}
  And %{I fill in "user_email" with "#{email}"}
  And %{I fill in "user_password" with "#{password}"}
  And %{I press "Sign in"}
end

Then /^I should be already signed in$/ do
  And %{I should see "Logout"}
end

Given /^I am signed up as "(.*)\/(.*)"$/ do |email, password|
  Given %{I am not logged in}
  When %{I go to the sign up page}
  And %{I fill in "Email" with "#{email}"}
  And %{I fill in "Password" with "#{password}"}
  And %{I fill in "Password confirmation" with "#{password}"}
  And %{I press "Sign up"}
  Then %{I should see "You have signed up successfully. If enabled, a confirmation was sent to your e-mail."}
  And %{I am logout}
end

Given /^I am logout$/ do
  visit('/users/sign_out')
end

When /^I sign in as "(.*)\/(.*)"$/ do |email, password|
  Given %{I am not logged in}
  When %{I go to the sign in page}
  And %{I fill in "Email" with "#{email}"}
  And %{I fill in "Password" with "#{password}"}
  And %{I press "Sign in"}
end

Then /^I should be signed in$/ do
  Then %{I should see "Signed in successfully."}
end

Then /^I sign out$/ do
  visit('/users/sign_out')
end

When /^I return next time$/ do
  And %{I go to the home page}
end

Then /^I should be signed out$/ do
  And %{I should see "Sign up"}
  And %{I should see "Sign in"}
  And %{I should not see "Logout"}
end

Given /^I am not logged in$/ do
  visit('/users/sign_out') # ensure that at least
end

Given /^I sign up and sign in with name "([^"]*)" and email "([^"]*)"$/ do |name, email|
  Given %{I am not logged in}
  And %{I am a user named "#{name}" with an email "#{email}" and password "please"}
  When %{I go to the sign in page}
  And %{I sign in as "#{email}/please"}
  Then %{I should be signed in}
  And %{I should be on the edit profile page}
end

When /^(?:|I )click on "([^"]*)"$/ do |selector|
  find(selector).click
end

Given /^I have no user pictures$/ do
  assert_equal 0, UserProfile.first.user_images.count
end

Then /^(?:|I )should see image "([^"]*)"$/ do |image|
  page.should have_xpath("//img[contains(@src, \"#{image}\")]")
end

Given /^(?:|I )try to access (.+) when unauthorised$/ do |page|
  Given %{I am not logged in}
  When %{I go to #{page}}
end

Then /^(?:|I )should be told to sign in$/ do
  Then %{I should see "You need to sign in or sign up before continuing"}
  And %{I should be on the sign in page}
end
