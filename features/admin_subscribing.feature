Feature: Admin should be able to see all the users who are subscribing newsletters and be able to process group emailing
    As an admin
    I want to be able to process group emailing to all the users who are subscribing newsletter
    So that I can send out newsletters conveniently
    
Background: Admin already login
    Given I login as an admin
    And I go to "newsletter_users"
        
    Scenario: admins inspect who are subscribing when there are subscriber
      Given the following newsletter_user exist:
        | email                 |
        | jeff@berkeley.edu     |    
        | gilber@berkeley.edu   |
        | suibianjia@berkely.edu|  
      Then I should see "jeff@berkeley.edu"
      And I should see "gilber@berkeley.edu"
      And I should see "suibianjia@berkeley.edu"
      
    Scenario: admins inspect who are subscribing when there aren't subscriber
      Then I should see "There are no Newsletter Users yet"
      
    Scenario: admins unsubscribe users
      And the following newsletter_user exist:
        | email                 |
        | jeff@berkeley.edu     |    
        | gilbert@berkeley.edu  |
        | suibianjia@berkely.edu|
      When I choose "subscriber_1"
      And I press "unsubscribe_button"
      Then I should not see "jeff@berkeley.edu"
      And I should see "gilbert@berkeley.edu"
      
    Scenario: admins process group emailing
      And the following newsletter_user exist:
        | email                 |
        | jeff@berkeley.edu     |    
        | gilbert@berkeley.edu  |
        | suibianjia@berkely.edu|   
      When I press "group_email"
      Then I should be on the "Writing Email" page
      Then I fill in "email_subject" with "Simpatico-pup newsletter"
      And I fill in "email_body" with "simpatico-pup"
      Then I press "send"
      Then All the users should receive an email with "simpatico-pup"
      