# Iter 3-1
@javascript
Feature: User should be able to edit their previous pups' ratings
    As a user
    I want to modify my dog ratings
    So that when I make a mistake or change my mind, I can edit the ratings
    
Background: User already login
  Given the default layout exist
  Given I am on the RateMyPup home page
  
  And the following users exist: 
    | username       | email               | password       | password_confirmation| activated |
    | jeff           | jeff@berkeley.edu   | 12345678       | 12345678             | true      |
    | gilbert        | gilbert@berkeley.edu| 12345678       | 12345678             | true      |

  And the following breeds exist:
    | name            | 
    | Affenpinscher   |
    | Afghan Hound    |
    | Akita           |
    | Chan            |
  
  And the following breeders exist:
    | name            | city     | state |
    | Unknown         |          |       |
    | Carl            | Berkeley | CA    |
    | Juju            | Berkeley | CA    |

  And the following pups exist:
    | pup_name        | breeder_id  | breed_id | user_id | breeder_responsibility | overall_health | trainability | dog_behavior    | social_behavior | energy_level | simpatico_rating | year | month |
    | dog1            | 3           | 2        | 1       | 4                      | 4              | 3            | 2               | 5               | 3            | 4                | 1    | 1     |
    | dog2            | 1           | 1        | 1       | 4                      | 4              | 3            | 2               | 5               | 3            | 4                | 1    | 1     |
    | dog3            | 2           | 3        | 2       | 3                      | 4              | 3            | 2               |4                | 4            | 3                | 1    | 1     |
  
  And   I should not see "My Pups"
  
  Given I log in as "jeff"
  When I click the nav bar dropdown button
  And I follow "My Pups"
  Then  I should be on the "Pups Ratings" page
  
  Scenario: users can see pups ratings
    And   I should see "dog1"
    And   I should see "dog2"
    And   I should not see "dog3"
  
  Scenario: users can delete ratings 
    When  I follow "Delete" for dog1
    Then  I should be on the RateMyPup home page
    And   I should see "Pup dog1 has been deleted"
    When  I am on the "Pups Ratings" page
    Then  I should not see "dog1"'s basic info
    And   I should see "dog2"'s basic info
    
  Scenario: users can edit ratings
    When  I follow "Edit" for dog1
    Then  I should be on the "Edit Pup Rating" page
    When  I fill in new info
    And   I press "Update"
    Then  I should be on the "Pups Ratings" page
    And   I should see "Pup has been updated"
    When  I follow "More" for dog1
    Then  I should see correct info updated
    
  Scenario: users can cancel the edit before saving
    When  I follow "Edit" for dog1
    And   I fill in new info
    And   I follow "Cancel"
    Then  I should be on the "Pups Ratings" page
    When  I follow "More" for dog1
    Then  I should see correct info of dog1
    
  Scenario: users can add breeder if he wants
    When  I follow "Edit" for dog1
    And   I fill in with a non-existing breeder
    And   I press "Update"
    Then  I should be on the "Edit Pup Rating" page
    And   I should see "The breeder you enter is not in our database" 
    When  I follow "Add Breeder"
    And I wait for 1 seconds
    Then  I should be on the "Add breeder" page
    When  I finish adding a new breeder 
    Then  I should be on the "Edit Pup Rating" page
    And   I should see "Breeder has been updated!"
  
  Scenario: users can go to details page and delete pup
    When  I follow "More" for dog1
    Then  I should be on the "Pup Rating Detail" page
    And   I should see correct info of dog1
    When  I press "Delete pup"
    And I wait for 1 seconds
    Then  I should be on the RateMyPup home page
    And   I should see "Pup dog1 has been deleted"
    When  I am on the "Pups Ratings" page
    Then  I should not see "dog1"
    And   I should see "dog2"'s rating    
    
  Scenario: users can go to details page and edit pup
    When  I follow "More" for dog1
    When  I press "Edit pup"
    And I wait for 1 seconds
    Then  I should be on the "Edit Pup Rating" page
#End iter 3-1