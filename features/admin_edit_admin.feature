# Iter 4-1 Only owner can delete other admin (By Gung Hiu Ho, Licong Wang)
Feature: Only owner can delete other admin 
  As the owner of this website, 
  I want to be able to add or delete administrator accounts 
  So that I can decide exactly who should be the administrator
  
  Background:
    Given the following admin exist:
      | email                    | password |
      | owner@berkeley.edu       | 12345678 |
      | non_owner1@berkeley.edu  | 12345678 |
      | non_owner2@berkeley.edu  | 12345678 |

  Scenario: the website ownder should be able to edit other admins
    Given I login as admin "owner@berkeley.edu" with password "12345678"
    When admin go to admin_users
    Then I should see all of:
      | owner@berkeley.edu |
      | non_owner1@berkeley.edu |
      | non_owner2@berkeley.edu |
    When the current admin delete the rank "2" admin
    Then I should see "owner@berkeley.edu"
    And I should not see "non_owner1@berkeley.edu"
    And I should see "non_owner2@berkeley.edu"
  
  Scenario: non website owner shouldn't be able to edit other admins
    Given I login as admin "non_owner1@berkeley.edu" with password "12345678"
    When admin go to admin_users
    Then I should see all of:
      | owner@berkeley.edu |
      | non_owner1@berkeley.edu |
      | non_owner2@berkeley.edu |
    And I should not see "edit"
    And I should not see "delete"
    
  Scenario: non website owner shouldn't be able to access edit page by changing url
    Given I login as admin "non_owner1@berkeley.edu" with password "12345678"
    When admin go to /admin_users/3/edit
    Then I should see "Warning: You don't have enough privilege to edit another admin"
    
# End for Iter 4-1