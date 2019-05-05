Feature: Only owner can delete other admin 
  As the owner of this website, 
  I want to be able to add or delete administrator accounts 
  So that I can decide exactly who should be the administrator
  
  Background:
    Given the default layout exist
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
  
  @javascript
  Scenario: the website ownder should be able to delete other admins
    Given I login as the website owner
    When admin go to admin_users
    Then I should see all of:
      | owner@berkeley.edu |
      | non_owner@berkeley.edu |
    When I follow "Delete" for "admin_user_2"
    And a confirmation box saying "Are you sure you want to delete this?" should pop up
    And I accept confirmation dialogs
    Then I should not see "non_owner@berkeley.edu"

  Scenario: the website ownder should be able to delete other admins but not self with batch action
    Given I login as the website owner
    When admin go to admin_users
    Then I should see all of:
      | owner@berkeley.edu |
      | non_owner@berkeley.edu |
    When I check "batch_action_item_1"
    When I check "batch_action_item_1"
    Then I submit the batch action form with "destroy"
    Then I should not see "non_owner@berkeley.edu"
    Then I should see "Warning: Site owner can not be deleted"

  @javascript
  Scenario: the website ownder should not be able to delete him/herself
    Given I login as the website owner
    When admin go to admin_users
    Then I should see all of:
      | owner@berkeley.edu |
      | non_owner@berkeley.edu |
    When I follow "Delete" for "admin_user_1"
    And a confirmation box saying "Are you sure you want to delete this?" should pop up
    And I accept confirmation dialogs
    Then I should see "Warning: Site owner can not be deleted"
  
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
    Then I should see "Warning: You don't have enough privilege to perform operation: edit"
    