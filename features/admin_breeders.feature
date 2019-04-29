# Iter 2-1 Breeder page validation (By Raymond Gu)
Feature: View detailed imformation of all breeders 
  As an administrator 
  I want to check the details of every registered breeder
  So that I can find the corresponding dogs 
  
  Background: Logged in and dogs have been added to the database
    Given I login as an admin

    Given the following breeders exist:
      | name            | city     | state |
      | Carl            | Berkeley | CA    |
      | Chris           | Seattle  | WA    |
      
  Scenario: login and expect to see breeder information
    When admin go to breeders
    Then I should see all of:
      | Carl      |
      | Chris      |
      | Berkeley  |
      | CA        |
      | Seattle |
      | WA     |
  
  Scenario: click a username should see its details
    When admin go to breeders
    And I follow "Carl"
    Then I should see all of:
      | Carl |
      | Berkeley |
      | CA  |
      | Dogs |
    
# End for Iter 2-1