# Iter 2-1 Dog page validation (By Gung Hiu Ho, Licong Wang)
@javascript
Feature: View detailed imformation of all dogs 
  As an administrator 
  I want to check the details of every registered dog
  So that I can find the corresponding breeder and user 
  
  Background: Logged in and dogs have been added to the database
    Given the default layout exist
    Given I login as an admin
    Given I am on the "Admin Dashboard" page
    
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
  
  Scenario: click a username should see its details
    When admin go to dogs
    And I follow "Testing User"
    Then I should see all of:
      | Testing User |
      | EMAIL |
      | testing@berkeley.edu  |
      | DOG NAME |
      | Thor  |
  
  Scenario: click delete and accept should delete dog and increment removed_reviews count
    When admin go to dogs
    And I follow "Delete"
    And a confirmation box saying "Are you sure you want to delete this?" should pop up
    And I accept confirmation dialogs
    Then I should not see "Siberian Husky"
    When admin go to breeders
    And I should see "1"
    
# End for Iter 2-1