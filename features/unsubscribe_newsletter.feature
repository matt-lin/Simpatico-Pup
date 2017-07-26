Feature: users should be able to unsubscribe newsletters in the newsletter they receive
  
    As a users
    I want to be able to unsubscribe newsletter in the newsletter I receive
    So that it would be most convenient for me

Background: 
    Given the following newsletter_user exist:
          | email                    |
          | jeff@berkeley.edu        |    
          | gilbert@berkeley.edu     |
          | suibianjia@berkeley.edu  | 
    And I login as an admin
    And admin go to newsletter_users
    And I check "batch_action_item_1"
    And I submit the batch action form with "email"
    
    Scenario: user unsubscribe by interacting with the newsletter they receive
      When  "jeff" go to the link to unsubscribe newsletter
      Then  I should be on the RateMyPup home page
      And   "jeff" is not in the subscribing group
      
    Scenario: user remain subscribing if not doing anything
      When  "jeff" simply open the email
      Then  "jeff" is in the subscribing group