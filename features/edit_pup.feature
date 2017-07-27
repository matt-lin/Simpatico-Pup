
Feature: User should be able to edit their previous pups' ratings
    As a user
    I want to modify my dog ratings
    So that when I make a mistake or change my mind, I can edit the ratings
    
Background: User already login
  
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
    | pup_name        | breeder_id  | breed_id | user_id | breeder_responsibility | overall_health | trainability | social_behavior | energy_level | simpatico_rating |
    | dog1            | 1           | 1        | 1       | 4                      | 4              | 3            | 5               | 3            | 4                | 
    | dog2            | 1           | 1        | 1       | 4                      | 4              | 3            | 5               | 3            | 4                |
    | dog3            | 2           | 3        | 2       | 3                      | 4              | 3            | 4               | 4            | 3                |
  
  And   I should not see "My Pups"
  Given I log in as "jeff"
  When  I follow "My Pups"
  Then  I should be on the "Pups Ratings" page
  
  Scenario: users can see pups ratings
    And   I should see "dog1"'s basic info
    And   I should see "dog2"'s basic info
    And   I should not see "dog3"'s basic info
  
  Scenario: users can delete ratings 
    When  I follow "Delete" for "dog1"
    Then  I should be on the RateMyPup home page
    And   I should see "Pup dog1 has been deleted"
    When  I follow "My Pups"
    Then  I should not see "dog1"'s basic info
    And   I should see "dog2"'s basic info
    
  Scenario: users can edit ratings
    When  I follow "Edit" for "dog1"
    Then  I should be on the "Edit Pup Rating" page
    When  I fill in new info
    And   I press "Save"
    Then  I should be on the "Pups Ratings" page
    When  I follow "More" for "dog1"
    Then  I should see correct info updated
    
  Scenario: users can cancel the edit before saving
    When  I follow "Edit" for "dog1"
    And   I fill in new info
    And   I press "Cancel"
    Then  I should be on the "Pups Ratings" page
    When  I follow "More" for "dog1"
    Then  I should see correct info of dog "dog1"
    
  Scenario: users can add breeder if he wants
    When  I follow "Edit" for "dog1"
    And   I fill in with a non-existing breeder
    And   I press "Save"
    Then  I should be on the "Edit Pup Rating" page
    And   I should see "Breeder is not in our database."    
  
  Scenario: users can go to details page and delete pup
    When  I follow "More" for "dog1"
    Then  I should be on the "Pup Rating Detail" page
    And   I should see correct info of dog "dog1"
    When  I follow "Delete"
    Then  I should be on the RateMyPup home page
    And   I should see "Pup dog1 has been deleted"
    When  I follow "My Pups"
    Then  I should not see "dog1"
    And   I should see "dog2"'s rating    
    
  Scenario: users can go to details page and edit pup
    When  I follow "More" for "dog1"
    When  I follow "Edit"
    Then  I should be on the "Edit Pup Rating" page
