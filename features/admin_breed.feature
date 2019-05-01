Feature: View breeds of Simpatico Pup
  As an administrator
  I want to check the breeds on my site
  So that I know breed information on my site

  Background: Logged in and dogs have been added to the database
    Given the default layout exist
    Given I login as an admin

    Given the following breeds exist:
      | id | name   |
      | 1  | Puggle |
      | 2  | Poodle |

  Scenario: Login and look at breeds page
    When admin go to breeds
    Then I should see the page title "Breeds"
    Then I should see a table with id "index_table_breeds"
    And I should see a table header with "Id"
    And I should see a table header with "Name"
    Then there should be 3 "tr" tags
    And I should see a table row with id "breed_1"
    And I should see a table row with id "breed_2"
    And I should see a table row with id "1" and name "Puggle"
    And I should see a table row with id "2" and name "Poodle"
