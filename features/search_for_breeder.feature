@javascript
Feature: display average rating of breeder along with corresponding reviews

    As a prospective dog owner
    So that I can quickly see what owners think of a specific breeder
    I want to be able to search for a specific dog breeder's ratings

Background: reviews have been added to the database

    Given the following ratings exist:
    | breed_1 			| breed_2 		 | breeder_responsibility | overall_health | trainability | social_behavior | energy_level | simpatico_rating | comments 						  |
    | German Short Hair | None  		 | 4 					  | 5 			   | 5 			  | 4 				| 5 		   | 5 				  | The greatest dog I've ever owned. |
    | German Short Hair | None 			 | 2 					  | 3 			   | 3 			  | 3 				| 5 		   | 4 				  | Incredibly high energy and strong.|
    | German Short Hair | None 			 | 3 					  | 4 			   | 4 			  | 5 				| 4 		   | 2 				  | Very aloof. 					  |
    | Vizsla 			| None  		 | 5 					  | 5 			   | 5 			  | 4 				| 5 		   | 5 				  | Super chiller dog.                |
    | Vizsla 			| None 			 | 4 					  | 3 			   | 3 			  | 3 				| 5 		   | 4 				  | Incredibly high energy and strong.|
    | Vizsla 			| None  		 | 3 					  | 4 			   | 4 			  | 5 				| 4 		   | 2 				  | Very aloof. 					  |
    | Poodle 			| Cocker Spaniel | 4 					  | 5 			   | 5 			  | 4 				| 5 		   | 5 				  | Another great dog.                |
    | Poodle 			| Cocker Spaniel | 2 					  | 3 			   | 3 			  | 3 				| 5 		   | 4 				  | Incredibly high energy and strong.|
    | Shiba Inu 	  	| None 			 | 3 					  | 4 			   | 4 			  | 5 				| 4 		   | 2 				  | Such review. Wow. 				  |

    And I am on the RateMyPup home page
    And I click ".button-c"

# Scenario: searching for a breeder
#     When I enter "George W. Bush" into autocomplete "breeder_find" with "keyup"
#     And I follow "George W. Bush"
#     Then I should see "3.33"
#     And I should see "The greatest dog I've ever owned"
#     And I should see "Super chiller dog."
#     And I should see "Another great dog."