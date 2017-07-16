Feature: Users should be able to reset password
  As a user
  I want to be able to reset my password
  So that I can still access to my account if I forget my password
  
Background: 
  
    Given the following users exist:
        | username       | email               | password       | password_confirmation|
        | jeff           | jeff@berkeley.edu   | 12345678       | 12345678             |
        | gilbert        | gilbert@berkeley.edu| 12345678       | 12345678             |
    
    Scenario: uesrs can reset password with all valid info (happy path)
      Given I am on the "Sign in" page
      And   I follow "Forget your password?"
      Then  