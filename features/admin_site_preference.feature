# Iter 3-1 Validate the functionality of site preference page in admin page (by Gung Hiu Ho, Licong Wang) 
Feature: edit the content for the main page
  As an administrator 
  I want to change and edit the text in site preference pageW
  So that I can edit content in main the page on admin page
  
  Background: Given I login as an admin
  
  Given the default layout exist
  And I login as an admin
   
  Scenario: login and expect to see editable texts
    When admin go to customizes
    Then I should see all of:
      | Name         |
      | Site_Name    |
      | Content      |
      | SimpaticoPup |
      | Location     |
      | site_title   |
      | edit         |
    
  Scenario: Change the website title and apply the change on the main page
    When admin go to customizes
    And I follow "Edit"
    And I fill in "customize_content" with "PupSimpatico"
    And I press "Submit"
    And I should see "The content has been modified"
    When I go to the RateMyPup home page
    Then I should see "PupSimpatico"
    And I should not see "SimpaticoPup"

  Scenario: Change the primary title message and apply the change on the main page
    When admin go to customizes/2/edit
    When I fill in "customize_content" with "Greatest Way to Find the Greatest Dog"
    And  I press "Submit"
    Then I should see "The content has been modified"
    And I should see "The content has been modified"
    When I go to the RateMyPup home page
    Then I should see "Greatest Way to Find the Greatest Dog"
    And I should not see "Better Way to Find a Great Dog"

# End Iter 3-1