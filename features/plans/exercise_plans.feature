Feature: Manage exercise plans
  In order to allow users to manage their exercise regime
  A user
  Should be able to manage their exercise plans

    Background:
      Given I have the following users:
        | name         | email         | password   |
        | Alex         | alex@test.com | mypassword |
        | Manny        | manny@bluey.com | otherpassword |
        | Dave         | dave@dave.com | mypassword |

    Scenario: View list of existing plans
      Given I sign in as "alex@test.com/mypassword"
      And I have the following plans created by Alex:
        | name         | day | exercises            |
        | Alex's plan  | 1   | Bench press, Sit-ups |
        |              | 2   | Sit-ups              |
      And I have the following plans created by Manny:
        | name         | day | exercises            |
        | Manny's plan  | 1   | Bench press, Sit-ups |
        |              | 2   | Sit-ups              |
      When I follow "Plans" within "nav"
      Then I should see the following list of plans:
        | creator | name        |
        | Alex    | Alex's plan |
      And I should not see the following list of plans:
        | creator | name        |
        | Manny   | Manny's plan |

    @javascript
    Scenario: View an existing plan
      Given I sign in as "dave@dave.com/mypassword"
      And I have the following plans created by Dave:
        | name    | day | exercises              |
        | My plan | 1   | Bench press, Sit-ups   |
        | My plan | 2   | Sit-ups                |
      And I follow "Plans" within "nav"
      And I follow "My plan"
      Then I should see "Bench press"
      When I check "Bench press" inside day 1
      And I check "Sit-ups" inside day 2
      Then "Bench press" inside day 1 should be completed
      Then "Sit-ups" inside day 2 should be completed
      When I uncheck "Sit-ups" inside day 2
      Then "Sit-ups" inside day 2 should not be completed
      And I reload the page
      Then "Bench press" inside day 1 should be completed
      Then "Sit-ups" inside day 2 should not be completed

    Scenario: Creating a plan without a name
      Given I sign in as "dave@dave.com/mypassword"
      And I follow "Plans" within "nav"
      And I follow "Create a plan"
      And I fill in "Description" with "My description"
      And I press "Create"
      Then I should see "Name can't be blank"

    Scenario: Create a valid plan
      Given I sign in as "dave@dave.com/mypassword"
      And I follow "Plans" within "nav"
      And I follow "Create a plan"
      And I fill in "Name" with "My plan name"
      And I fill in "Description" with "My description"
      And I press "Create"
      Then I should be on the "My plan name" plan page
      And I should see "My plan name"

    Scenario: Edit an existing plan
      Given I sign in as "dave@dave.com/mypassword"
      And I have the following plans created by Dave:
        | name | day | exercises |
        | My empty plan | | |
      And I am on the "My empty plan" plan page
      Then I should see "My empty plan"
      And I should see "No days have been added to this plan yet!"
      When I follow "Add a day"
      Then I should see "Day 1"
