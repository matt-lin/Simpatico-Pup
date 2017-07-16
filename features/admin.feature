#########################################################
### Test info: 
### 1. 
### 2. disable set_title in before_filter[application_controller:5]
##########################################################

Feature: An admin should be able to edit, delete, and change comments

  As an admin to RateMyPup
  So that I can maintain my website
  I want to be able to edit, delete, and change comments

  Background: there needs to be ratings in the database
    Given the following ratings exist:
      | breed_1 			| breed_2 		 | breeder_responsibility | overall_health | trainability | social_behavior | energy_level | simpatico_rating | comments 						  | breeder_id 	   |
      | German Short Hair   | Cocker Spaniel 			 | 4 					  | 5 			   | 5 			  | 4 				| 5 		   | 5 				  | The greatest dog I've ever owned. | 2              |
      | German Short Hair   | None 			 | 2 					  | 3 			   | 3 			  | 3 				| 5 		   | 4 				  | Incredibly high energy and strong.| 3              |
      | German Short Hair   | None 			 | 3 					  | 4 			   | 4 			  | 5 				| 4 		   | 2 				  | Very aloof. 					  | 1              |
      | Vizsla 			    | None 			 | 5 					  | 5 			   | 5 			  | 4 				| 5 		   | 5 				  | The greatest dog I've ever owned. | 2              |
      | Vizsla 			    | None  		 | 4 					  | 3 			   | 3 			  | 3 				| 5 		   | 4 				  | Incredibly high energy and strong.| 3              |
      | Vizsla 			    | None 			 | 3 					  | 4 			   | 4 			  | 5 				| 4 		   | 2 				  | Very aloof. 					  | 1              |
      | Poodle 			    | Cocker Spaniel | 4 					  | 5 			   | 5 			  | 4 				| 5 		   | 5 				  | The greatest dog I've ever owned. | 2              |
      | Poodle 			    | Cocker Spaniel | 2 					  | 3 			   | 3 			  | 3 				| 5 		   | 4 				  | Incredibly high energy and strong.| 3              |
      | Shiba Inu 	  	    | None 			 | 3 					  | 4 			   | 4 			  | 5 				| 4 		   | 2 				  | Such review. Wow. 				  | 1              |
    And I am on the RateMyPup home page

  Scenario: A user that is an admin should be able to see the admin page button and go to the admin page home
    Given I login as an admin
<<<<<<< HEAD
    #And I click "pups"
=======
    # And I click "pups"
>>>>>>> master
