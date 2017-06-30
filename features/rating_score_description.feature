@javascript
Feature: Add description to rating display page for each score

    As a user, for better understanding of the meaning of each score
    I should see some description besides the scores.

  Background: breeders have been added to the database

    Given I am on the "Create New Pup" page

    Scenario: The descriptions of scores should be present on the page
      And I should see all of:
        | "Poor Breeder Responsibility"               |
        | "Excellent Breeder Responsibility"          |
        | "Excellent Social Behavior: Friendly toward all dogs, other pets and people" |
        | "N/A"|