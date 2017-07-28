@javascript
Feature: autofill breeder name and city/state information in dog_breeder step in rating
  As a potential dog owner
  So that I can add a pup to or search by a breeder
  I want to be able to see the breeder name autofill into the form or add a new breeder if it isn't shown

  Background: breeders have been added to the database
    Given the default layout exist
    Given the following breeders exist:
      | name            | city     | state |
      | Carl            | Berkeley | CA    |
      | Chris           | Seattle  | WA    |
      | Alex            | Berkeley | CA    |
      | Alexander       | Austin   | TX    |
      | Michael Jackson | Berkeley | CA    |


    And I am on the "Dog Breeder Test" page

 #  Scenario: fill all breeders that start with C
  #   When I enter "C" into autocomplete "breeder_find" with "keyup"
   #  Then I should see "Chris - Berkeley, CA"
    # And I should see "Carl - Seattle, WA"
     #And I should not see "Alex"
     #And I should see "Don't see it? Add a new breeder"

  # Scenario: fill all breeders that start with a substring
  #   When I enter "Alex" into autocomplete "breeder_find" with "keyup"
  #   Then I should see "Alex - Berkeley, CA"
  #   And I should see "Alexander - Austin, TX"
  #   And I should not see "Carl"
  #   And I should not see "Michael Jackson"
  #   And I should see "Don't see it? Add a new breeder"

  # Scenario: redirect to create new breeder
  #   When I enter "Jmac" into autocomplete "breeder_find" with "keyup"
  #   And I should not see "Carl"
  #   And I should not see "Michael Jackson"
  #   And I should see "Don't see it? Add a new breeder"
  #   When I follow "Don't see it? Add a new breeder"
  #   Then I should be on the "Add breeder" page

