Feature: View Site Analytics of Simpatico Pup
  As an administrator 
  I want to check the requests coming to my site
  So that I can know which parts of my site receive the most traffic

  Background: Logged in and dogs have been added to the database
    Given the default layout exist
    Given I login as an admin

    Given the following impressions exist:
      | id   | impressionable_type | impressionable_id | user_id | controller_name |      action_name       | view_name |                           request_hash                           |   ip_address    |           session_hash           | message |     referrer                                 |  params   |         created_at         |         updated_at         |
      |22452 | Pup                 |                   |      33 | pups            | main                   |           | 837a666674691d157b9a25e4d4baace5d83cf3d6c8cae5e055e3c960f85e9271 | 99.100.36.148   | 2b996904a0777cc4e06fe70a6fac5c50 |         | http://www.simpaticopup.com/admin/breeders/63|           | 2019-04-27 00:48:11.601667 | 2019-04-27 00:48:11.601667 |    

  Scenario: Login and look at site analysis page
    When admin go to site_analysis
    Then I should see the page title "Site Analysis"
    Then I should see a div with id "user"
    And I should see a div with id "subscriber_trending"
    And I should see a div with id "user_activity"
    And I should see a div with id "pup_creation"
    And I should see a div with id "age_saturation"
    And I should see a div with id "breeder_responsibility"
    And I should see a div with id "overall_health"
    And I should see a div with id "trainability"
    And I should see a div with id "social_behavior"
    And I should see a div with id "energy_level"
    And I should see a div with id "overall_rating"
    And I should see a div with id "breeder_creation"
    And I should see a div with id "request_distribution"
    And I should see a div with id "request_handled"
    And I should see a div with id "storage_space_distribution"
