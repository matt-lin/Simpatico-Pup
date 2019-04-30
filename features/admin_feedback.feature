Feature: View feedback of Simpatico Pup
  As an administrator
  I want to check the feedback on my site
  So that I know what users think of the features on my site

  Background: Logged in and feedback has been added to the database
    Given the default layout exist
    Given I login as an admin

    Given the following feedback exist:
      | id | rate_dog | breed_rating | breeder_rating | search_breeder | forum | open_response |
      | 1  | 1        | 2            | 3              | 4              | 4     | great!        |

  Scenario: Login and look at site feedback page
    When admin go to feedbacks
    Then I should see the page title "Feedbacks"
    Then I should see a table with id "index_table_feedbacks"
