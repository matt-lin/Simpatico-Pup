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
  
  Scenario: User click the 'My Account' drop down button
    When I click "My Account"
    Then I should see "My Pups"
    And I should see "Edit Profile"
    
  Scenario: User use the 'My Account' drop down button to go to My pups page
    When I click "My Account"
    And I follow "My Pups"
    Then I should be on the "Pups Ratings" page
    And I should see "My Pups"
    
  Scenario: User use the 'My Account' drop down button to go to edit profile
    When I click "My Account"
    And I follow "Edit Profile"
    Then I should be on the "Edit Profile" page
    And I should see "Change Password"
    And I should see "Delete Account"
# End iter 4-1  
  