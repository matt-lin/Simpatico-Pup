# Iter 2-1
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
        
    Scenario: admins inspect who are subscribing when there are subscriber
      And admin go to newsletter_users
      Then I should see "jeff@berkeley.edu"
      And I should see "gilbert@berkeley.edu"
      And I should see "gj@berkeley.edu"
     
    #following scenario not implemented
    Scenario: admins process group emailing with subject, message, and attachment
      And admin go to newsletter_users
      And check all subscribers
      And I send emails with subject as "subject" and message as "message" with an attachment
      Then all the users should get an email with "subject" and "message" with an attachment
      
    Scenario: admins process emailing with subject, message, and attachment to checked subscribers
      And admin go to newsletter_users
      And I check "batch_action_item_1"
      And I send emails with subject as "subject" and message as "message" with an attachment
      Then "jeff" should get an email with "subject" and "message" with an attachment
      And "gilbert" should not receive an email
    
# End for Iter 2-1
      