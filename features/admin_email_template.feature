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
        |   Title       | Body      |  Marked   |
        | title1        | body1     |   ture    |
        | wellcome      | hi        |   false   |
    
    
        Scenario: admins able to creat a new email_templates
          Given admin go to email_templates
          And I click "New Email Template"
          And I fill in "title" with "Ex title"
          And I fill in "body" with "Ex body"
          And I click "Create new Email Template"
          And I should see "Email template was successfully created."
          And admin go to email_templates
          And I should see "Ex title"
          And I should see "Ex body"
        
        Scenario: admins check/uncheck email_templates
          When I uncheck "title1"
          Then I should not see "✔"
          And  I should see "✗"	
          When I check "wellcome"
          Then I should see "✔"
          And I uncheck "wellcome"
          Then I should not see "✔"
          
        Scenario: able to send email_templates to newsletter_user
          Given admin go to email_templates
          When I check "wellcome"
          Then I should see "✔"
          And admin go to newsletter_users
          And I check "jcjack@berkeley.edu"
          And I check "batch_action_item_1"
          And I check send email_templates
          Then "jcjack" should get an email with "wellcome" and "hi" 
          
########################### sad path ##########################################
        
        Scenario: only allowed one email_template been select, since email_template and email is one to one 
          When I check "wellcome","title1"
          Then I should see "A email can only includ one Email Template"
          When I check "wellcome"
          Then I should see "wellcome" with "✔"
          And I should see "title1" with "✗"
          When I check "title1"
          Then I should see "title1" with "✔"
          And I should see "wellcome" with "✗"	 
          
#Iter 3-1
          