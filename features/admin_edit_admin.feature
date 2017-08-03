# Iter 4-1 Only owner can delete other admin (By Gung Hiu Ho, Licong Wang)
Feature: Only owner can delete other admin 
  As the owner of this website, 
  I want to be able to add or delete administrator accounts 
  So that I can decide exactly who should be the administrator
  
  Background: Logged in as an admin
    Given the following admin exist:
      | name    | password     |
      | Mary    | password1    |
      | Tom     | password2    |

  Scenario: try delete Mary as owner
    Given I login as an admin
    When admin go to admin_users
    Then I should see all of:
      | Mary |
      | Tom  |
    When owner delete "Tom"
    Then I should see "Admin has been deleted"
  
  Scenario: Mary shouldn't able to delete other admin
    Given I login as admin "Mary"
    When admin go to admin_users
    Then I should see all of:
      | Mary |
      | Tom  |
    And I should not see "Delete"
    
# End for Iter 4-1