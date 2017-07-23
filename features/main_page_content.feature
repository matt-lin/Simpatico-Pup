
Feature: see content on the main page 
    As a user of RateMyPup
    So that I can use the site 
    I want to be able to see information about these

Background:
  Given the following users exist:
      | username       | email               | password       | password_confirmation| activated |
      | gilbert        | gilbert@berkeley.edu| 12345678       | 12345678             | true      |
      
  And I am on the RateMyPup home page
  And I log in as "gilbert"

Scenario: information content on main page 
    Given I am on the RateMyPup home page
    And I should see "Contact"

# Scenario: Hover over buttons should show hidden div 
#     Given I am on the RateMyPup home page
#     Then I should see "If your dog is of unknown ancestry or is a breed or cross that is not listed in our database, we appreciate your willingness to contribute information about your dog but do not have a meaningful way of organizing data for your dog at this time."
#     Then I should see "Mission"
#     When I follow "Find Ratings for a Breeder"
#     Then I should see "Find a breeder or kennel by name:"

Scenario: Direct to rate your pup 
    Given I am on the RateMyPup home page
    When I follow "Rate your Dog"
    Then I should be on the "Dog Name" page

Scenario: Add nav tabs in navbar
    Given I am on the RateMyPup home page
    Then I should see "Background"
    And I should see "Goals"
    And I should see "How You Can Help"
    
Scenario: search by breed button should have correct text
  Given I am on the RateMyPup home page
  Then I should see "Find Ratings for a Breed"