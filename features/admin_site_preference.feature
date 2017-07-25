# Iter 3-1 Validate the functionality of site preference page in admin page (by Gung Hiu Ho, Licong Wang) 
Feature: edit the content for the main page
  As an administrator 
  I want to change and edit the text in site preference pageW
  So that I can edit content in main the page on admin page
  
  Background: Given I login as an admin
    Given I login as an admin
   
  Scenario: login and expect to see a user comments
    When admin go to customizes
    Then admin should see "Title message"
    And admin should see "Button a text"
    And admin should see "Button b text"
    And admin should see "Button c text"
    And admin should see  "welcome message"
    
  Scenario: Change the title message and apply the change on the main page
    When admin go to site_preference
    When I fill in "title_message" with "hi title"
    And  I press "Submit"
    Then I should see "The content has been modified"
    When I am in the homepage
    Then I should see "hi title"

  Scenario: Change the button text and apply the change on the main page
    When admin go to site_preference
    When I fill in "button_a_text" with "rate my puppy"
    And  I press "Submit"
    Then I should see "The content has been modified"
    When I am in the homepage
    Then I should see "rate my puppy"
    And I should not see "rate my dog"

# End Iter 3-1