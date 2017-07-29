# Iter 3-1
Feature: Admin should be able to send email templates, so user do not need type in every time
    I want to be able to send an email templatewith that already save in admin
    
    Background: Logged in and subscribed email have been added to the database
        Given I login as an admin
        And the following newsletter_user exist:
              | email                      |
              | jcjack@berkeley.edu        |    
              | zipeiw@berkeley.edu        |
              | gj@berkeley.edu            | 
        And the following email_templates exist:
        |   title       | body      |  marked   |
        | title1        | body1     |   ture    |
        | wellcome      | hi        |   false   |
    
    
        Scenario: admins able to creat a new email_templates
          Given admin go to email_templates
          And I follow "New Email Template"
          And I fill in "email_template_title" with "Ex title"
          And I fill in "email_template_body" with "Ex body"
          And I press "Create Email template"
          And I should see "Email template was successfully created."
          And admin go to email_templates
          And I should see "Ex title"
          And I should see "Ex body"
        
          
        Scenario: able to send email_templates to newsletter_user
          Given admin go to email_templates
          And I check "batch_action_item_1"
          And I submit the batch action form with "send"
          Then I should see "Newsletter Users"
          
          And I check "batch_action_item_1"
          And I submit the batch action form with "email"
          Then I should see "The batch email has been sent to all the users"
          Then "jcjack" should get an email with "welcome" and "hi" 
          
########################### sad path ##########################################
        
        Scenario: only allowed one email_template been select, since email_template and email is one to one 
          Given admin go to email_templates
          When I check "batch_action_item_1"
          And I check "batch_action_item_2"
          And I submit the batch action form with "send"
          Then I should see "A email can only includ one Email Template"
          
#Iter 3-1