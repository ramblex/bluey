Feature: Manage symptoms
  In order to allow users to share symptoms
  A user
  Should be able to enter symptoms

    @javascript
    Scenario: User adds a valid symptom description
      Given I am authenticated on the symptoms tab
      When I fill in "user_profile_symptoms" with "Here's my symptoms"
      And I press "Save" within "#edit-symptoms"
      Then I should see "User profile was successfully updated"

    @javascript
    Scenario: User adds some pain areas
      Given I am authenticated on the symptoms tab
      When I check "Left Arm"
      And the "Right Arm" checkbox should be checked
      And I press "Save" within "#edit-symptoms"
      Then I should see "User profile was successfully updated"
