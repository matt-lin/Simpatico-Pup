#Iter 2-1
Feature: Users should be able to reset password
  As a user
  I want to be able to reset my password
  So that I can get my account back even if I forget my password
  Background: 
  
    Given the following users exist:
        | username       | email               | password       | password_confirmation|
        | jeff           | jeff@berkeley.edu   | 12345678       | 12345678             |
        | gilbert        | gilbert@berkeley.edu| 12345678       | 12345678             |
    
    Scenario: users can go to the password-reset page with all valid email (happy path)
      Given I am on the "Sign in" page
      And   I follow "Forgot your password?"
      Then  I should be on the "Enter Email" page
      When  I fill in "password_reset[email]" with "jeff@berkeley.edu"
      And   I press "Submit"
      Then  I should be on the RateMyPup home page
      And   I should see "Email sent with password reset instructions"
      When  "jeff" go to the link contained by the sent email
      Then  I should be on the Jeff's "Edit Password" page
      
    Scenario: users stays on the same page if the entered email is invalid (sad path)
      Given I am on the "Enter Email" page
      When  I fill in "password_reset[email]" with "invalid@berkeley.edu"
      And   I press "Submit"
      Then  I should be on the "Enter Email" page
      And   I should see "Email address not found"
      
    Scenario: users can reset password in the password-reset page with valid info (happy path)
      Given I am on the "Enter Email" page
      And   I enter "jeff"'s email and click on the url from the sent email
      And   I enter valid new password info and press "Update password"
      Then  I should be on the RateMyPup home page
      When  I follow "Login"
      And   I enter "jeff"'s email and new password and log in
      Then  I should be on the RateMyPup home page
      And   I should see "Signed in successfully."
      
    Scenario: users' passwords' lengths can not be less than 8 characters (invalid info 1) (sad path)
      Given I am on the "Enter Email" page
      And   I enter "jeff"'s email and click on the url from the sent email
      And   I enter invalid new password info and press "Update password"
      Then  I should be on Jeff's "Edit Password" page
      And   I should see "Password must contain more than 8 characters"
      
    Scenario: the entered confirmation password is different from the entered password (invalid info 2) (sad path)
      Given I am on the "Enter Email" page
      And   I enter "jeff"'s email and click on the url from the sent email
      And   I enter different password info and press "Update password"
      Then  I should be on Jeff's "Edit Password" page
      And   I should see "Password not same as Confirmation"
      
    Scenario: user can reset password even if he's logged in
      Given I am on the RateMyPup home page
      And   I log in as "jeff"
      When  I follow "Edit Profile"
      And   I follow "(forgot password)"
      Then  I should be on the RateMyPup home page
      And   I should see "Email sent with password reset instructions"
      
    Scenario: one reset-password link sent by email can only be used once
      Given I am on the "Enter Email" page
      And   I enter "jeff"'s email and click on the url from the sent email
      And   I click on that url again
      Then  I should be on the "Enter Email" page
