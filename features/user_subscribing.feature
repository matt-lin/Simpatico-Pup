Feature: Dog owners should be able to subscribe or unsubscribe newsletters 
    As a user
    I want to be able to subscribe or unsubscribe newsletters
    So that I can keep up with the news if interested
    
Background: User already login
    Given I am on the RateMyPup home page
    
    And the following users exist:
        | username       | email               | password       | password_confirmation|
        | jeff           | jeff@berkeley.edu   | 12345678       | 12345678             |
        | gilbert        | gilbert@berkeley.edu| 12345678       | 12345678             |
    
    And the following newsletter_user exist:
        | email               |
        | jeff@berkeley.edu   |
    
    Scenario: users subscribing newsletters
      Given I log in as "gilbert"
      And I am on the "Edit Profile" page
      Then I should see "Click here if we may add you to our mailing list to receive occasional updates on the progress of our website. We will not share your email address with anyone else"
      When I check "subscribe_newsletter"
      And I fill in "user_current_password" with "12345678"
      And I press "update_button"
      Then I should be on the RateMyPup home page
      And "gilbert" is in the subscribing group
      
    Scenario: users unsubscribing newsletters
      Given I log in as "jeff"
      And I am on the "Edit Profile" page
      Then I should see "Click here to unsubscribe newsletter :("
      When I check "unsubscribe_newsletter"
      And I fill in "user_current_password" with "12345678"
      And I press "update_button"
      Then I should be on the RateMyPup home page
      And "jeff" is not in the subscribing group