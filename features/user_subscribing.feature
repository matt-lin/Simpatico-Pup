#Newly added feature file for Iter1-1!

Feature: Dog owners should be able to subscribe or unsubscribe newsletters 
    As a user
    I want to be able to subscribe or unsubscribe newsletters
    So that I can keep up with the news if interested
    
Background: User already login
    Given the default layout exist
    And I am on the RateMyPup home page
    
    And the following users exist:
        | username       | email               | password       | password_confirmation| activated |
        | jeff           | jeff@berkeley.edu   | 12345678       | 12345678             | true      |
        | gilbert        | gilbert@berkeley.edu| 12345678       | 12345678             | true      |
    
    And the following newsletter_user exist:
        | email               |
        | jeff@berkeley.edu   |
    
    Scenario: users subscribing newsletters
      Given I log in as "gilbert"
      And I am on the "Edit Profile" page
      Then I should see "You are currently not subscribing newsletter, click the button below to subscribe newsletter"
      When I press "subscribe_button"
      Then I should be on the "Edit Profile" page
      And I should see "You are subscribing newsletter now!"
      And "gilbert" is in the subscribing group
      
    Scenario: users unsubscribing newsletters
      Given I log in as "jeff"
      And I am on the "Edit Profile" page
      Then I should see "You are currently subscribing newsletter, click the button below to unsubscrib newsletter"
      When I press "unsubscribe_button"
      Then I should be on the "Edit Profile" page
      And I should see "You have unsubscribed newsletter!"
      And "jeff" is not in the subscribing group
      
    # Iter 1-2
    # Scenario: users can not subscribe with wrong password
    #   Given I log in as "gilbert"
    #   And I am on the "Edit Profile" page
    #   Then I check "subscribe_newsletter"
    #   And I fill in "user_current_password" with "incorrect"
    #   And I press "update_button"
    #   Then I should be on the "Correct Back" page
    #   And I should see "Current password is invalid"
      
    # Scenario: users can not unsubscribe with wrong password
    #   Given I log in as "jeff"
    #   And I am on the "Edit Profile" page
    #   Then I check "unsubscribe_newsletter"
    #   And I fill in "user_current_password" with "incorrect"
    #   And I press "update_button"
    #   Then I should be on the "Correct Back" page
    #   And I should see "Current password is invalid"
    # End for Iter 1-2
