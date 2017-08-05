Feature: Only owner can delete other admin 
  As the owner of this website, 
  I want to be able to add or delete administrator accounts 
  So that I can decide exactly who should be the administrator
  
  Background:
    Given the following admin exist:
      | email                   | password |
      | owner@berkeley.edu      | password |
      | non_owner@berkeley.edu  | password |

  Scenario: the website ownder should be able to edit other admins
    Given I login as the website owner
    When admin go to admin_users
    Then I should see all of:
      | owner@berkeley.edu |
      | non_owner@berkeley.edu |
    When the current admin change the rank "2" admin email to "test@berkeley.edu"
    Then I should see "test@berkeley.edu"
  
  Scenario: non website owner shouldn't be able to edit other admins
    Given I login as admin "non_owner@berkeley.edu" with password "password"
    When admin go to admin_users
    Then I should see all of:
      | owner@berkeley.edu |
      | non_owner@berkeley.edu |
    And I should not see "edit"
    And I should not see "delete"
    
  Scenario: non website owner shouldn't be able to access edit page by changing url
    Given I login as admin "non_owner@berkeley.edu" with password "password"
    When admin go to /admin_users/1/edit
    Then I should see "Warning: You don't have enough privilege to edit another admin"
    