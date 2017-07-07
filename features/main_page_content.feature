<<<<<<< HEAD
=======
#@javascript
>>>>>>> 0cabc07e64af08358619ce1666083c873d2aaf37
Feature: see content on the main page 
    As a user of RateMyPup
    So that I can use the site 
    I want to be able to see information about these

Background:
    Given I am on the RateMyPup home page
    Given I am logged in

Scenario: information content on main page 
    Given I am on the RateMyPup home page
    And I should see "Contact"

Scenario: Hover over buttons should show hidden div 
    Given I am on the RateMyPup home page
<<<<<<< HEAD
    Then I should see "If your dog is of unknown ancestry or is a breed or cross that is not listed in our database, we appreciate your willingness to contribute information about your dog but do not have a meaningful way of organizing data for your dog at this time."
    Then I should see "Mission"
    When I follow "Find Ratings for a Breeder"
=======
    When I press a hidden button ".button-b"
    Then I should see "Search for ratings by breed:"
    When I press a hidden button ".button-c"
>>>>>>> 0cabc07e64af08358619ce1666083c873d2aaf37
    Then I should see "Find a breeder or kennel by name:"

Scenario: Direct to rate your pup 
    Given I am on the RateMyPup home page
<<<<<<< HEAD
    When I follow "Rate your Dog"
=======
    And I am logged in
    When I press a hidden button ".button-a"
>>>>>>> 0cabc07e64af08358619ce1666083c873d2aaf37
    Then I should be on the "Dog Name" page

Scenario: Add nav tabs in navbar
    Given I am on the RateMyPup home page
    Then I should see "Background"
    And I should see "Goals"
    And I should see "How You Can Help"
    
Scenario: search by breed button should have correct text
  Given I am on the RateMyPup home page
  Then I should see "Find Ratings for a Breed"