@javascript
Feature: Filter autofill response by breeder city and state

  As a prospective dog owner
  So that I can quickly find breeders in my area
  I want to be able to filter breeders by there city and state

  Background: breeders have been added to the database
    Given the following breeders exist:
      | name            | city     | state  |
      | Carl            | Berkeley | CA     |
      | Chris           | Berkeley | CA     |
      | Alex            | Richmond | CA     |
      | Alexander       | New York | NY     |
      | Michael Jackson | Boston   | MA     |
      | George Michael  | Fresno   | CA     |
      | George W. Bush  | Waco     | TX     |
    And I am on the RateMyPup home page
    And I click ".button-c"

  Scenario: searching for a breeder with city and state
    When I enter "George", "Waco", "TX" into breeder search
    Then I should see "George W. Bush"
    And I should not see "Alex"

  Scenario: search for a breeder without city and state
    When I enter "George", "", "" into breeder search
    Then I should see "George W. Bush"

  Scenario: search for a breeder with only state
    When I enter "C", "", "CA" into breeder search
    Then I should see "Carl"
