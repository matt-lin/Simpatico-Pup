Feature: user should provide a username during signup
	As a website admin
	In order to view comment record of each user
	I should use a username field associated with each user
	
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