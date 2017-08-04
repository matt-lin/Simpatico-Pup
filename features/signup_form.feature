# Iter 2-1
Feature: user should provide a username during signup
	As a user I should able to signup
	a new account with valid info

Background: The user is on signup page
  Given the default layout exist
  Given the following users exist:
        | username       | email               | password       | password_confirmation| activated |
        | jeff           | jeff@berkeley.edu   | 12345678       | 12345678             | false     |
        | gilbert        | gilbert@berkeley.edu| 12345678       | 12345678             | true      |
  
  Given I am on the Signup page
	
  Scenario: What user should see in the signup process
    Then I should see "Username"
    And I should see "Email"
    And I should see "Password confirmation"
    And I should see "Password"
    And I should see "Terms of Service"
    And I should see "Privacy Policy"
    
  Scenario: Activated account should log in successfully
    Given I am on the RateMyPup home page
    Given I log in as "gilbert"
    And I should see "GILBERT"

  Scenario: Sign up and open the mailbox to activate the account 
    Then I fill in "user_username" with "example"
    And I fill in "user_email" with "example@berkeley.edu"
    And I fill in "user_password" with "password"
    And I fill in "user_password_confirmation" with "password"
    And I check "user_agreement"
    And I press "Submit"
    Then I should see "Welcome! You have signed up successfully. Please check your email to activate your account."
    Given I enter "example"'s mailbox and click on the activate in sent email
    Then I should see "Congratulations! Your account has been activated!"
    And I should see "EXAMPLE"
    
  
    # ####################################sad path#####################################################
  Scenario: Email has already been taken (sad path)
    Then I fill in "user_username" with "example2"
    Then I fill in "user_email" with "jeff@berkeley.edu"
    And I fill in "user_password" with "12345678"
    And I fill in "user_password_confirmation" with "12345678"
    And I check "user_agreement"
    And I press "Submit"
    Then I should see "Email has already been taken"
    
  Scenario: Password less than 8 (sad path)
    Then I fill in "user_username" with "example3"
    Then I fill in "user_email" with "ex@ec.com"
    And I fill in "user_password" with "12"
    And I fill in "user_password_confirmation" with "12"
    And I check "user_agreement"
    And I press "Submit"
    Then I should see "Password is too short (minimum is 8 characters)"
    
  Scenario: Password not same as password_confirmation(sad path)
    Then I fill in "user_username" with "example4"
    Then I fill in "user_email" with "eeex@ec.com"
    And I fill in "user_password" with "12345678"
    And I fill in "user_password_confirmation" with "87654321"
    And I check "user_agreement"
    And I press "Submit"
    Then I should see "Password confirmation doesn't match Password"
    
  Scenario: Inactivated acccount should not be able to log in
    Given I am on the RateMyPup home page
    Given I log in as "jeff"
    Then I should see "Account not activated. A new account activation has been send."
    And I enter "jeff"'s mailbox and click on the activate in sent email
    Then I should see "Congratulations! Your account has been activated!"
    And I should see "JEFF"
    
  Scenario: Activated account should not be activated again
    Given I am on the RateMyPup home page
    Given I log in as "jeff"
    And I enter "jeff"'s mailbox and click on the activate in sent email twice
    And I should see "Invalid activation link"
  
# End iter 2-1
    