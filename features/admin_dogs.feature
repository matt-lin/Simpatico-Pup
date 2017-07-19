# Iter 2
Feature: View detailed imformation of all dogs 
  As an administrator 
  I want to check the details of every registered dog
  So that I can find the corresponding breeder and user 
  
  Background: Logged in and dogs have been added to the database
    Given I login as an admin
    And the following breeders exist:
      | name    | city     | state  |
      | Carl    | Berkeley | CA     |

    Given the following comments exist:
      | breed_1 			| breed_2 		 | breeder_responsibility | overall_health | trainability | social_behavior | energy_level | simpatico_rating | comments 						  | breeder_id 	   |
      | German Short Hair   | None 			 | 4 					  | 5 			   | 5 			  | 4 				| 5 		   | 5 				  | The greatest dog I've ever owned. | 1 |
      | Siberian Husky    | None 			 | 1 					  | 2 			   | 3 			  | 2 				| 1 		   | 2 				  | The worst dog I've ever owned.    | 1 |
      
  Scenario: login and expect to see dog information
    When admin go to dogs
    Then I should see all of:
      | Thor      |
      | Carl      |
      | Berkeley  |
      | CA        |
      | German Short Hair  |
      | Siberian Husky     |
      | The greatest dog I've ever owned. |
      | The worst dog I've ever owned.    |
    
  Scenario: click a dog's name should see its details
    When admin go to dogs
    And I follow "Thor"
    Then I should see all of:
      | PUP NAME |
      | BREEDER RESPONSIBILITY |
      | BREEDER  |
      | Carl  |
      | USER  |
      | YEAR  |
  
  Scenario: click a username should see its details
    When admin go to dogs
    And I follow "Testing User"
    Then I should see all of:
      | Testing User |
      | EMAIL |
      | testing@berkeley.edu  |
      | DOG NAME |
      | Thor  |
    
# End for Iter 2