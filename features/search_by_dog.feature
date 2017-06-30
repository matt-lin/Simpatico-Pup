@javascript
Feature: display average rating of breed along with corresponding reviews

    As a prospective dog owner
    So that I can quickly see what characteristics a specific dog has
    I want to be able to search for a specific dog breed's characteristics ratings

Background: reviews have been added to the database

    Given the following ratings exist:
    | breed_1 			| breed_2 		 | breeder_responsibility | overall_health | trainability | social_behavior | energy_level | simpatico_rating | comments 						  | breeder_id 	   |
    | German Short Hair | None 			 | 4 					  | 5 			   | 5 			  | 4 				| 5 		   | 5 				  | The greatest dog I've ever owned. | 2 |
    | German Short Hair | None 			 | 2 					  | 3 			   | 3 			  | 3 				| 5 		   | 4 				  | Incredibly high energy and strong.| 3  |
    | German Short Hair | None 			 | 3 					  | 4 			   | 4 			  | 5 				| 4 		   | 2 				  | Very aloof. 					  | 1   |
    | Vizsla 			| None 			 | 5 					  | 5 			   | 5 			  | 4 				| 5 		   | 5 				  | The greatest dog I've ever owned. | 2 |
    | Vizsla 			| None 			 | 4 					  | 3 			   | 3 			  | 3 				| 5 		   | 4 				  | Incredibly high energy and strong.| 3  |
    | Vizsla 			| None 			 | 3 					  | 4 			   | 4 			  | 5 				| 4 		   | 2 				  | Very aloof. 					  | 1   |
    | Poodle 			| None           | 4 					  | 5 			   | 5 			  | 4 				| 5 		   | 5 				  | The greatest poodle ever.         | 2 |
    | Poodle 			| None           | 2 					  | 3 			   | 3 			  | 3 				| 5 		   | 4 				  | Great dog.                        | 3  |
    | Shiba Inu 	  	| None 			 | 3 					  | 4 			   | 4 			  | 5 				| 4 		   | 2 				  | Such review. Wow. 				  | 1   |

    And I am on the RateMyPup home page
    And I click ".button-b"

Scenario: search for single breed of dog
    When I fill in "breed_find" with "Shiba Inu"
    And I press "Find Breed"
    Then I should see "4.0"
    And I should see "Such review. Wow."

Scenario: search for secondary breed of dog
    When I fill in "breed_find" with "Poodle"
    And I press "Find Breed"
    Then I should see "3.5"
    And I should see "4.5"
    And I should see "The greatest poodle ever."
    And I should see "Great dog."
    And I should not see "Very aloof."

Scenario: see correct number of ratings
    When I fill in "breed_find" with "Poodle"
  And I press "Find Breed"
  Then I should see "There are 2 ratings"
