When /^(.*) inside day (\d+)$/ do |step, day|
  within(:xpath, "//div[@class='plan-day'][#{day}]") {When step}
end

When /^(.*) inside item (\d+) in day (\d+)$/ do |step, item, day|
  within(:xpath, "//div[@class='plan-day'][#{day}]//div[@class='fields']") {When step}
end

Then /^(?:|I )should see (\d+) items in day (\d+)$/ do |num_items, day|
  find(:xpath, "//div[@class='plan-day'][#{day}]//li[@class='plan-item']", :count => num_items.to_i)
end

When /^(?:|I )add the following days to the plan:$/ do |table|
  table.hashes.each_with_index do |hash, day_idx|
    # Don't add a day the first time since there's already one there!
    Given %{I follow "Add a day to this plan"} unless day_idx == 0
    Then %{I should see "Day #{hash[:day]}" inside day #{hash[:day]}}
    hash[:exercises].split(',').each_with_index do |exercise, idx|
      When %{I follow "Add an item" inside day #{hash[:day]}} unless idx == 0 && day_idx == 0
      And %{I fill in "Exercise" with "#{exercise.strip}" inside item #{idx + 1} in day #{hash[:day]}}
    end
  end
end

Then /^I should see the following days in the plan:$/ do |table|
  table.hashes.each do |hash|
    Then %{I should see "Day #{hash[:day]}" inside day #{hash[:day]}}
    hash[:exercises].each do |exercises|
      num_exercises = exercises.split(',').count
      Then %{I should see #{num_exercises} items in day #{hash[:day]}}
    end
  end
end

Given /^I have the following plans created by (.+):$/ do |creator_name, table|
  creator = UserProfile.find_by_name(creator_name).user
  # Avoid having to put plan name in every hash
  plan_name = ""
  table.hashes.each do |hash|
    plan_name = hash[:name] unless hash[:name].empty?
    plan = Plan.find_by_name(plan_name) || Factory(:plan, :name => plan_name, :creator => creator)
    hash[:exercises].split(',').each do |exercise|
      Factory(:plan_item, :exercise => Exercise.find_by_name(exercise.strip),
                          :day => hash[:day],
                          :plan => plan)
    end
  end
end

Then /^I should see the following list of plans:$/ do |table|
  table.hashes.each do |hash|
    Then %{I should see "#{hash[:name]}" within "ul.plans"}
    And %{I should see "Created by #{hash[:creator]}" within "ul.plans"}
  end
end

Then /^I should not see the following list of plans:$/ do |table|
  table.hashes.each do |hash|
    Then %{I should not see "#{hash[:name]}" within "ul.plans"}
  end
end

Then /^"([^"]*)" inside day (\d+) should be completed$/ do |item, day|
  Then %{the "#{item}" checkbox should be checked inside day #{day}}
end

Then /^"([^"]*)" inside day (\d+) should not be completed$/ do |item, day|
  Then %{the "#{item}" checkbox should not be checked inside day #{day}}
end
