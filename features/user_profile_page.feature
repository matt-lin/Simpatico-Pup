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
    And I am on the "Profile" page

Scenario: User visits their own profile page
  When I go to "jeff"\'s profile page
  Then I should see the default profile image
  And I should see an empty bio
  And I should see "Add Dog"

Scenario: User edits their own profile page
  Given I go to "jeff"\'s profile page
  When I press "Add Dog"
  And I fill in "Name" with "Spot"
  And I fill "Breed" with "Dalmatian"
  And I press "Submit"
  Then I should be on "jeff"\'s profile page
  And I should see "Spot"
  And I should see "Dalmatian"

Scenario: User goes to profile page that does not existing
  When I go to "john"\'s profile page
  Then I should get 404

