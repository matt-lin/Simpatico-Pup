# Iter 3-1 Validate the functionality of site preference page in admin page (by Gung Hiu Ho, Licong Wang) 
Feature: edit the content for the main page
  As an administrator 
  I want to change and edit the text in site preference pageW
  So that I can edit content in main the page on admin page
  
  Background: Given I login as an admin
    Given I login as an admin
   
  Scenario: login and expect to see a user comments
    When admin go to site_preference
    Then admin should see "Title message"
    And admin should see "Button a text"
    And admin should see "Button b text"
    And admin should see "Button c text"
    And admin should see  "welcome message"
    
  Scenario: select a comment and expect to see that comments on selected comment and the home page
    When admin go to site_preference
    And I check "batch_action_item_1"

  Scenario: select two comments and one of them should be on the home page

# End Iter 3-1