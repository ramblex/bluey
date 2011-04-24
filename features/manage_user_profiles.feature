Feature: Manage user_profiles
  In order to allow users to manage their profiles
  a user
  wants to be able to edit their personal information

  Scenario: User has registered and visits the profile page
    Given I am logged in
    When I go to the edit user_registration page
    Then I should see "" within ".on_the_spot_editing"
    And I should see "Profile" within "nav .selected"
