Feature: Users should be able to edit their own biography
  As a user
  so that I can share information about myself to others
  I want to be able to edit my profile page

Background: User already logged in
  Given the default layout exist
  And I am on the RateMyPup home page

  And the following users exist:
      | username       | email               | password       | password_confirmation| activated |
      | jeff           | jeff@berkeley.edu   | 12345678       | 12345678             | true      |
  And I log in as "jeff"
  And I am on the "Edit Profile" page

Scenario: User edits their own biography
  When I fill in "user_bio" with "My name is Jeff. Here is my bio"
  And I press "update_bio"
  Then I should see "You have successfully updated your biography"
  And I go to the profile page for "jeff"
  Then I should see "jeff"
  And I should see "My name is Jeff. Here is my bio"
