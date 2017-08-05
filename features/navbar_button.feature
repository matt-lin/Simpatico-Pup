# Iter 4-1
Feature: Add dropdown button to nav-bar to access edit profile and my pups page
  As a user
  I want to see a nicer website
  So that I can have better UI experience
    
Background: User already login
  Given the default layout exist
  Given I am on the RateMyPup home page
  
  And the following users exist: 
    | username       | email               | password       | password_confirmation| activated |
    | gilbert        | gilbert@berkeley.edu| 12345678       | 12345678             | true      |

  Given I log in as "gilbert"
  When I click the nav bar dropdown button
  
  Scenario: User click the 'My Account' drop down button should see the dropdown list
    Then I should see "My Pups"
    And I should see "Settings"
    And I should see "Logout"
    
  Scenario: User use the 'My Account' drop down button to go to My pups page
    And I follow "My Pups"
    Then I should be on the "Pups Ratings" page
    And I should see "My Pups"
    
  Scenario: User use the 'My Account' drop down button to go to edit profile
    And I follow "Settings"
    Then I should be on the "Edit Profile" page
    And I should see "Change password"
    And I should see "Newsletter subscription"
    And I should see "Delete account"
# End iter 4-1  
  