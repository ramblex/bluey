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

    @javascript
    Scenario: Creating a plan with some items but without a name
      Given I sign in as "dave@dave.com/mypassword"
      And I follow "Plans" within "nav"
      And I follow "Create a plan"
      And I fill in "Description" with "My description"
      When I add the following days to the plan:
        | day   | exercises            |
        | 1     | Bench press (2 sets 3 reps 45 kg), Sit-ups (2 sets 30 reps) |
        | 2     | Swimming (10 lengths)          |
      And I press "Create"
      Then I should see "Name can't be blank"
      And I should see the following days in the plan form:
        | day   | exercises            |
        | 1     | Bench press (2 sets 3 reps 45 kg), Sit-ups (2 sets 30 reps) |
        | 2     | Swimming (10 lengths)          |

    @javascript
    Scenario: Creating a plan with a single day and some items
      Given I sign in as "dave@dave.com/mypassword"
      And I follow "Plans" within "nav"
      And I follow "Create a plan"
      When I fill in "Name" with "My plan"
      And I fill in "Description" with "My description"
      When I add the following days to the plan:
        | day   | exercises            |
        | 1     | Bench press (40 kg 30 reps), Sit-ups (30 reps) |
        | 2     | Bench press (30 reps)         |
        | 3     | Swimming (10 lengths)         |
      When I press "Create"
      Then I should see "Successfully created plan"
      Then I should see the following new plan:
        | day   | exercises            |
        | 1     | Bench press (40 kg 30 reps), Sit-ups (30 reps) |
        | 2     | Bench press (30 reps)         |
        | 3     | Swimming (10 lengths)         |
