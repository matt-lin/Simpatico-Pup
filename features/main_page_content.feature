#@javascript
Feature: see content on the main page 
    As a user of RateMyPup
    So that I can use the site 
    I want to be able to see information about these

Background:
    Given I am on the RateMyPup home page


Scenario: information content on main page 
    Given I am on the RateMyPup home page
    And I should see "Contact"

Scenario: Hover over buttons should show hidden div 
    Given I am on the RateMyPup home page
    When I press a hidden button ".button-b"
    Then I should see "Search for ratings by breed:"
    When I press a hidden button ".button-c"
    Then I should see "Find a breeder or kennel by name:"

Scenario: Direct to rate your pup 
    Given I am on the RateMyPup home page
    And I am logged in
    When I press a hidden button ".button-a"
    Then I should be on the "Dog Name" page

Scenario: Add nav tabs in navbar
    Given I am on the RateMyPup home page
    Then I should see "Background"
    And I should see "Goals"
    And I should see "How You Can Help"
    
Scenario: search by breed button should have correct text
  Given I am on the RateMyPup home page
  Then I should see "Find Ratings for a Breed"