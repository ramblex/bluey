Feature: Manage body goals
  In order to allow users to set goals
  A user
  Should be able to view, add and edit goals for their body

    @javascript
    Scenario: User sets a valid goal for their left arm bicep
      Given I sign up and sign in with name "foo" and email "user@test.com"
      And I follow "Body Stats"
      Then I should see image "man.png" within "#person"
      When I follow "Left Arm" within "#person"
      And I fill in "Bicep" with "3"
      And I press "Update"
      Then I should see "Successfully updated your stats"
      And the "Bicep" field should contain "3"
      And I should be on the edit profile page
