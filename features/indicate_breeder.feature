#Newly added feature file for Iter1-1

Feature: Indicate dog breeder when rating a pup
  As a dog owner
  I want to indicate my dog's breeder
  So that people can evaluate the breeder based on my dog's rating.
  
Background: User already login, filled out pup name, how long the user owned the dog, and breed
  Given I am on the RateMyPup home page
  Given I am logged in
  And I finished previous steps
  
  And the following breeds exist:
      | name            |
      | Affenpinscher   |
  
  And the following breeders exist:
      | name            | city     | state |
      | Carl            | Berkeley | CA    |
      | Alex            | Berkeley | CA    |

  Scenario: step4->new(happy), submit with empty breeder name and kennel name
    And I am on the "Dog Breeder Test" page
    And I press "next_button"
    Then I should be on the "Create New Pup" page

  Scenario: step4->new(happy), submit with either breeder name or kennel name that is in db
    And I am on the "Dog Breeder Test" page
    When I fill in "breeder_form" with "Alex - Berkeley, CA"
    And I press "next_button"
    Then I should be on the "Create New Pup" page
    And I should see "Rate Your Dog"
    
  Scenario: step4->create_new_breeder(sad), submit with breeder or kennel name not in database
    And I am on the "Dog Breeder Test" page
    When I fill in "breeder_form" with "random breeder"
    And I press "next_button"
    Then I should be on the "Add breeder" page
    And I should see "Create New Breeder"
    
  Scenario: Create new breeder during the rating process
    And I am on the "Add breeder" page
    When I fill in "breeder_name" with "random breeder"
    And I fill in "breeder_city" with "Berkeley"
    And I select "CA" in the dropdown menu "breeder_state"
    And I press "Add_Breeder"
    Then I should be on the "Create New Pup" page
    And I should see "Rate Your Dog"
    