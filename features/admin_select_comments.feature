@javascript
Feature: choose comments from all suer comments
  As an administrator 
  I want to select appropiate comments at user comments page and sent them to selected comments page
  So that I can display them on the home page
  
  Background:
    Given the following ratings exist with breeders:
    | breed_1 			| breed_2 		 | breeder_responsibility | overall_health | trainability | social_behavior | energy_level | simpatico_rating | comments 						  | breeder_id 	   |
    | German Short Hair | None 			 | 4 					  | 5 			   | 5 			  | 4 				| 5 		   | 5 				  | The greatest dog I've ever owned. | 2 |
    | German Short Hair | None 			 | 2 					  | 3 			   | 3 			  | 3 				| 5 		   | 4 				  | Incredibly high energy and strong.| 3  |
    | Vizsla 			| None 			 | 5 					  | 5 			   | 5 			  | 4 				| 5 		   | 5 				  | The greatest dog I've ever owned. | 2 |
    | Vizsla 			| None 			 | 4 					  | 3 			   | 3 			  | 3 				| 5 		   | 4 				  | Incredibly high energy and strong.| 3  |
    | Vizsla 			| None 			 | 3 					  | 4 			   | 4 			  | 5 				| 4 		   | 2 				  | Very aloof. 					  | 1   |
    | Poodle 			| Cocker Spaniel | 4 					  | 5 			   | 5 			  | 4 				| 5 		   | 5 				  | The greatest poodle ever.         | 2 |
    | Poodle 			| Cocker Spaniel | 2 					  | 3 			   | 3 			  | 3 				| 5 		   | 4 				  | Great dog.                        | 3  |
    | Shiba Inu 	  	| None 			 | 3 					  | 4 			   | 4 			  | 5 				| 4 		   | 2 				  | Such review. Wow. 				  | 1   |
   
  Scenario: An admin should be able to check and add user comments
    Given I login as an admin
    Then I should see "Dashboard"
     
  
  #Scenario: An admin
  