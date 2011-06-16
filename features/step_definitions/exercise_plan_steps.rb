Capybara.add_selector(:plan_day) do
  xpath { |day| ".//div[@class='day'][#{day}]" }
end

Capybara.add_selector(:plan_item) do
  xpath { |item| "./ul/div[@class='fields'][#{item}]" }
end

Capybara.add_selector(:plan_list_item) do
  xpath { |item| "./section/ul/li[@class='plan-item'][#{item}]" }
end

Capybara.add_selector(:plan_metric) do
  xpath { |metric| ".//form[@id='new_plan_item']/div[@class='fields'][#{metric}]" }
end

Then /(.*) inside day (\d+)$/ do |step, day|
  within(:plan_day, day.to_i) { When step }
end

Given /^I have the following plans created by (.+):$/ do |creator_name, table|
  creator = UserProfile.find_by_name(creator_name).user
  # Avoid having to put plan name in every hash
  plan_name = ""
  table.hashes.each do |hash|
    plan_name = hash[:name] unless hash[:name].empty?
    plan = Plan.find_by_name(plan_name) || Factory(:plan, :name => plan_name, :creator => creator)
    hash[:exercises].split(',').each do |exercise|
      Factory(:plan_item, :name => exercise.strip,
                          :day => Day.find_by_number(hash[:day].to_i) || Day.create!(:number => hash[:day].to_i, :plan => plan))
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

Then /^I should see the following new plan:$/ do |table|
  table.hashes.each do |hash|
    within(:plan_day, hash[:day]) do
      hash[:exercises].split(',').each_with_index do |exercise, idx|
        name, metrics = exercise.split('(')
        Then %{I should see "#{name.strip}"}
        within(:plan_list_item, idx + 1) do
          When %{I follow "Show metrics"}
          metrics.split.each_slice(2) do |amount, unit|
            Then %{I should see "#{amount} #{unit}"}
            And %{I should see "Hide metrics"}
          end
        end
      end
    end
  end
end

Then /^I should see the following plan:$/ do |table|
  table.hashes.each do |hash|
    within(:plan_day, hash[:day]) do
      Then %{I should see "Day #{hash[:day]}"}
      if hash[:exercises].split('(').length == 1
        hash[:exercises].split(',').each do |exercise|
          Then %{I should see "#{exercise.strip}"}
        end
      else
        exercise, sets = hash[:exercises].split('(')
        Then %{I should see "#{exercise.strip}"}
        sets.split(',').each do |set|
          set.gsub!(")", "")
          Then %{I should see "#{set.strip}"}
        end
      end
    end
  end
end

Then /^I should see the empty form to add an exercise on day (\d+)$/ do |day|
  Then %{show me the page}
  within(:plan_day, day) do
    Then %{the "Exercise" field should contain "^$"}
  end
end

When /^I add the following days:$/ do |table|
  table.hashes.each do |hash|
    When %{I follow "Add a day"}
    within(:plan_day, hash[:day]) do
      Then %{I should see "Day #{hash[:day]}"}
      And %{I should not see "No days have been added to this plan yet!"}
      When %{I follow "Add exercise"} if find_link("Add exercise").visible?
      exercise, sets = hash[:exercises].split('(')
      sets.gsub!(")", "")
      sets.split(",").each_with_index do |set, idx|
        set_num, metrics = set.strip.scan(/^Set (\d+): (.*)$/)[0]
        When %{I follow "Add another set"} unless idx == 0
        within(:plan_metric, idx + 1) do
          And %{I fill in "Set" with "#{metrics}"}
        end
      end
      And %{I fill in "Exercise" with "#{exercise.strip}"}
      And %{I press "Add exercise"}
      Then %{I should see "#{exercise.strip}" within "ul"}
      And %{the "Exercise" field should contain "^$"}
    end
  end
  When %{I follow "I'm done adding exercises"}
end

When /I try to add an empty exercise/ do
  When %{I follow "Add a day"}
  within(:plan_day, 1) do
    And %{I follow "Add exercise"}
    And %{I press "Add exercise"}
  end
end

When /^I delete the exercise (\d+) on day (\d+)$/ do |exercise, day|
  within(:plan_day, day) do
    within(:plan_list_item, exercise) do
      When %{I follow "Delete"}
    end
  end
end

When /^I open the edit form for exercise (\d+) on day (\d+)$/ do |exercise, day|
  within(:plan_day, day) do
    within(:plan_list_item, exercise) do
      When %{I follow "Edit"}
    end
  end
end

Then /^the edit form should be closed$/ do
  page.should_not have_css('.edit_plan_item')
end
