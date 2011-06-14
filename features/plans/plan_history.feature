Feature: Plan history
  In order to allow users and their trainers to view updates to a plan
  A user
  Should be able to view the history of a plan

  Background:
    Given I have the following users:
      | name | email | password |
      | Alex | alex@test.com | mypassword |
    And I sign in as "alex@test.com/mypassword"

  Scenario: Create a plan
    Given "Alex" creates and visits a plan called "My simple plan"
    Then I should see "Created plan"

  Scenario: Add an item to a plan

  Scenario: Update plan item

  @javascript
  Scenario: Complete a plan item
    Given I have the following plans created by Alex:
      | name        | day | exercises   |
      | Simple plan | 1   | Bench press |
    And I am on the "Simple plan" plan page
    When I add the following days:
      | day  | exercises                                             |
      | 1    | Bench press (Set 1: 10 kg 10 minutes, Set 2: 15 kg)   |
      | 1    | Sit-ups (Set 1: 10 minutes)                           |
      | 2    | Bench press (Set 1: 10 kg 10 minutes)                 |
    And I complete "Bench press" on day 1
    Then I should see "Completed Bench press on day 1" within ".history"

  Scenario: Uncomplete a plan item

  Scenario: Delete an item

  Scenario: Challenge an update

  Scenario: Restore an item
