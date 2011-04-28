Feature: Cancel account
  In order to allow users to leave the site
  A user
  Should be able to cancel their account

    Scenario: User signs in and cancels their account
      Given I sign up and sign in with name "foo" and email "user@test.com"
      When I follow "Cancel my account"
      Then I should see "Bye! Your account was successfully cancelled. We hope to see you again soon."
      When I go to the sign in page
      And I sign in as "user@test.com/please"
      Then I should see "Invalid email or password."
      And I go to the home page
      And I should be signed out
