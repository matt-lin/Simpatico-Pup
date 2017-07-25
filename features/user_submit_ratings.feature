#javascript
Feature: only users with a user profile should be able to submit a rating

  As a current dog owner
  So that I can review my dog and be held liable for what I say about my dog or a dog breeder
  I should be logged into my user profile.

  Background: reviews have been added to the database

  Scenario: there should be a login button on the home page
    Given the default layout exist
    And I am on the RateMyPup home page
    Then I should see "Login"
    Then I should see "Signup"
    When I follow "Login"
    Then I should be on the Login page

  Scenario: should not be able to submit a rating if not logged in as a user

    Given I am on the RateMyPup home page
    Then I should see "Login"
    And I follow "Rate your Dog"
    Then I should be on the Welcome page
