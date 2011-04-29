Feature: Manage user pictures
  In order to allow users to manage their pictures
  A user
  Should be able to add and delete pictures from the profile page

    @javascript
    Scenario: User uploads a picture
      Given I sign up and sign in with name "foo" and email "user@test.com"
      And I have no user pictures
      And I follow "Pictures"
      Then I should see "Your pictures"
      And I should see "You haven't uploaded any pictures yet"
      When I fill in "Name" with "My picture"
      And I attach the file "test/fixtures/sample.png" to "Picture"
      And I press "Upload picture"
      Then I should see "Successfully uploaded picture"
      And I should not see "You haven't uploaded any pictures yet"
      And I should see "My picture"
      And I should be on the edit profile page
      And the "Name" field should not contain "My picture"

    @javascript
    Scenario: User tries to upload picture without name
      Given I sign up and sign in with name "foo" and email "user@test.com"
      And I have no user pictures
      And I follow "Pictures"
      Then I should see "Your pictures"
      And I should see "You haven't uploaded any pictures yet"
      When I attach the file "test/fixtures/sample.png" to "Picture"
      And I press "Upload picture"
      Then I should see "Name can't be blank"
      And I should be on the edit profile page

    @javascript
    Scenario: User tries to upload picture without file
      Given I sign up and sign in with name "foo" and email "user@test.com"
      And I have no user pictures
      And I follow "Pictures"
      Then I should see "Your pictures"
      And I should see "You haven't uploaded any pictures yet"
      When I fill in "Name" with "My picture"
      And I press "Upload picture"
      Then I should see "Picture file name must be set"
      And I should be on the edit profile page

    @javascript
    Scenario: User deletes a picture
      Given I sign up and sign in with name "foo" and email "user@test.com"
      And I have the following user_image records:
        | name       | picture_file_name |
        | My picture | my_picture.png    |
      And I follow "Pictures"
      Then I should see "My picture"
      When I follow "Delete"
      Then I should see "Successfully deleted picture"
      And I should be on the edit profile page

    @javascript
    Scenario: User adds their profile picture
      Given I sign up and sign in with name "foo" and email "user@test.com"
      And I have no user pictures
      And I click on "#profile-picture"
      Then I should see "You haven't uploaded any pictures yet"
      When I fill in "Name" with "My profile picture"
      And I attach the file "test/fixtures/sample.png" to "Picture"
      And I press "Upload picture"
      Then I should see "Successfully uploaded picture"
      When I follow "Use for profile"
      Then I should see image "sample.png" within "#profile-picture"
