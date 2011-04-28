Feature: Edit profile
  In order to allow users to customise their profiles
  A user
  Should be able to edit their profile

    @javascript
    Scenario: User signs in and edits their name
      Given I sign up and sign in with name "" and email "user@test.com"
      Then I should see "Click here to update your name" within "#user-info h1"
      When I click on "#user-info h1 .on_the_spot_editing"
      And I fill in "value" with "My name"
      And I press "Save" within "#user-info h1"
      Then I should see "My name" within "#user-info h1"

    @javascript
    Scenario: User signs in and edits their summary
      Given I sign up and sign in with name "foo" and email "user@test.com"
      Then I should see "Click here to edit your summary" within "#user-info .summary"
      When I click on "#user-info .summary .on_the_spot_editing"
      And I fill in "value" with "Hello, this is my summary!"
      And I press "Save" within "#user-info .summary"
      Then I should see "Hello, this is my summary!" within "#user-info .summary"

    Scenario: User fills in foundation information
      Given I have the following user_type records:
        | name                 |
        | A trainer            |
        | Looking for trainers |
      And I have the following user_want records:
        | name                 |
        | Lose weight          |
        | Train for sport      |
      And I sign up and sign in with name "foo" and email "user@test.com"
      When I check "A trainer"
      And I check "Lose weight"
      And I select "United Kingdom" from "Country"
      And I fill in "City" with "Bristol"
      And I press "Save"
      Then I should see "User profile was successfully updated"
      And the "City" field should contain "Bristol"
      And the "Country" field should contain "GB"
      And the "Lose weight" checkbox should be checked
      And the "A trainer" checkbox should be checked
