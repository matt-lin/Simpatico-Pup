
@javascript
Feature: select dog breed using when using rating
  
  As a dog rater
  So that add a rating
  I want to enter a dog breed
  
  Background: breeders have been added to the database
    
    Given the following breeders exist:
      | name            | city     | state |
      | Carl            | Berkeley | CA    |
      | Cart            | Berkeley | CA    |
      | Judy            | Berkeley | CA    |
      | Justin          | Oakland  | CA    |
      | Juke            | San Jose | CA    |
      | Juju            | Berkeley | CA    |
    Given I am on the RateMyPup home page
    And I am logged in
    And I finished previous steps
    And I am on the "Dog Breeder Test" page

  Scenario: fill in partial of the name
    When I enter "Ju" into autocomplete "breeder_form" with "keyup"
    Then I should see "Judy"
    And I should see "Justin"
    Then I should see "Juke"
    Then I should see "Juju"
    And I should not see "Carl"

