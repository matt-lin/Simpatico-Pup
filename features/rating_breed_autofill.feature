
@javascript
Feature: select dog breed using when using rating
  
  As a dog rater
  So that add a rating
  I want to enter a dog breed
  
Background: User already logged in
  Given I am on the RateMyPup home page
  And I am logged in
  And I finished previous steps
  And I am on the "Dog Breed Test" page

  Scenario: fill in partial of the name
    When I enter "af" into autocomplete "breed_find" with "keyup"
    Then I should see "Affenpinscher"
    And I should see "Afghan Hound"
    And I should not see "Akita"
    
  # Scenario: don't know the breed or not finding the breed
  #   When I press "back_button"
  #   Then I should be on the RateMyPup home page