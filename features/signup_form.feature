Feature: user should provide a username during signup
	As a website admin
	In order to view comment record of each user
	I should use a username field associated with each user
	
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
    #deleted Test case: User agreement [no agreement exist in this page]
    #TODO: Testing the form and link terms of service and privacy policy
    
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
    
    