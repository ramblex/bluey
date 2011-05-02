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
      Given I am a new, authenticated user
      And I follow "Plans" within "nav"
      And I follow "Create a plan"
      When I fill in "Name" with "My plan"
      And I fill in "Description" with "My description"
      And I press "Create"
      Then I should see "Successfully created plan"
      When I follow "Add a day to this plan"
      Then I should see "Day 1"
      And I follow "Add an item" within "#day-1"
