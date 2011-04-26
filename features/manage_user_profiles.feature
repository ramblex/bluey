Feature: Manage user_profiles
  In order to allow users to manage their profiles
  a user
  wants to be able to edit their personal information

  Scenario: New user has registered and should be shown their profile after logging in
    Given I am logged in as "test@blueyfit.com" with name ""
    Then I should see "" within ".on_the_spot_editing"
    And I should see "Profile" within "nav .selected"

  @javascript
  Scenario: User has added a name to their profile and they login
    Given I am logged in as "test@blueyfit.com" with name "Test name"
    Then I should see "Financial" within ".filter-buttons"

  Scenario: User adds a photo
    Given I am logged in as "test@blueyfit.com" with name "Test name"
    And I click the Pictures link
    Then I should see "Your pictures"
