Feature: user should provide a username during signup
	As a user I should able to signup
	a new account with valid info
	
	Given the following users exist:
        | username       | email               | password       | password_confirmation|
        | jeff           | jeff@berkeley.edu   | 12345678       | 12345678             |
        | gilbert        | gilbert@berkeley.edu| 12345678       | 12345678             |
	
Background: The user is on signup page
  Given I am on the Signup page
	
  Scenario: Add username field in the signup process
    Then I should see "Username"
    And I should see "Email"
    And I should see "Password confirmation"
    And I should see "Password"
    
  Scenario: Add user agreement in the signup page
    Then I should see "Terms of Service"
    And I should see "Privacy Policy"


  


    
  Scenario: Sign up and get an instruction to read the confirmation email 
    Then I fill in "user_username" with "example"
    And I fill in "user_email" with "example@simpaticopup.com"
    And I fill in "user_password" with "password"
    And I fill in "user_password_confirmation" with "password"
    And I check "user_agreement"
    And I press "Signup"
    Then I should see "You have signed up! Please check your mailbox and follow the link to activate your account."
    
  Scenario: Follow the link in the confirmation email to complete the sign up process
    Then I enter "example"'s email and click on the url from the sent email
    Then I should be on Activation Page
    And I press "Activate"
    Then I should See "You have successfully activated your account!"
    And I should have logged in as "example"
    
  Scenario: Email has already been taken (sad path)
    Then I fill in "user_username" with "example2"
    Then I fill in "user_email" with "jeff@berkeley.edu"
    And I fill in "user_password" with "12345678"
    And I fill in "user_password_confirmation" with "12345678"
    And I check "user_agreement"
    And I press "Signup"
    Then I should see "Email has already been taken"
    
  Scenario: Password less than 8 (sad path)
    Then I fill in "user_username" with "example3"
    Then I fill in "user_email" with "ex@ec.com"
    And I fill in "user_password" with "12"
    And I fill in "user_password_confirmation" with "12"
    And I check "user_agreement"
    And I press "Signup"
    Then I should see "Password is too short (minimum is 8 characters)"
    
    
  Scenario: Password not same as password_confirmation(sad path)
    Then I fill in "user_username" with "example4"
    Then I fill in "user_email" with "eeex@ec.com"
    And I fill in "user_password" with "12345678"
    And I fill in "user_password_confirmation" with "87654321"
    And I check "user_agreement"
    And I press "Signup"
    Then I should see "Password confirmation doesn't match Password"
    

    