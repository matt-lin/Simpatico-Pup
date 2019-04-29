Feature: Users should be able to see and edit their profile page
  As a user
  so that I can learn more about other users
  I want to read their profile pages


As a user
so that I can share info about myself
I want to write information on a profile page



Background: User already logged in
    Given the default layout exist
    And I am on the RateMyPup home page

    And the following users exist:
        | username       | email               | password       | password_confirmation| activated |
        | jeff           | jeff@berkeley.edu   | 12345678       | 12345678             | true      |
    And I log in as "jeff"

Scenario: User visits their own profile page
  When I go to the profile page for "jeff"
  Then I should see "jeff"
  And I should see "No biography"
  And I should see the default profile image

Scenario: User goes to profile page that does not exist
  When I go to the profile page for "john"
  Then I should be on the RateMyPup home page
