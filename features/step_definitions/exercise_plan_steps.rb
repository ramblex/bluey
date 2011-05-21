Capybara.add_selector(:plan_day) do
  xpath { |day| ".//div[@class='day'][#{day}]" }
end

Capybara.add_selector(:plan_item) do
  xpath { |item| "./ul/div[@class='fields'][#{item}]" }
end

Capybara.add_selector(:plan_list_item) do
  xpath { |item| "./ul/li[@class='plan-item'][#{item}]" }
end

Capybara.add_selector(:plan_metric) do
  xpath { |metric| ".//fieldset[@class='exercise-metrics']//div[@class='fields'][#{metric}]"}
end

Then /(.*) inside day (\d+)$/ do |step, day|
  within(:plan_day, day.to_i) { When step }
end

When /^(?:|I )add the following days to the plan:$/ do |table|
  table.hashes.each_with_index do |hash, day_idx|
    # Don't add a day the first time since there's already one there!
    click_link('Add a day to this plan') unless day_idx == 0
    within(:plan_day, hash[:day]) do
      Then %{I should see "Day #{hash[:day]}"}
      hash[:exercises].split(',').each_with_index do |exercise, idx|
        name, metrics = exercise.split('(')
        click_link('Add an exercise') unless idx == 0 && day_idx == 0
        within(:plan_item, idx + 1) do
          fill_in 'Exercise', :with => name
          unless metrics.nil?
            metric_idx = 0
            metrics.split.each_slice(2) do |amount, unit|
              metric_idx += 1
              click_link('Add a metric')
              within(:plan_metric, metric_idx) do
                fill_in 'Amount', :with => amount
                fill_in 'Unit', :with => unit
              end
            end
          end
        end
      end
    end
  end
end

Then /^I should see the following days in the plan form:$/ do |table|
  table.hashes.each do |hash|
  within(:plan_day, hash[:day]) do
    Then %{I should see "Day #{hash[:day]}"}
    hash[:exercises].split(',').each_with_index do |exercise, idx|
        name, metrics = exercise.split('(')
        within(:plan_item, idx + 1) do
          Then %{the "Exercise" field should contain "#{name.strip}"}
        end
      end
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
      hash[:exercises].split(',').each do |exercise|
        Then %{I should see "#{exercise.strip}"}
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
      sets.split(",").each do |set|
        set_num, metrics = set.strip.scan(/^Set (\d+): (.*)$/)
        When %{I follow "Add set"}
        metrics.split.each_slice(2) do |amount, unit|
          When %{I follow "Add metric"}
          When %{I fill in "Amount" with "#{amount}"}
          When %{I fill in "Unit" with "#{unit}"}
        end
      end
      And %{I fill in "Exercise" with "#{exercise.strip}"}
      And %{I press "Add exercise"}
      Then %{I should see "#{exercise.strip}" within "ul"}
      And %{the "Exercise" field should contain "^$"}
    end
  end
end
