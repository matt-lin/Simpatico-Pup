Feature: Admin should be able to see all the users who are subscribing newsletters and be able to process group emailing
    As an admin
    I want to be able to process group emailing to all the users who are subscribing newsletter
    So that I can send out newsletters conveniently
    
Background: Admin already login
    Given I login as an admin
    And I go to "newsletter_users"
    
    And the following newsletter_user exist:
        | email                 |
        | jeff@berkeley.edu     |    
        | gilber@berkeley.edu   |
        | suibianjia@berkely.edu|
        
    Scenario: admins inspect who are subscribing
      Then I should be on the "Admin NewsletterUser" page