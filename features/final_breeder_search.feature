@javascript
Feature: Allow searching by only city, state, or breed

  As a prospective dog owner
  So that I can quickly breeders in my area or of a specific breed
  I want to be able to filter breeders by there city, state, or breed

  Background: breeders have been added to the database
    Given the default layout exist
    Given the following breeders exist:
      | name            | city     | state  |
      | George W. Bush  | Waco     | TX     |
      | Carl            | Berkeley | CA     |
      | Chris           | Berkeley | CA     |
      | Alex            | Richmond | CA     |
      | Alexander       | New York | NY     |
      | Michael Jackson | Boston   | MA     |
      | George Michael  | Fresno   | CA     |

    And I am on the RateMyPup home page
    And I click ".button-c"
    And the following ratings exist with breeders:
      | breed_1 			| breed_2 		 | breeder_responsibility | overall_health | trainability | social_behavior | energy_level | simpatico_rating | comments 						  | breeder_id 	   |
      | German Short Hair | None 			 | 4 					  | 5 			   | 5 			  | 4 				| 5 		   | 5 				  | The greatest dog I've ever owned. | 2 |
      | German Short Hair | None 			 | 2 					  | 3 			   | 3 			  | 3 				| 5 		   | 4 				  | Incredibly high energy and strong.| 3  |
      | German Short Hair | None 			 | 3 					  | 4 			   | 4 			  | 5 				| 4 		   | 2 				  | Very aloof. 					  | 1   |
      | Vizsla 			| None 			 | 5 					  | 5 			   | 5 			  | 4 				| 5 		   | 5 				  | The greatest dog I've ever owned. | 2 |
      | Vizsla 			| None 			 | 4 					  | 3 			   | 3 			  | 3 				| 5 		   | 4 				  | Incredibly high energy and strong.| 3  |
      | Vizsla 			| None 			 | 3 					  | 4 			   | 4 			  | 5 				| 4 		   | 2 				  | Very aloof. 					  | 1   |
      | Poodle 			| Cocker Spaniel | 4 					  | 5 			   | 5 			  | 4 				| 5 		   | 5 				  | The greatest poodle ever.         | 2 |
      | Poodle 			| Cocker Spaniel | 2 					  | 3 			   | 3 			  | 3 				| 5 		   | 4 				  | Great dog.                        | 3  |
      | Shiba Inu 	  	| None 			 | 3 					  | 4 			   | 4 			  | 5 				| 4 		   | 2 				  | Such review. Wow. 				  | 1   |

  Scenario: searching for a breeder with only city and state
    When I enter "", "Waco", "TX" into breeder search
    Then I should see "George W. Bush"

  Scenario: search for a breeder with only state
    When I enter "", "", "CA" into breeder search
    Then I should see all of:
      | name            |
      | George Michael  |
      | Alex            |
      | Chris           |
      | Carl            |