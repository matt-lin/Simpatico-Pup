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