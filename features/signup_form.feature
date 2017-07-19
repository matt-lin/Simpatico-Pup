Feature: user should provide a username during signup
	As a user I should able to signup
	a new account with valid info
	
	Given the following users exist:
        | username       | email               | password       | password_confirmation|
        | jeff           | jeff@berkeley.edu   | 12345678       | 12345678             |
        | gilbert        | gilbert@berkeley.edu| 12345678       | 12345678             |
	
  Scenario: Add username field in the signup process
    Given I am on the Signup page
    Then I should see "Username"
    And I should see "Email"
    And I should see "Password confirmation"
    And I should see "Password"
    
  Scenario: Add user agreement in the signup page
    Given I am on the Signup page
    Then I should see "Terms of Service"
    And I should see "Privacy Policy"
    #deleted Test case: User agreement [no agreement exist in this page]
    #TODO: Testing the form and link terms of service and privacy policy
  
  Scenario: Email has already been taken (sad path)
    Given Iam on the Signup page
    
  Scenario: Password less than 8 (sad path)
    
  Scenario: Password not same as password_confirmation(sad path)
    