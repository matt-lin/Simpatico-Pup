# Iter 2-1
#@javascript
Feature: Admin should be able to send emails to subscribed users with attachment 
    As an administrator
    I want to be able to send an email with attachment and photo
    So that I can deliver the newsletter to subscribed users
    
  Background: Logged in and subscribed email have been added to the database
    Given I login as an admin
    And the following newsletter_user exist:
          | email                    |
          | jeff@berkeley.edu        |    
          | gilbert@berkeley.edu     |
          | gj@berkeley.edu  | 
    
    # Iter 2-2
    Scenario: admins mark/unmark uploaded file as attachment
      Given admin go to attachments
      And I have uploaded a file named "eecs.jpg"
      When I mark this uploaded file
      Then I should see "✔"
      And I should not see "✗"
      When I unmark this uploaded file
      Then I should see "✗"	
      And I should not see "✔"
      
    Scenario: admins process emailing with subject, message, and attachment to checked subscribers
      Given admin go to attachments
      And I have uploaded a file named "eecs.jpg"
      When I mark this uploaded file
      And admin go to newsletter_users
      And I check "batch_action_item_1"
      And I send emails with subject as "subject" and message as "message" with an attachment included
      Then "jeff" should get an email with "subject" and "message" with an attachment "eecs.jpg"
      And "gilbert" should not receive an email
    
    Scenario: admins process group emailing with subject, message, and attachment
      Given admin go to attachments
      And I have uploaded a file named "eecs.jpg"
      When I mark this uploaded file
      And admin go to newsletter_users
      And check all subscribers
      And I send emails with subject as "subject" and message as "message" with an attachment included
      Then all the users should get an email with "subject" and "message" with an attachment "eecs.jpg"
      Given admin go to attachments
      When I follow "Delete"
      And I accept confirmation dialogs
    
    # End for Iter 2-2
# End for Iter 2-1
      