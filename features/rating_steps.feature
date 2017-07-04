#@javascript
Feature: Split rating process into a few steps
  As a dog owner, when I rate my puppy
  So that I can make sure I am allowed to rate my puppy before I enter too much information
  I want to provide information interactively
  
Background: User already logged in
  Given I am on the RateMyPup home page
  And I am logged in
  And the following breeders exist:
      | name            | city     | state |
      | Carl            | Berkeley | CA    |
      | Alex            | Berkeley | CA    |

  Scenario: step0->1, direct to dog name page
    Given I am on the RateMyPup home page
    When I follow "Rate your Dog"
    Then I should be on the "Dog Name" page
    And I should see "What's your dog's name?"

  Scenario: step1->2(happy), submit form with valid dog name
    Given I am on the "Dog Name" page
    When I fill in "pup_pup_name" with "Doggie"
    And I press "next_button"
    Then I should be on the "Dog How Long" page
    And I should see "How long have you owned your dog?"

  Scenario: step1->1(sad), submit form with invalid dog name
    Given I am on the "Dog Name" page
    When I fill in "pup_pup_name" with ""
    And I press "next_button"
    Then I should be on the "Dog Name" page
    And I should see "Please input a name"

  Scenario: step2->3(happy), submit with valid years and months
    Given I am on the "Dog How Long Test" page
    When I fill in "pup_years" with "1"
    And I fill in "pup_months" with "1"
    And I press "next_button"
    Then I should be on the "Dog Breed" page
    And I should see "Please indicate your dog's breed."
  
  Scenario: step2->0(sad), submit form with invalid years and months
    Given I am on the "Dog How Long Test" page
    When I fill in "pup_years" with "0"
    And I fill in "pup_months" with "4"
    And I press "next_button"
    Then I should see "Go Back to Homepage"
    And I should see "To keep our database as accurate as possible, we are collecting information only for dogs that have been residing in their current home for six months or more. Please come back to our site and rate your dog after s/he has lived with you for a minimum of six months. Thank you."

  Scenario: step3->4(happy), submit with valid breed input
    Given I finished previous steps
    And I am on the "Dog Breed Test" page
    And I fill in "breed_find" with "Affenpinscher"
    And I press "next_button"
    Then I should be on the "Dog Breeder" page

  Scenario: step3->0(sad), submit with invalid breed input
    Given I finished previous steps
    And I am on the "Dog Breed Test" page
    And I fill in "breed_find" with "Affenpinsche"
    And I press "next_button"
    Then I should be on the "Dog Breed" page
    And I should see "Please select a breed in the list."
    And I should see "Close"

  Scenario: step4->new(happy), submit with either breeder name or kennel name
    Given I finished previous steps
    And I am on the "Dog Breeder Test" page
    When I fill in "breeder_form" with "Alex - Berkeley, CA"
    And I press "next_button"
    Then I should be on the "Create New Pup" page
    And I should see "Rate Your Dog"
    
  Scenario: step4->4(sad), submit with empty breeder name and kennel name
    # Given I finished previous steps
    # And I am on the "Dog Breeder Test" page
    # And I press "next_button"
    # Then I should be on the "Create New Pup" page
    
