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
      Given Not yet implemented
      Then I should see "jeff@berkeley.edu"
      And I should see "gilber@berkeley.edu"
      And I should see "suibianjia@berkeley.edu"
      
    Scenario: admins inspect who are subscribing when there aren't subscriber
      Given Not yet implemented
      Then I should see "There are no Newsletter Users yet"
      
    Scenario: admins unsubscribe users
      Given Not yet implemented
      And the following newsletter_user exist:
        | email                 |
        | jeff@berkeley.edu     |    
        | gilber@berkeley.edu   |
        | suibianjia@berkely.edu|
      When I choose "subscriber 1"
      And I click "unsubscribe button"
      Then I should not see "jeff@berkeley.edu"
      
    Scenario: admins process group emailing
      Given Not yet implemented
      And the following newsletter_user exist:
        | email                 |
        | jeff@berkeley.edu     |    
        | gilber@berkeley.edu   |
        | suibianjia@berkely.edu|   
      When I click on "group email"
      Then I should be on the "Writing Email" page
      When I fill in "email body" with "simpatico-pup"
      And I click on "send"
      Then All the users should recieve an email with "simpatico-pup"