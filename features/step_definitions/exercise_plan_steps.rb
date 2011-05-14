Capybara.add_selector(:plan_day) do
  xpath { |day| ".//div[@class='plan-day'][#{day}]" }
end

Capybara.add_selector(:plan_item) do
  xpath { |item| ".//div[@class='plan-item'][#{item}]" }
end

Capybara.add_selector(:plan_metric) do
  xpath { |metric| ".//fieldset[@class='exercise-metrics']//div[@class='fields'][#{metric}]"}
end

Then /^(?:|I )should see (\d+) items in day (\d+)$/ do |num_items, day|
  find(:xpath, "//div[@class='plan-day'][#{day}]//li[@class='plan-item']", :count => num_items.to_i)
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

Then /^I should see the following days in the plan:$/ do |table|
  table.hashes.each do |hash|
    Then %{I should see "Day #{hash[:day]}" inside "div.plan-day[#{hash[:day]}]"}
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
      Factory(:plan_item, :name => exercise.strip,
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
