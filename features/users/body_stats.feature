Feature: Manage body goals
  In order to allow users to set goals
  A user
  Should be able to view, add and edit goals for their body

    @javascript
    Scenario: User sets a valid goal for their left arm bicep
      Given I am authenticated on the body stats tab
      When I follow "Left Arm" within ".person"
      When I fill in "Current" with "3" within "fieldset#Bicep"
      And I check "Add goal?"
      And I fill in "Goal" with "4" within "fieldset#Bicep"
      And I press "Update"
      Then I should see "Updated your stats"
      And the "Current" field should contain "3" within "fieldset#Bicep"
      And the "Goal" field should contain "4" within "fieldset#Bicep"
      And I should be on the edit profile page

    @javascript
    Scenario: User sets a invalid goal for their left arm bicep
      Given I am authenticated on the body stats tab
      When I follow "Left Arm" within ".person"
      When I fill in "Current" with "blah blah" within "fieldset#Bicep"
      And I check "Add goal?"
      And I fill in "Goal" with "blahsadflkjf" within "fieldset#Bicep"
      And I press "Update"
      Then I should see "Could not update your stats"
      And I should see "Current value is not a number"
      And the "Current" field should contain "" within "fieldset#Bicep"
      And the "Goal" field should contain "" within "fieldset#Bicep"
      And I should be on the edit profile page
