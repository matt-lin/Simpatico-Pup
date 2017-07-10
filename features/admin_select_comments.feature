#Newly added feature file for Iter1-1.

Feature: choose comments from all suer comments
  As an administrator 
  I want to select appropiate comments at user comments page and sent them to selected comments page
  So that I can display them on the home page
  
  Background:
    Given the following comments exist:
    | breed_1 			| breed_2 		 | breeder_responsibility | overall_health | trainability | social_behavior | energy_level | simpatico_rating | comments 						  | breeder_id 	   |
    | German Short Hair | None 			 | 4 					  | 5 			   | 5 			  | 4 				| 5 		   | 5 				  | The greatest dog I've ever owned. | 2 |
   
  Scenario: login and expect to see a user comments
    Given I login as an admin
    When admin go to user_comments
    Then admin should see "Testing User"
    And admin should see "The greatest dog I've ever owned"
    
  Scenario: select a comment and expect to see that comments on selected comment and the home page
    Given I login as an admin
    When admin go to user_comments
    And I check "batch_action_item_1"
    And admin toggle the collection selection
    Then I should see the batch action button
    Then I submit the batch action form with "approve"
    When admin go to selected_comments
    Then I should see "The greatest dog I've ever owned"
    Given I am on the RateMyPup home page
    Then I should see "Featured Comment"
    Then I should see "Testing User"
    And I should see "The greatest dog I've ever owned"
    
#End of this feature file