Feature: Manage goals
  In order to allow users to set goals
  A user
  Should be able to view, add and edit goals for their body

    @javascript
    Scenario: User sets a valid goal for their left arm bicep
      Given I am authenticated on the goals tab
      When I follow "Left Arm" within ".person"
      When I fill in "Current" with "3" within "fieldset#bicep"
      And I check "Add goal?"
      And I fill in "Goal" with "4" within "fieldset#bicep"
      And I press "Update"
      Then I should see "Updated your goals"
      And the "Current" field should contain "3" within "fieldset#bicep"
      And the "Goal" field should contain "4" within "fieldset#bicep"
      And I should be on the edit profile page

    @javascript
    Scenario: User sets a invalid goal for their left arm bicep
      Given I am authenticated on the goals tab
      When I follow "Left Arm" within ".person"
      When I fill in "Current" with "blah blah" within "fieldset#bicep"
      And I check "Add goal?"
      And I fill in "Goal" with "blahsadflkjf" within "fieldset#bicep"
      And I press "Update"
      Then I should see "Could not update your goals"
      And I should see "Current value is not a number"
      And the "Current" field should contain "" within "fieldset#bicep"
      And the "Goal" field should contain "" within "fieldset#bicep"
      And I should be on the edit profile page

    @javascript
    Scenario: User sets blood pressure
      Given I am authenticated on the goals tab
      When I follow "General" within ".person"
      And I fill in "Current" with "140/79" within "fieldset#blood-pressure"
      And I press "Update" within "#edit_general"
      Then show me the page
      Then I should see "Updated your goals"
