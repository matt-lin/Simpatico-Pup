@javascript
Feature: autofill breeder name into breeder forms
  As a potential dog owner
  So that I can add a pup to or search by a breeder
  I want to be able to see the breeder name autofill into the form or add a new breeder if it isn't shown

  Background: breeders have been added to the database

    Given the following breeders exist:
      | name            | city     | state |
      | Chris            | Berkeley | CA    |
      | Alex           | Berkeley | CA    |
      | Carl            | Berkeley | CA    |
      | Alexander       | Berkeley | CA    |
      | Michael Jackson | Berkeley | CA    |
      | Chan            | Berkeley | CA    |


    And I am on the RateMyPup home page
    And I click ".button-c"

  Scenario: fill all breeders that start with C
    When I enter "C" into autocomplete "breeder_find" with "keyup"
    Then I should see "Chris"
    And I should see "Carl"
    And I should see "Chan"
    And I should not see "Alex"
    

  Scenario: fill all breeders that start with a substring
    When I enter "A" into autocomplete "breeder_find" with "keyup"
    Then I should see "Alex"
    And I should see "Alexander"
    And I should not see "Carl"
    And I should not see "Michael Jackson"
    

