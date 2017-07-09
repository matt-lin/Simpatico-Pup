@javascript
Feature: choose comments from all suer comments
  As an administrator 
  I want to select appropiate comments at user comments page and sent them to selected comments page
  So that I can display them on the home page
  
  Background:
    Given the following comments exist:
    | breed_1 			| breed_2 		 | breeder_responsibility | overall_health | trainability | social_behavior | energy_level | simpatico_rating | comments 						  | breeder_id 	   |
    | German Short Hair | None 			 | 4 					  | 5 			   | 5 			  | 4 				| 5 		   | 5 				  | The greatest dog I've ever owned. | 2 |
   
  Scenario: An admin should be able to check and add user comments
    Given I login as an admin
    And I go to "user_comments"
    Then I should see "The greatest dog I've ever owned"
    Then I should see "Testing User"
    When I click "batch_action_item_1"
    Then I press a hidden button "dropdown_menu_button"
    Then I should see "Approve Selected"
    Then I click "Approve Selected"
    And I go to "selected_comments"
    Then I should see "The greatest dog I've ever owned"
     
  
  #Scenario: An admin
  