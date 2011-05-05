Feature: Manage exercise plans
  In order to allow users to manage their exercise regime
  A user
  Should be able to manage their exercise plans

    @javascript
    Scenario: Creating a plan without a name
      Given I am a new, authenticated user
      And I follow "Plans" within "nav"
      And I follow "Create a plan"
      And I fill in "Description" with "My description"
      And I press "Create"
      Then I should see "Name can't be blank"

    @javascript
    Scenario: Creating a plan with a single day
      Given I have the following plan_items:
        | Name        |
        | Bench press |
      Given I am a new, authenticated user
      And I follow "Plans" within "nav"
      And I follow "Create a plan"
      When I fill in "Name" with "My plan"
      And I fill in "Description" with "My description"
      When I follow "Add a day to this plan"
      Then I should see "Day 1"
      When I follow "Add an item"
      And I fill in "Name" with "My Item name" within ".plan-day"
      When I press "Create"
      Then show me the page
      Then I should see "Successfully created plan"
      And I should see "My plan"
      And I should see "Day 1" within ".plan-day"
      And I should see "My Item name" within ".plan-day"
