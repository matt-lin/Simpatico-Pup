Feature: Flash warning/error should only show once
  As a user, when I rate my dog(in step dog_how_long and dog_breed)
  I should only see the result errors/warnings as a pop up
  And I should not see the errors/warnings as a repeated flash message
  

Background: User already logged in
  Given I am on the RateMyPup home page
  And I am logged in
  And the following breeders exist:
      | name            | city     | state |
      | Carl            | Berkeley | CA    |
      | Alex            | Berkeley | CA    |

  Scenario: show error/warning once on dog_how_long
    Given I am on the RateMyPup home page
    When I follow "Rate your Dog"
    And I fill in "pup_name" with "Alex"
    And I press "next_button"
    When I select "0" in the dropdown list "pup_years"
    And I fill in "pup_months" with "1"
    And I press "next_button"
    Then I should see "To keep our database as accurate as possible, we are collecting information only for dogs that have been residing in their current home for six months or more. Please come back to our site and rate your dog after s/he has lived with you for a minimum of six months. Thank you."
    And I should not see twice "To keep our database as accurate as possible, we are collecting information only for dogs that have been residing in their current home for six months or more. Please come back to our site and rate your dog after s/he has lived with you for a minimum of six months. Thank you."
    
  Scenario: show error/warning once on dog_breed
    Given I finished previous steps
    And I am on the "Dog Breed Test" page
    And I fill in "breed_find" with "not exist breed"
    And I press "next_button"
    Then I should see "Please select a breed in the list."
    And I should see "Close"
    And I should see "We are only collecting information for dogs that are purebred members of an American Kennel Club (AKC) breed, or are among the most popular hybrid crosses of two AKC breeds. If your dog is of unknown ancestry or is a breed or cross that is not listed in our database, we appreciate your willingness to contribute information about your dog but do not have a meaningful way of organizing data for your dog at this time."
    And I should not see twice "Please select a breed in the list."
