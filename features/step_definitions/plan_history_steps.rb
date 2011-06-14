Given /^"([^"]+)" creates and visits a plan called "([^"]+)"$/ do |username, plan_name|
  plan = Factory(:plan, :name => plan_name, :creator => UserProfile.find_by_name(username).user)
  visit plan_path(plan)
end

When /^I complete "([^"]+)" on day (\d+)/ do |item, day|
  within(:plan_day, day) do
    check(item)
  end
end
